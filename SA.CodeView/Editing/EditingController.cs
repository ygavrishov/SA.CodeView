using System.Text;
using System.Windows.Forms;
using SA.CodeView.Utils;

namespace SA.CodeView.Editing
{
	/// <summary>Modifies text document by keyboard events processing.</summary>
	class EditingController
	{
		/// <summary>Current caret position.</summary>
		TextPoint CurPos;
		/// <summary>Current text line of document.</summary>
		private string CurLine;
		TextPoint SelectionStart;

		/// <summary>Last keyboard event args</summary>
		private KeyEventArgs KeyDownEventArgs;
		internal ClipboardProxyClass ClipboardProxy;

		readonly CodeViewer Viewer;
		readonly Document Doc;
		private readonly UndoRedoManager UndoRedoManager;
		//=========================================================================================
		public EditingController(CodeViewer viewer)
		{
			this.Viewer = viewer;
			this.Doc = viewer.Document;
			UndoRedoManager = new UndoRedoManager(viewer, this);
		}
		//=========================================================================================
		private void InitTokens()
		{
			var sb = new StringBuilder();
			foreach (DocumentLine oLine in this.Viewer.Document)
				sb.AppendLine(oLine.Text);

			this.Viewer.InitTokens(sb.ToString());
		}
		//=========================================================================================
		private void InitFields()
		{
			this.CurPos = this.Viewer.Caret.Point;
			this.SelectionStart = this.Viewer.Body.SelectionStart;
			this.CurLine = this.Doc[CurPos.Line].Text;
		}
		//=========================================================================================
		public bool ProcessChar(char c)
		{
			if (c != '\t')
			{
				var category = char.GetUnicodeCategory(c);
				if (category == System.Globalization.UnicodeCategory.Control)
					return false;
			}
			UndoRedoManager.ProcessChar();

			this.InitFields();
			this.DeleteSelection();
			this.InitFields();

			this.Doc[CurPos.Line].Text = this.CurLine.Insert(CurPos.Char, c.ToString());
			this.Viewer.Caret.MoveRight(true);
			this.InitTokens();
			return true;
		}
		//=========================================================================================
		public bool ProcessKey(KeyEventArgs e)
		{
			this.KeyDownEventArgs = e;
			this.InitFields();

			switch (e.KeyCode)
			{
				case Keys.V:
					if (e.Control)
						return this.PasteFromClipboard();
					break;
				case Keys.C:
				case Keys.X:
					if (e.Control)
						if (!this.CopyToClipboard(e.KeyCode == Keys.X))
							return false;
					break;
				case Keys.Z:
					if (e.Control)
						UndoRedoManager.Undo();
					break;
				case Keys.Delete:
					this.ProcessDeleteKey();
					break;
				case Keys.Back:
					this.ProcessBackspaceKey();
					break;
				case Keys.Enter:
					this.ProcessEnterKey();
					break;
				default:
					return false;
			}

			this.InitTokens();
			return true;
		}

		//=========================================================================================
		private void ProcessEnterKey()
		{
			UndoRedoManager.ProcessEnterKey();

			int iCurPosChar = this.CurPos.Char;
			if (iCurPosChar < this.CurLine.Length)
				this.Doc[CurPos.Line].Text = this.CurLine.Remove(iCurPosChar);
			this.Doc.Insert(CurPos.Line + 1, this.CurLine.Substring(iCurPosChar));
			this.Viewer.Caret.MoveRight(true);
		}
		//=========================================================================================
		private void ProcessBackspaceKey()
		{
			UndoRedoManager.ProcessDeletion(true);

			if (!this.HasSelection())
			{
				if (this.KeyDownEventArgs.Control)
					this.Viewer.Caret.MoveWordLeft(false);
				else
					this.Viewer.Caret.MoveLeft(false);
				this.InitFields();
			}
			else
				if (this.KeyDownEventArgs.Control)
			{
				this.Viewer.Caret.MoveWordLeft(false);
				this.InitFields();
			}

			this.DeleteSelection();
		}
		//=========================================================================================
		internal void ProcessDeleteKey()
		{
			UndoRedoManager.ProcessDeletion(false);

			if (!this.HasSelection())
			{
				if (this.KeyDownEventArgs.Control)
					this.Viewer.Caret.MoveWordRight(false);
				else if (this.KeyDownEventArgs.Shift)
				{
					this.ProcessShiftDelete();
					return;
				}
				else
					this.Viewer.Caret.MoveRight(false);
				this.InitFields();
			}
			else
				if (this.KeyDownEventArgs.Control)
			{
				this.Viewer.Caret.MoveWordRight(false);
				this.InitFields();
			}

			this.DeleteSelection();
		}
		//=========================================================================================
		private void ProcessShiftDelete()
		{
			if (this.Doc.Count > 1)
			{
				if (this.CurPos.Line < this.Doc.Count - 1)
				{
					this.Doc.RemoveAt(this.CurPos.Line);
					this.Viewer.Caret.MoveToPos(this.CurPos.Line, this.CurPos.Col, true);
				}
				else
				{
					this.Doc[this.CurPos.Line].Text = string.Empty;
					this.Viewer.Caret.MoveLineHome();
				}
			}
			else
			{
				this.Doc[0].Text = string.Empty;
				this.Viewer.Caret.MoveDocHome(true);
			}
		}
		//=========================================================================================
		private void DeleteSelection()
		{
			//Determine start and end of selection
			TextPoint pStart, pEnd;
			if (this.SelectionStart > this.CurPos)
			{
				pStart = this.CurPos;
				pEnd = this.SelectionStart;
			}
			else
			{
				pStart = this.SelectionStart;
				pEnd = this.CurPos;
			}
			DeleteText(pStart, pEnd);
			this.Viewer.Caret.MoveToPos(pStart.Line, pStart.Col, true);
		}

