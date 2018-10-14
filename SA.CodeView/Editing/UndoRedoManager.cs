using System;
using System.Collections.Generic;

namespace SA.CodeView.Editing
{
	class UndoRedoManager
	{
		private UndoRedoOperation CurrentOperation;
		private readonly Stack<UndoRedoOperation> Operations;
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

			StartNewUndoRedoOperation();
		}

		public void Undo()
		{
			switch (CurrentOperation.Type)
			{
				case UndoRedoOperationType.Insert:
					Doc[CurrentOperation.Line].Text = Doc[CurrentOperation.Line].Text.Remove(CurrentOperation.StartChar, CurrentOperation.Length);
					this.Viewer.Caret.MoveToPos(CurrentOperation.Line, CurrentOperation.StartChar, true);
					break;
				case UndoRedoOperationType.CaretReturn:
					if (Operations.Count > 0)
					{
						CurrentOperation = Operations.Pop();
						Viewer.Caret.MoveToPos(CurrentOperation.Line, CurrentOperation.StartChar, true);
						EditingController.ProcessDeleteKey();
					}
					break;
				case UndoRedoOperationType.Remove:
					Viewer.Caret.MoveToPos(CurrentOperation.Line, CurrentOperation.StartChar, true);
					EditingController.PasteText(CurrentOperation.Text);
					break;
				default:
					throw new NotSupportedException();
			}
			if (Operations.Count > 0)
				CurrentOperation = Operations.Pop();
			else
				StartNewUndoRedoOperation();
		}

		public void ProcessChar()
		{
			if (CurrentOperation.Type != UndoRedoOperationType.Insert || Caret.Line != CurrentOperation.Line || Caret.Char != CurrentOperation.EndChar)
			{
				SaveCurrentOperationToStack();
				StartNewUndoRedoOperation();
			}
			CurrentOperation.EndChar++;
		}

		private void SaveCurrentOperationToStack()
		{
			if (CurrentOperation.Type == UndoRedoOperationType.Insert)
				CurrentOperation.Text = Doc[CurrentOperation.Line].Text.Substring(CurrentOperation.StartChar, CurrentOperation.Length);
			Operations.Push(CurrentOperation);
		}

		private void StartNewUndoRedoOperation()
		{
			CurrentOperation = new UndoRedoOperation()
			{
				Type = UndoRedoOperationType.Insert,
				StartChar = Viewer.Caret.Char,
				Line = Viewer.Caret.Line,
				EndChar = Viewer.Caret.Char,
			};
		}

		public void ProcessEnterKey()
		{
			SaveCurrentOperationToStack();
			CurrentOperation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.CaretReturn,
				Line = Viewer.Caret.Line,
				StartChar = Viewer.Caret.Char,
				EndChar = Viewer.Caret.Char,
			};
			SaveCurrentOperationToStack();
		}

		public void ProcessBackspaceKey()
		{
			SaveCurrentOperationToStack();
			CurrentOperation = new UndoRedoOperation
			{
				Type = UndoRedoOperationType.Remove,
				Line = Viewer.Caret.Line,
				StartChar = Viewer.Caret.Char,
				EndChar = Viewer.Caret.Char,
			};
			if (!Viewer.SelectionExists)
				CurrentOperation.Text = Viewer.Caret.Char > 0 ? Doc[Viewer.Caret.Line].Text[Viewer.Caret.Char - 1].ToString() : "\r\n";
			else
				CurrentOperation.Text = Viewer.SelectionText;
		}
	}
}
