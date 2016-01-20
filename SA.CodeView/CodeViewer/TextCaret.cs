using System;
using SA.CodeView.Utils;

namespace SA.CodeView
{
	public class TextCaret
	{
		//=========================================================================================
		#region Public Fields and Properties
		/// <summary>Текущая позиция в строке.</summary>
		public int Col { get { return _Point.Col; } }
		/// <summary>Текущая позиция в строке.</summary>
		public int Char { get { return _Point.Char; } }
		/// <summary>Текущая строка.</summary>
		public int Line { get { return _Point.Line; } }
		/// <summary>Текущее положение каретки (строка и позиция) в тексте.</summary>
		public TextPoint Point { get { return _Point; } }
		/// <summary>Каретка отображена.</summary>
		internal bool Blink;
		//=========================================================================================
		internal int TokenIndex
		{
			get
			{
				if (!this._CurrentToken_Is_Valid)
				{
					this.DeterminCurrentToken();
					this._CurrentToken_Is_Valid = true;
				}
				return _CurrentTokenIndex;
			}
		}
		//=========================================================================================
		internal CaretLocationType RegardingToken
		{
			get
			{
				if (!this._CurrentToken_Is_Valid)
				{
					this.DeterminCurrentToken();
					this._CurrentToken_Is_Valid = true;
				}
				return _RegardingToken;
			}
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		private Document Doc;
		readonly CodeViewerBody Parent;
		/// <summary>Current position(line and position) in text document.</summary>
		TextPoint _Point;
		/// <summary>Position in line that should be applied if line length is appropriate.</summary>
		int _WantedCol;
		bool _CurrentToken_Is_Valid;
		int _CurrentTokenIndex;
		CaretLocationType _RegardingToken;
		//=========================================================================================
		internal TextCaret(CodeViewerBody parent)
		{
			this.Parent = parent;
			if (this.Parent != null)
				this.Doc = parent.Viewer.Document;
		}
		//=========================================================================================
		internal void InitLines(Document doc)
		{
			this.Doc = doc;
		}
		//=========================================================================================
		public void MoveDown(int linesCount, bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			int iLine = this._Point.Line + linesCount;
			if (iLine >= this.Doc.Count)
				iLine = this.Doc.Count - 1;


			int iCol, iChar;
			string sLine = this.Doc[iLine].Text;
			int iLineLen = GetLastCol(sLine, this.Parent.Viewer._TabSize);
			if (this._WantedCol >= iLineLen)
			{
				iCol = iLineLen;
				iChar = sLine.Length;
			}
			else
			{
				iChar = this.GetChar(sLine, this._WantedCol, CharSearchingMode.Before);
				iCol = this.GetColumn(sLine, iChar);
			}
			this.SetCaretPos(iLine, iChar, iCol, false, clearSelection);
		}
		//=========================================================================================
		public void MoveUp(int linesCount, bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			int iLine = this._Point.Line - linesCount;
			if (iLine < 0)
				iLine = 0;

			string sLine = this.Doc[iLine].Text;
			int iLineLen = GetLastCol(sLine, this.Parent.Viewer._TabSize);
			int iChar, iCol;
			if (this._WantedCol >= iLineLen)
			{
				iCol = iLineLen;
				iChar = sLine.Length;
			}
			else
			{
				iChar = this.GetChar(sLine, this._WantedCol, CharSearchingMode.Before);
				iCol = this.GetColumn(sLine, iChar);
			}
			this.SetCaretPos(iLine, iChar, iCol, false, clearSelection);
		}
		//=========================================================================================
		public void MoveLeft()
		{
			this.MoveLeft(true);
		}
		//=========================================================================================
		public void MoveLeft(bool clearSelection)
		{
			this.MoveLeft(MovementType.Char, clearSelection);
			if (clearSelection)
				this.Parent.SelectionStart = this._Point;
		}
		//=========================================================================================
		public void MoveWordLeft()
		{
			this.MoveWordLeft(true);
		}
		//=========================================================================================
		public void MoveWordLeft(bool clearSelection)
		{
			this.MoveLeft(MovementType.Word, clearSelection);
			if (clearSelection)
				this.Parent.SelectionStart = this._Point;
		}
		//=========================================================================================
		public void MoveRight()
		{
			this.MoveRight(true);
		}
		//=========================================================================================
		public void MoveRight(bool clearSelection)
		{
			this.MoveRight(MovementType.Char, clearSelection);
		}
		//=========================================================================================
		public void MoveWordRight()
		{
			this.MoveWordRight(true);
		}
		//=========================================================================================
		public void MoveWordRight(bool clearSelection)
		{
			this.MoveRight(MovementType.Word, clearSelection);
		}
		//=========================================================================================
		public void MoveDocHome(bool clearSelection)
		{
			this.SetCaretPos(0, 0, 0, true, clearSelection);

			if (clearSelection)
				this.Parent.SelectionStart = this._Point;
		}
		//=========================================================================================
		public void MoveDocHome()
		{
			this.MoveDocHome(true);
		}
		//=========================================================================================
		public void MoveLineHome()
		{
			this.MoveLineHome(true);
		}
		//=========================================================================================
		public void MoveLineHome(bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome(clearSelection);
				return;
			}
			int iLine = this._Point.Line;
			string sLine = this.Doc[iLine].Text;
			string sTrimmedLine = sLine.TrimStart();
			int iDiffCount = sLine.Length - sTrimmedLine.Length;

			int iChar;
			if (iDiffCount == 0)
				iChar = 0;
			else
			{
				if (this._Point.Char != iDiffCount)
					iChar = iDiffCount;
				else
					iChar = 0;
			}
			int iCol = this.GetColumn(sLine, iChar);
			this.SetCaretPos(iLine, iChar, iCol, true, clearSelection);

			if (clearSelection)
				this.Parent.SelectionStart = this._Point;
		}
		//=========================================================================================
		public void MoveDocEnd(bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			int iLine = this.Doc.Count - 1;
			string sLine = this.Doc[iLine].Text;
			int iChar = sLine.Length;
			int iCol = GetLastCol(sLine, this.Parent.Viewer._TabSize);
			this.SetCaretPos(iLine, iChar, iCol, true, clearSelection);

			if (clearSelection)
				this.Parent.SelectionStart = this.Point;
		}
		//=========================================================================================
		public void MoveLineEnd(bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			string sLine = this.Doc[this._Point.Line].Text;
			int iChar = sLine.Length;
			int iCol = GetLastCol(sLine, this.Parent.Viewer._TabSize);
			this.SetCaretPos(this._Point.Line, iChar, iCol, true, clearSelection);
		}
		//=========================================================================================
		public void MoveToPos(int line, int col, bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}

