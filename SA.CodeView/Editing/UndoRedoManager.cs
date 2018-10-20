using System;
using System.Collections.Generic;

namespace SA.CodeView.Editing
{
	class UndoRedoManager
	{
		private int CurrentLine;
		private int CurrentStartChar;
		private int CurrentEndChar;
		private string PreviousText;

		private readonly Stack<UndoRedoOperation> Operations;
		private readonly Stack<UndoRedoOperation> UndoneOperations;

		private readonly CodeViewer Viewer;
		private readonly EditingController EditingController;
		private readonly TextCaret Caret;
		private readonly Document Doc;

		public UndoRedoManager(CodeViewer viewer, EditingController editingController)
		{
			Viewer = viewer;
			EditingController = editingController;
			Caret = Viewer.Caret;
			Doc = Viewer.Document;
			Operations = new Stack<UndoRedoOperation>();
			UndoneOperations = new Stack<UndoRedoOperation>();

			StartNewUndoRedoOperation();
		}

		public void Undo()
		{
			if (CurrentStartChar < CurrentEndChar)
			{
				var currentOperation = TakeCurrentTypingOperation();
				UndoTyping(currentOperation);
				UndoneOperations.Push(currentOperation);
				StartNewUndoRedoOperation();
				return;
			}

			if (Operations.Count == 0)
				return;

			var operation = Operations.Pop();
			switch (operation.Type)
			{
				case UndoRedoOperationType.Insert:
					UndoTyping(operation);
					break;
				case UndoRedoOperationType.CaretReturn:
					Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
					EditingController.ProcessDeleteKey(false);
					break;
				case UndoRedoOperationType.Remove:
					Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
					EditingController.PasteText(operation.Text);
					break;
				case UndoRedoOperationType.Paste:
					Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
					EditingController.DeleteText(operation.Line, operation.StartChar, operation.Line, operation.EndChar);
					break;
				default:
					throw new NotSupportedException();
			}
			UndoneOperations.Push(operation);
			StartNewUndoRedoOperation();
		}

		public void Redo()
		{
			SaveCurrentOperationToStack(false);

			if (UndoneOperations.Count == 0)
				return;

			var operation = UndoneOperations.Pop();
			switch (operation.Type)
			{
				case UndoRedoOperationType.Insert:
				case UndoRedoOperationType.CaretReturn:
					Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
					Viewer.Caret.MoveToPos(operation.Line, operation.EndChar, false);
					EditingController.PasteText(operation.Text);
					StartNewUndoRedoOperation();
					Operations.Push(operation);
					break;
				case UndoRedoOperationType.Remove:
					Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
					EditingController.DeleteText(operation.Line, operation.StartChar, operation.Line, operation.EndChar);
					break;
				case UndoRedoOperationType.Paste:
				default:
					throw new NotSupportedException();
			}
		}

		public void ProcessChar()
		{
			string selectionText = Viewer.SelectionText;

			if (selectionText.Length > 0 ||
				Caret.Line != CurrentLine || Caret.Char != CurrentEndChar)
			{
				var operation = SaveCurrentOperationToStack();
				PreviousText = selectionText;
			}
			CurrentEndChar++;
		}

		public void ProcessEnterKey()
		{
			SaveCurrentOperationToStack();
			var operation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.CaretReturn,
				Line = Viewer.Caret.Line,
				StartChar = Viewer.Caret.Char,
				EndChar = Viewer.Caret.Char,
				Text = "\r\n"
			};
			Operations.Push(operation);
		}

		public void ProcessDeletion(bool backward)
		{
			SaveCurrentOperationToStack();
			var operation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.Remove,
				Line = Viewer.Caret.Line,
				StartChar = Viewer.Caret.Char,
				EndChar = Viewer.Caret.Char,
			};
			if (!Viewer.SelectionExists)
			{
				if (backward)
					operation.Text = Viewer.Caret.Char > 0 ? Doc[Viewer.Caret.Line].Text[Viewer.Caret.Char - 1].ToString() : "\r\n";
				else
				{
					if (Viewer.Caret.Char < Doc[Viewer.Caret.Line].Text.Length)
						operation.Text = Doc[Viewer.Caret.Line].Text[Viewer.Caret.Char].ToString();
					else
						operation.Text = "\r\n";
				}
			}
			else
				operation.Text = Viewer.SelectionText;
			Operations.Push(operation);
		}

		public void ProcessPaste(int startLine, int startChar, string text)
		{
			var operation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.Paste,
				Line = startLine,
				StartChar = startChar,
				Text = Viewer.Text,
				EndChar = Caret.Char,
				PreviousText = PreviousText,
			};
			Operations.Push(operation);
			StartNewUndoRedoOperation();
		}

		public void ProcessCut()
		{
			SaveCurrentOperationToStack();
			var operation = TakeCurrentTypingOperation();
			operation.EndChar = GetSelectionBoundary(false).Char;
			operation.Type = UndoRedoOperationType.Remove;
			operation.Text = Viewer.SelectionText;
			Operations.Push(operation);
		}

		private UndoRedoOperation SaveCurrentOperationToStack(bool cleanUndoneOperations = true)
		{
			UndoRedoOperation operation;
			if (CurrentStartChar != CurrentEndChar)
			{
				operation = TakeCurrentTypingOperation();
				Operations.Push(operation);
			}
			else
				operation = null;

			if (cleanUndoneOperations)
				UndoneOperations.Clear();

			StartNewUndoRedoOperation();
			return operation;
		}

		private void UndoTyping(UndoRedoOperation operation)
		{
			Doc[operation.Line].Text = Doc[operation.Line].Text.Remove(operation.StartChar, operation.Length);
			this.Viewer.Caret.MoveToPos(operation.Line, operation.StartChar, true);
			if (!string.IsNullOrEmpty(operation.PreviousText))
				EditingController.PasteText(operation.PreviousText);
		}

		private UndoRedoOperation TakeCurrentTypingOperation()
		{
			UndoRedoOperation operation;
			string text = Doc[CurrentLine].Text.Substring(CurrentStartChar, CurrentEndChar - CurrentStartChar);
			operation = new UndoRedoOperation
			{
				Line = CurrentLine,
				StartChar = CurrentStartChar,
				EndChar = CurrentEndChar,
				Text = text,
				Type = UndoRedoOperationType.Insert,
				PreviousText = PreviousText
			};
			return operation;
		}

		private void StartNewUndoRedoOperation()
		{
			TextPoint startPoint = GetSelectionBoundary(true);
			CurrentLine = startPoint.Line;
			CurrentEndChar = CurrentStartChar = startPoint.Char;
			PreviousText = null;
		}

		private TextPoint GetSelectionBoundary(bool first)
		{
			var startPoint = Viewer.Body.SelectionStart;
			var caretPos = Caret.Point;

			if (first)
				return TextPoint.Min(startPoint, caretPos);
			else
				return TextPoint.Max(startPoint, caretPos);
		}
	}
}
