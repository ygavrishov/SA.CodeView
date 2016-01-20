using System;

namespace SA.CodeView
{
	/// <summary>Find and selected specified text part in the document</summary>
	public class TextFinder
	{
		/// <summary>Assosiated text viewer</summary>
		private readonly CodeViewer Viewer;
		/// <summary>What should be found</summary>
		private string FindText;
		private bool MatchCase;
		private bool MatchWord;
		private StringComparison comparisionMode;
		//=========================================================================================
		public TextFinder(CodeViewer viewer)
		{
			this.Viewer = viewer;
		}
		//=========================================================================================
		/// <summary>Find and select next fragment</summary>
		public void FindNext(string text, bool matchCase, bool matchWord)
		{
			this.FindText = text;
			this.MatchCase = matchCase;
			this.MatchWord = matchWord;
			this.comparisionMode = this.MatchCase ? StringComparison.InvariantCulture : StringComparison.InvariantCultureIgnoreCase;

			//Start search from caret position
			int iStartLine = this.Viewer.Caret.Line;
			int iStartCol = this.Viewer.Caret.Col;

			if (this.FindInLine(iStartLine, iStartCol))
				return;

			for (int index = iStartLine + 1; index < this.Viewer.Document.Count; index++)
				if (this.FindInLine(index, 0))
					return;
		}
		//=========================================================================================
		private bool FindInLine(int line, int col)
		{
			int iStartCol = col;
			while (iStartCol + this.FindText.Length < this.Viewer.Document[line].Text.Length)
			{
				int iCharPos = this.Viewer.Document[line].Text.IndexOf(this.FindText, iStartCol, this.comparisionMode);

				if (iCharPos < 0)
					return false;

				if (!this.MatchWord)
				{
					SelectFindText(line, iCharPos);
					return true;
				}

				//if MatchWord option is enabled then check the fragment bounds
				if (iCharPos > 0)
				{
					//check left bound
					char leftChar = this.Viewer.Document[line].Text[iCharPos - 1];
					if (Char.IsLetterOrDigit(leftChar))
					{
						iStartCol = iCharPos + this.FindText.Length;
						continue;
					}
				}

				//check right bound
				if (iCharPos + this.FindText.Length < this.Viewer.Document[line].Text.Length - 1)
				{
					char rightChar = this.Viewer.Document[line].Text[iCharPos + this.FindText.Length];
					if (Char.IsLetterOrDigit(rightChar))
					{
						iStartCol = iCharPos + this.FindText.Length;
						continue;
					}
				}

				//select fragment
				SelectFindText(line, iCharPos);
				return true;
			}

			//fragment was not found
			return false;
		}
		//=========================================================================================
		/// <summary>Make specified text fragment selected</summary>
		/// <param name="line">Number of line with the text</param>
		/// <param name="startCharPos">start position of the text</param>
		private void SelectFindText(int line, int startCharPos)
		{
			int iColPos = this.Viewer.Caret.GetColumn(this.Viewer.Document[line].Text, startCharPos);
			this.Viewer.Caret.MoveToPos(line, iColPos, true);
			this.Viewer.Caret.MoveToPos(line, iColPos + this.FindText.Length, false);
			this.Viewer.ScrollIntoView();
			this.Viewer.Focus();
		}
		//=========================================================================================
	}
}