			int iLine, iCol, iChar;
			if (line < 0)
				iLine = 0;
			else if (line >= this.Doc.Count)
				iLine = this.Doc.Count - 1;
			else
				iLine = line;

			string sLine = this.Doc[iLine].Text;
			if (col <= 0)
			{
				iCol = 0;
				iChar = 0;
			}
			else
			{
				iChar = this.GetChar(sLine, col, CharSearchingMode.Near);
				iCol = this.GetColumn(sLine, iChar);
			}
			this.SetCaretPos(iLine, iChar, iCol, true, clearSelection);
		}
		//=========================================================================================
		#region Служебный код
		//=========================================================================================
		/// <summary>Move caret to the specified position and generate event if it's need</summary>
		void SetCaretPos(int line, int chr, int col, bool changeWantedCol, bool clearSelection)
		{
			bool bPosChanged = this._Point.Line != line || this._Point.Char != chr;
			if (bPosChanged)
				this._Point = new TextPoint(line, col, chr);

			if (clearSelection)
				this.Parent.SelectionStart = this._Point;
			if (bPosChanged)
			{
				this._CurrentToken_Is_Valid = false;
				//Generate OnChangeSelection event
				this.Parent.Viewer.OnChangeSelection();
			}
			if (changeWantedCol)
				this._WantedCol = col;
		}
		//=========================================================================================
		/// <summary>find max col in specified line.</summary>
		static public int GetLastCol(string line, int tabsize)
		{
			return GetCol(line, line.Length, tabsize);
		}
		//=========================================================================================
		/// <summary>Get col position by char index.</summary>
		static public int GetCol(string line, int chr, int tabsize)
		{
			int iCol = 0;
			int iLength = Math.Min(chr, line.Length);
			for (int i = 0; i < iLength; i++)
				if (line[i] == '\t')
				{
					do
						iCol++;
					while (iCol % tabsize != 0);
				}
				else
					iCol++;
			return iCol;
		}
		//=========================================================================================
		/// <summary>Get col position by char index.</summary>
		internal int GetColumn(string line, int chr)
		{
			return GetCol(line, chr, this.Parent.Viewer._TabSize);
		}
		//=========================================================================================
		/// <summary>Get char index by col position.</summary>
		internal int GetChar(string line, int col)
		{
			return GetChar(line, col, CharSearchingMode.After);
		}
		//=========================================================================================
		/// <summary>Get char index by col position.</summary>
		int GetChar(string line, int col, CharSearchingMode mode)
		{
			int iCol = 0;
			for (int i = 0; i < line.Length; i++)
			{
				int iNewCol = iCol;
				if (line[i] == '\t')
				{
					do
						iNewCol++;
					while (iNewCol % this.Parent.Viewer._TabSize != 0);
				}
				else
					iNewCol++;
				switch (mode)
				{
					case CharSearchingMode.Before:
						if (iNewCol > col)
							return i;
						break;
					case CharSearchingMode.After:
						if (iCol >= col)
							return i;
						break;
					case CharSearchingMode.Near:
						if (iNewCol > col)
						{
							if (col - iCol <= iNewCol - col)
								return i;
						}
						break;
					default:
						throw new NotSupportedException(((int)mode).ToString());
				}
				iCol = iNewCol;
			}
			return line.Length;
		}
		//=========================================================================================
		enum CharSearchingMode
		{
			Before,
			Near,
			After,
		}
		//=========================================================================================
		void MoveLeft(MovementType movementType, bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			int iCol, iChar, iLine = this._Point.Line;

			//if caret at the beginning of the line we should to move up
			if (this._Point.Char == 0)
			{
				if (iLine == 0)
					return;
				iLine--;
				string sLine = this.Doc[iLine].Text;
				iChar = sLine.Length;
				iCol = GetLastCol(sLine, this.Parent.Viewer._TabSize);
			}
			else
			{
				string sLine = this.Doc[iLine].Text;
				if (movementType == MovementType.Char)
					iChar = this._Point.Char - 1;
				else
					iChar = WordFinder.GetWordStart(sLine, this._Point.Char);
				iCol = this.GetColumn(sLine, iChar);
			}
			this.SetCaretPos(iLine, iChar, iCol, true, clearSelection);
		}
		//=========================================================================================
		void MoveRight(MovementType movementType, bool clearSelection)
		{
			if (this.Doc.Count == 0)
			{
				this.MoveDocHome();
				return;
			}
			int iLine = this._Point.Line, iChar, iCol;
			string sLine = this.Doc[iLine].Text;
			if (this._Point.Char >= sLine.Length)
			{
				if (iLine >= this.Doc.Count - 1)
					return;
				iLine++;
				iChar = 0;
			}
			else
			{
				if (movementType == MovementType.Char)
					iChar = this._Point.Char + 1;
				else
					iChar = WordFinder.GetNextWordStart(sLine, this._Point.Char);
			}
			iCol = this.GetColumn(sLine, iChar);
			this.SetCaretPos(iLine, iChar, iCol, true, clearSelection);
		}
		//=========================================================================================
		enum MovementType { Word, Char }
		//=========================================================================================
		void DeterminCurrentToken()
		{
			var tokens = this.Parent.Viewer.Tokens;
			for (int iToken = this.Parent.FirstVisibleToken; iToken < tokens.Count; iToken++)
			{
				var oToken = tokens[iToken];
				if (oToken.Start.Line == this.Line)
					if (oToken.End.Char >= this.Char)
					{
						if (oToken.End.Char == this.Char)
						{
							this._CurrentTokenIndex = iToken;
							this._RegardingToken = CaretLocationType.WordEnd;
						}
						else if (oToken.Start.Char < this.Char)
						{
							this._CurrentTokenIndex = iToken;
							this._RegardingToken = CaretLocationType.WordCenter;
						}
						else if (oToken.Start.Char == this.Char)
						{
							this._CurrentTokenIndex = iToken;
							this._RegardingToken = CaretLocationType.WordStart;
						}
						else
						{
							this._CurrentTokenIndex = iToken - 1;
							this._RegardingToken = CaretLocationType.BetweenWords;
						}
						return;
					}
			}
			if (tokens.Count > 0)
			{
				int iLastTokenIndex = tokens.Count - 1;
				var oToken = tokens[iLastTokenIndex];
				if (this.Point > oToken.Start)
				{
					this._CurrentTokenIndex = iLastTokenIndex;
					this._RegardingToken = CaretLocationType.BetweenWords;
					return;
				}
			}
			this._CurrentTokenIndex = -1;
			this._RegardingToken = CaretLocationType.WordStart;
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		internal void MovePrevSpan()
		{
			TextSpan PrevSpan = null;
			foreach (TextSpan TSpan in this.Parent.Viewer.Spans)
			{
				if (this._Point.Line > TSpan.Start.Line)
				{
					if (PrevSpan == null || (this._Point.Line - TSpan.Start.Line < this._Point.Line - PrevSpan.Start.Line))
						PrevSpan = TSpan;
				}
			}
			if (PrevSpan != null)
				this.SetCaretPos(PrevSpan.Start.Line, PrevSpan.Start.Char, PrevSpan.Start.Col, true, true);
		}
		//=========================================================================================
		internal void MoveNextSpan()
		{
			TextSpan PrevSpan = null;
			foreach (TextSpan TSpan in this.Parent.Viewer.Spans)
			{
				if (this._Point.Line < TSpan.Start.Line)
				{
					if (PrevSpan == null || (TSpan.Start.Line - this._Point.Line < PrevSpan.Start.Line - this._Point.Line))
						PrevSpan = TSpan;
				}
			}
			if (PrevSpan != null)
				this.SetCaretPos(PrevSpan.Start.Line, PrevSpan.Start.Char, PrevSpan.Start.Col, true, true);
		}
		//=========================================================================================
	}
}
