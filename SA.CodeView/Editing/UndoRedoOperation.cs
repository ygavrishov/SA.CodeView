namespace SA.CodeView.Editing
{
	internal enum UndoRedoOperationType
	{
		Insert,
		Remove,
		CaretReturn,
	}

	internal class UndoRedoOperation
	{
		public UndoRedoOperationType Type;
		public int StartChar;
		public int Line;
		public int EndChar;
		public string Text;
		public string PreviousText;

		public int Length => EndChar - StartChar;

		public override string ToString() => $"{Type}, {nameof(Line)}={Line}, {nameof(StartChar)}={StartChar}, {nameof(EndChar)}={EndChar}";
	}
}