		private void DeleteText(TextPoint startPos, TextPoint endPos)
		{
			if (startPos.Line == endPos.Line)
			{
				string sLine = this.Doc[startPos.Line].Text;
				this.Doc[startPos.Line].Text = sLine.Remove(startPos.Char, endPos.Char - startPos.Char);
			}
			else
			{
				//Find last line ending
				string sEndLine = this.Doc[endPos.Line].Text.Substring(endPos.Char);
				//Delete unnecessary lines
				this.Doc.RemoveRange(startPos.Line + 1, endPos.Line - startPos.Line);
				//Create result text
				string sStartLine = this.Doc[startPos.Line].Text;
				if (startPos.Char < sStartLine.Length)
					sStartLine = sStartLine.Remove(startPos.Char);
				this.Doc[startPos.Line].Text = sStartLine + sEndLine;
			}
		}

		//=========================================================================================
		bool HasSelection()
		{
			return this.SelectionStart.CompareTo(this.CurPos) != 0;
		}
		//=========================================================================================
		internal bool PasteFromClipboard()
		{
			if (this.ClipboardProxy == null)
				this.ClipboardProxy = ClipboardProxyClass.Self;
			if (!this.ClipboardProxy.ContainsText())
				return false;

			this.PasteText(this.ClipboardProxy.GetText());
			this.InitTokens();
			this.Viewer.Body.Invalidate(false);
			return true;
		}
		//=========================================================================================
		internal void PasteText(string text)
		{
			this.InitFields();
			if (this.HasSelection())
			{
				this.DeleteSelection();
				this.InitFields();
			}

			var lines = TextSplitter.SplitTextToLines(text);
			if (lines.Count == 1)
			{
				string sLine = this.CurLine.Insert(this.CurPos.Char, text);
				this.Doc[this.CurPos.Line].Text = sLine;
				int iChar = this.CurPos.Char + text.Length;
				int iCol = this.Viewer.Caret.GetColumn(sLine, iChar);
				this.Viewer.Caret.MoveToPos(this.CurPos.Line, iCol, true);
			}
			else
			{
				string sLine = this.CurLine;
				if (sLine.Length > 0 && this.CurPos.Char < sLine.Length)
					sLine = sLine.Remove(this.CurPos.Char);
				this.Doc[this.CurPos.Line].Text = sLine + lines[0];
				lines.RemoveAt(0);

				int iChar = lines[lines.Count - 1].Length;
				lines[lines.Count - 1] += this.CurLine.Substring(this.CurPos.Char);
				this.Doc.InsertRange(this.CurPos.Line + 1, lines);

				int iLine = this.CurPos.Line + lines.Count;
				string sLastPastedLine = this.Doc[iLine].Text;
				int iCol = this.Viewer.Caret.GetColumn(sLastPastedLine, iChar);
				this.Viewer.Caret.MoveToPos(iLine, iCol, true);
			}
		}
		//=========================================================================================
		internal bool CopyToClipboard(bool deleteSelection)
		{
			if (!this.HasSelection())
				return false;

			//Determine start and end of selection
			TextPoint pStart, pEnd;
			if (this.SelectionStart > this.CurPos)
			{
				pStart = this.CurPos;
				pEnd = this.SelectionStart;
			}
			else
			{
				pStart = this.SelectionStart;
				pEnd = this.CurPos;
			}

			var sb = new StringBuilder();
			if (pStart.Line == pEnd.Line)
			{
				string sLine = this.Doc[pStart.Line].Text;
				sb.Append(sLine.Substring(pStart.Char, pEnd.Char - pStart.Char));
			}
			else
			{
				//first line
				sb.AppendLine(this.Doc[pStart.Line].Text.Substring(pStart.Char));
				//intermediate lines
				for (int iLine = pStart.Line + 1; iLine < pEnd.Line; iLine++)
					sb.AppendLine(this.Doc[iLine].Text);
				//last line
				string sLastLine = this.Doc[pEnd.Line].Text;
				if (pEnd.Char < sLastLine.Length)
					sLastLine = sLastLine.Remove(pEnd.Char);
				sb.Append(sLastLine);
			}
			if (this.ClipboardProxy == null)
				this.ClipboardProxy = ClipboardProxyClass.Self;
			try { this.ClipboardProxy.SetText(sb.ToString()); }
			catch (System.Runtime.InteropServices.ExternalException) { }

			if (deleteSelection)
				this.DeleteSelection();
			return true;
		}
		//=========================================================================================
	}
}
