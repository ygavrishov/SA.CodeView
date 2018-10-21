using System;
using System.Collections.Generic;

namespace SA.CodeView.Editing
{
	class UndoRedoManager
	{
		private int CurrentStartLine;
		private int CurrentStartChar;
		private int CurrentEndLine;
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
					Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
					EditingController.ProcessDeleteKey(false);
					break;
				case UndoRedoOperationType.Remove:
					Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
					EditingController.PasteText(operation.Text);
					break;
				case UndoRedoOperationType.Paste:
					Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
					EditingController.DeleteText(operation.StartLine, operation.StartChar, operation.EndLine, operation.EndChar);
					if (!string.IsNullOrEmpty(operation.PreviousText))
						EditingController.PasteText(operation.PreviousText);
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
				case UndoRedoOperationType.Paste:
					Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
					Viewer.Caret.MoveToPos(operation.EndLine, operation.EndChar, false);
					EditingController.PasteText(operation.Text);
					StartNewUndoRedoOperation();
					Operations.Push(operation);
					break;
				case UndoRedoOperationType.Remove:
					Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
					EditingController.DeleteText(operation.StartLine, operation.StartChar, operation.EndLine, operation.EndChar);
					break;
				default:
					throw new NotSupportedException();
			}
		}

		public void ProcessChar()
		{
			string selectionText = Viewer.SelectionText;

			if (selectionText.Length > 0 ||
				Caret.Line != CurrentEndLine || Caret.Char != CurrentEndChar)
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
				StartLine = Viewer.Caret.Line,
				StartChar = Viewer.Caret.Char,
				EndLine = Viewer.Caret.Line,
				EndChar = Viewer.Caret.Char,
				Text = "\r\n"
			};
			Operations.Push(operation);
		}

		public void ProcessDeletion(bool backward)
		{
			SaveCurrentOperationToStack();

			var start = Viewer.GetSelectionBoundary(true);
			var end = Viewer.GetSelectionBoundary(false);
			var operation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.Remove,
				StartLine = start.Line,
				StartChar = start.Char,
				EndLine = end.Line,
				EndChar = end.Char,
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

		public void ProcessPaste(int startLine, int startChar, string text, string previousText)
		{
			SaveCurrentOperationToStack();
			var operation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.Paste,
				StartLine = startLine,
				StartChar = startChar,
				Text = text,
				EndLine = Caret.Line,
				EndChar = Caret.Char,
				PreviousText = previousText,
			};
			Operations.Push(operation);
			StartNewUndoRedoOperation();
		}

		public void ProcessCut()
		{
			SaveCurrentOperationToStack();
			var operation = TakeCurrentTypingOperation();
			operation.EndChar = Viewer.GetSelectionBoundary(false).Char;
			operation.Type = UndoRedoOperationType.Remove;
			operation.Text = Viewer.SelectionText;
			Operations.Push(operation);
		}

		private UndoRedoOperation SaveCurrentOperationToStack(bool cleanUndoneOperations = true)
		{
			UndoRedoOperation operation;
			if (CurrentStartChar != CurrentEndChar || CurrentStartLine != CurrentEndLine)
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
			Doc[operation.StartLine].Text = Doc[operation.StartLine].Text.Remove(operation.StartChar, operation.EndChar - operation.StartChar);
			this.Viewer.Caret.MoveToPos(operation.StartLine, operation.StartChar, true);
			if (!string.IsNullOrEmpty(operation.PreviousText))
				EditingController.PasteText(operation.PreviousText);
		}

		private UndoRedoOperation TakeCurrentTypingOperation()
		{
			UndoRedoOperation operation;
			string text = Doc.GetText(CurrentStartLine, CurrentStartChar, CurrentEndLine, CurrentEndChar);
			operation = new UndoRedoOperation
			{
				StartLine = CurrentStartLine,
				StartChar = CurrentStartChar,
				EndLine = CurrentEndLine,
				EndChar = CurrentEndChar,
				Text = text,
				Type = UndoRedoOperationType.Insert,
				PreviousText = PreviousText
			};
			return operation;
		}

		private void StartNewUndoRedoOperation()
		{
			TextPoint startPoint = Viewer.GetSelectionBoundary(true);
			CurrentEndLine = CurrentStartLine = startPoint.Line;
			CurrentEndChar = CurrentStartChar = startPoint.Char;

			PreviousText = null;
		}
	}
}
