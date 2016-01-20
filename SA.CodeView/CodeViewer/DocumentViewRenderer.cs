using System;
using System.Drawing;
using System.Windows.Forms;

namespace SA.CodeView
{
	/// <summary>Render the document view.</summary>
	public class DocumentViewRenderer
	{
		readonly CodeViewer Viewer;
		readonly CodeViewerBody Body;
		//=========================================================================================
		private SolidBrush _BackgroundBrush;
		private SolidBrush BackgroundBrush
		{
			get
			{
				if (this._BackgroundBrush == null)
					this._BackgroundBrush = new SolidBrush(this.Viewer.BackColor);

				return this._BackgroundBrush;
			}
		}
		//=========================================================================================
		private SolidBrush _ActiveLineBrush;
		private SolidBrush ActiveLineBrush
		{
			get
			{
				if (this._ActiveLineBrush == null)
					this._ActiveLineBrush = new SolidBrush(Color.FromArgb(255, 255, 255, 225));

				return this._ActiveLineBrush;
			}
		}
		//=========================================================================================
		public DocumentViewRenderer(CodeViewer viewer)
		{
			this.Viewer = viewer;
			this.Body = this.Viewer.Body;
			this.Viewer.BackColorChanged += new EventHandler(Viewer_BackColorChanged);
		}
		//=========================================================================================
		private void Viewer_BackColorChanged(object sender, EventArgs e)
		{
			this._BackgroundBrush = new SolidBrush(this.Viewer.BackColor);
		}
		//=========================================================================================
		public void Dispose()
		{
			if (this._BackgroundBrush != null)
				this._BackgroundBrush.Dispose();
		}
		//=========================================================================================
		internal void RenderView(Graphics g)
		{
			g.FillRectangle(SystemBrushes.Window, this.Body.ClientRectangle);

			if (this.Viewer.ShowMargin)
			{
				this.DrawMarginBackground(g);
				this.DrawLineIcons(g);
			}

			if (this.Viewer.ShowLineNumbers)
				this.DrawLineNumbers(g);

			//set the clipping region
			Rectangle r = this.Body.DisplayRectangle;
			r.X += this.Viewer.CharOffset - 1 + this.Viewer.MarginWidth;
			g.SetClip(r);

			this.DrawLinesBg(g);
			if (this.Viewer.HighlightCurrentLine && this.Body.Focused)
				this.DrawCurrentLineBackground(g);
			this.DrawSpansBackground(g);
			this.DrawSelectedTextBackground(g);
			this.DrawLinesOfDocument(this.Body.DisplayRectangle.Location, g);
		}
		//=========================================================================================
		private void DrawCurrentLineBackground(Graphics g)
		{
			Brush oBrush = this.ActiveLineBrush;
			int row = this.Body.Caret.Line - this.Body.FirstVisibleRow;
			Rectangle r = new Rectangle(
				this.Viewer.CharOffset + this.Viewer.MarginWidth,
				this.Viewer.CharHeight * row,
				this.Body.ClientRectangle.Width,
				this.Viewer.CharHeight);
			g.FillRectangle(oBrush, r);
			if (row > 0)
				g.DrawLine(SystemPens.ControlDark, r.Left, r.Top, r.Right, r.Top);
			g.DrawLine(SystemPens.ControlDark, r.Left, r.Bottom, r.Right, r.Bottom);
		}
		//=========================================================================================
		private void DrawLinesBg(Graphics g)
		{
			if (this.Viewer.DrawingLineBackgroundColorsEnabled)
			{
				for (int i = 0; i < this.Body.VisibleRowsCount; i++)
				{
					Brush oBrush = null;
					int row = this.Body.FirstVisibleRow + i;
					if (row < this.Viewer.Document.Count)
						oBrush = this.Viewer.Document[row].BackBrush;

					if (oBrush == null)
						oBrush = this.BackgroundBrush;

					g.FillRectangle(oBrush,
							this.Viewer.CharOffset + this.Viewer.MarginWidth,
							this.Viewer.CharHeight * i,
							this.Body.ClientRectangle.Width, this.Viewer.CharHeight);
				}
			}
		}
		//=========================================================================================
		private void DrawMarginBackground(Graphics g)
		{
			g.FillRectangle(SystemBrushes.Control, 0, 0, CodeViewer.MARGIN_STANDARD_WIDTH, this.Body.ClientRectangle.Height);
		}
		//=========================================================================================
		private void DrawLineIcons(Graphics g)
		{
			if (this.Viewer == null || this.Viewer.ImageList == null || this.Viewer.ImageList.Images.Count == 0)
				return;

			int iMax = Math.Min(this.Body.VisibleRowsCount, this.Viewer.Document.Count - this.Body.FirstVisibleRow);

			for (int i = 0; i < iMax; i++)
			{
				int iLineIndex = this.Body.FirstVisibleRow + i;
				if (iLineIndex >= this.Viewer.Document.Count)
					return;

				if (this.Viewer.Document[iLineIndex].ImageIndex == -1)
					continue;

				if (this.Viewer.Document[iLineIndex].ImageIndex >= this.Viewer.ImageList.Images.Count)
					continue;

				const int x = 2;
				int y = i * this.Viewer.CharHeight;

				g.DrawImage(this.Viewer.ImageList.Images[this.Viewer.Document[iLineIndex].ImageIndex], x, y);
			}
		}
		//=========================================================================================
		private void DrawLineNumbers(Graphics g)
		{
			int x = this.Viewer.MarginWidth;
			g.DrawLine(this.Viewer.PenGrayDot, x, 0, x, this.Body.Height);

			Rectangle r = new Rectangle(2, 0, this.Viewer.MarginWidth, this.Viewer.CharHeight);
			int iMax = Math.Min(this.Body.VisibleRowsCount, this.Viewer.Document.Count - this.Body.FirstVisibleRow);
			for (int i = 0; i < iMax; i++)
			{
				int iNumber = this.Body.FirstVisibleRow + i + 1;
				r.Y = i * this.Viewer.CharHeight;
				TextRenderer.DrawText(g, iNumber.ToString(), this.Body.Font, r, Color.Gray, TextFormatFlags.Right);
			}
		}
		//=========================================================================================
		private void DrawLinesOfDocument(Point offset, Graphics g)
		{
			if (this.Viewer.Tokens == null || this.Viewer.Tokens.Count == 0)
				return;
			//If there are no selection then draw all tokens with its native color
			if (this.Body.Caret.Point.CompareTo(this.Body.SelectionStart) == 0 || !this.Body.Focused)
			{
				for (int i = this.Body.FirstVisibleToken; i <= this.Body.LastVisibleToken; i++)
					if (this.Viewer.Tokens != null && this.Viewer.Tokens.Count > 0 && i < this.Viewer.Tokens.Count)
					{
						var oToken = this.Viewer.Tokens[i];
						Point point = this.Body.GetXYByTextPoint(oToken.Start);
						point.Offset(offset);
						Color color;
						if (oToken.Style == null)
							color = SystemColors.WindowText;
						else
							color = oToken.Style.ForeColor;
						this.DrawText(g, oToken.Text, oToken.Start.Col, point, color);
					}
			}
			else
			{
				//Draw selected text with HighlightText color
				this.DrawLinesWithSelection(offset, g);
			}
		}
		//=========================================================================================
		/// <summary>Draw selected text.</summary>
		internal void DrawLinesWithSelection(Point offset, Graphics g)
		{
			//Find start and end of selection
			TextPoint oFirst, oSecond;
			if (this.Body.Caret.Point < this.Body.SelectionStart)
			{
				oFirst = this.Body.Caret.Point;
				oSecond = this.Body.SelectionStart;
			}
			else
			{
				oFirst = this.Body.SelectionStart;
				oSecond = this.Body.Caret.Point;
			}

			const int I_BEFORE_SELECTION = 0;
			const int I_UNDER_SELECTION = 1;
			const int I_AFTER_SELECTION = 2;

			int iState;
			{
				//Determine position type of the first token
				var oToken = this.Viewer.Tokens[this.Body.FirstVisibleToken];
				if (oToken.Start <= oFirst)
					iState = I_BEFORE_SELECTION;
				else if (oToken.Start >= oSecond)
					iState = I_AFTER_SELECTION;
				else
					iState = I_UNDER_SELECTION;
			}

			for (int i = this.Body.FirstVisibleToken; i <= this.Body.LastVisibleToken; i++)
			{
				var oToken = this.Viewer.Tokens[i];
				Point point = this.Body.GetXYByTextPoint(oToken.Start);
				point.Offset(offset);
				switch (iState)
				{
					case I_BEFORE_SELECTION:
						if (oToken.End <= oFirst)
							this.DrawText(g, oToken.Text, oToken.Start.Col, point, oToken.Style.ForeColor);
						else
						{
							TextPoint oTextSelectionStart;
							if (oToken.Start < oFirst)
							{
								//Unselected part of first token
								string sText = this.Viewer.Document.GetText(oToken.Start, oFirst);
								this.DrawText(g, sText, oToken.Start.Col, point, oToken.Style.ForeColor);
								oTextSelectionStart = oFirst;
							}
							else
								oTextSelectionStart = oToken.Start;

							{
								//Selected part of the token
								string sText = this.Viewer.Document.GetText(oTextSelectionStart, TextPoint.Min(oToken.End, oSecond));
								Point p = this.Body.GetXYByTextPoint(oTextSelectionStart);
								p.Offset(offset);
								this.DrawText(g, sText, oTextSelectionStart.Col, p, SystemColors.HighlightText);
							}

							if (oSecond < oToken.End)
							{
								//If there is unselected end of the token
								string sText = this.Viewer.Document.GetText(oSecond, oToken.End);
								Point p = this.Body.GetXYByTextPoint(oSecond);
								p.Offset(offset);
								this.DrawText(g, sText, oSecond.Col, p, oToken.Style.ForeColor);
							}
							iState = I_UNDER_SELECTION;
						}
						break;
					case I_UNDER_SELECTION:
						if (oToken.End <= oSecond)
							this.DrawText(g, oToken.Text, oToken.Start.Col, point, SystemColors.HighlightText);
						else
						{
							iState = I_AFTER_SELECTION;
							if (oToken.Start >= oSecond)
								this.DrawText(g, oToken.Text, oToken.Start.Col, point, oToken.Style.ForeColor);
							else
							{
								{
									//draw selected part of the token
									string sText = this.Viewer.Document.GetText(oToken.Start, TextPoint.Min(oToken.End, oSecond));
									Point p = this.Body.GetXYByTextPoint(oToken.Start);
									p.Offset(offset);
									this.DrawText(g, sText, oToken.Start.Col, p, SystemColors.HighlightText);
								}
								{
									//draw token part after selection
									string sText = this.Viewer.Document.GetText(oSecond, oToken.End);
									Point p = this.Body.GetXYByTextPoint(oSecond);
									p.Offset(offset);
									this.DrawText(g, sText, oSecond.Col, p, oToken.Style.ForeColor);
								}
							}
						}
						break;
					case I_AFTER_SELECTION:
						this.DrawText(g, oToken.Text, oToken.Start.Col, point, oToken.Style.ForeColor);
						break;
				}
			}
		}
		//=========================================================================================
		public virtual void DrawText(Graphics g, string text, int col, Point point, Color color)
		{
			if (text.IndexOf('\t') >= 0)
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				for (int i = 0; i < text.Length; i++)
				{
					if (text[i] != '\t')
					{
						sb.Append(text[i]);
						col++;
					}
					else
					{
						do
						{
							sb.Append(' ');
							col++;
						} while (col % this.Viewer._TabSize != 0);
					}
				}
				text = sb.ToString();
			}
			TextRenderer.DrawText(g, text, this.Body.Font, point, color, TextFormatFlags.PreserveGraphicsClipping);
		}
		//=========================================================================================
		private void DrawSpansBackground(Graphics g)
		{
			if (this.Viewer.Spans == null)
				return;
			foreach (TextSpan oSpan in this.Viewer.Spans)
				this.DrawSpanBackground(g, oSpan.Start, oSpan.End, oSpan.Brush, oSpan.Pen);
		}
		//=========================================================================================
		private void DrawSpanBackground(Graphics g, TextPoint start, TextPoint end, Brush brush, Pen pen)
		{
			if (start.Line != end.Line)
			{
				//first selected line
				int iLastCol = TextCaret.GetLastCol(this.Viewer.Document[start.Line].Text, this.Viewer._TabSize);
				this.DrawLineSpanBackground(g, start.Line, start.Col, iLastCol - start.Col, brush, null);
				//intermediate selected lines
				for (int i = start.Line + 1; i < end.Line; i++)
				{
					iLastCol = TextCaret.GetLastCol(this.Viewer.Document[i].Text, this.Viewer._TabSize);
					this.DrawLineSpanBackground(g, i, 0, iLastCol + 1, brush, null);
				}
				//last selected line
				this.DrawLineSpanBackground(g, end.Line, 0, end.Col, brush, null);
			}
			//if there some selected symbols
			else if (start.Col != end.Col)
				this.DrawLineSpanBackground(g, start.Line, start.Col, end.Col - start.Col, brush, pen);
		}
		//=========================================================================================
		private void DrawLineSpanBackground(Graphics g, int line, int startCol, int count, Brush brush, Pen pen)
		{
			startCol -= this.Body.FirstVisibleCol;
			int iStart = this.Viewer.CharWidth * startCol + this.Viewer.CharOffset + this.Viewer.MarginWidth;
			int iWidth = this.Viewer.CharWidth * count;
			Rectangle rect = new Rectangle(iStart, this.Viewer.CharHeight * (line - this.Body.FirstVisibleRow), iWidth, this.Viewer.CharHeight);
			if (brush != null)
				g.FillRectangle(brush, rect);
			if (pen != null)
			{
				rect.X--;
				rect.Height--;
				g.DrawRectangle(pen, rect);
			}
		}
		//=========================================================================================
		private void DrawSelectedTextBackground(Graphics g)
		{
			Brush brush = this.Body.Focused ? SystemBrushes.Highlight : SystemBrushes.Control;
			TextPoint start, end;
			if (this.Body.SelectionStart > this.Body.Caret.Point)
			{
				start = this.Body.Caret.Point;
				end = this.Body.SelectionStart;
			}
			else
			{
				start = this.Body.SelectionStart;
				end = this.Body.Caret.Point;
			}
			this.DrawSpanBackground(g, start, end, brush, null);
		}
		//=========================================================================================
	}
}
