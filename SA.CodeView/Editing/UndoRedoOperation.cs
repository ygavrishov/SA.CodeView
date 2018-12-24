namespace SA.CodeView.Editing
{
	internal enum UndoRedoOperationType
	{
		Insert,
		Remove,
		CaretReturn,
		Paste
	}

	internal class UndoRedoOperation
	{
		public UndoRedoOperationType Type;
		public int StartLine;
		public int StartChar;
		public int EndLine;
		public int EndChar;
		public string Text;
		public string PreviousText;

		public override string ToString() => $"{Type}, {nameof(StartLine)}={StartLine}, {nameof(StartChar)}={StartChar}, {nameof(EndLine)}={EndLine}, {nameof(EndChar)}={EndChar}";
	}
}
