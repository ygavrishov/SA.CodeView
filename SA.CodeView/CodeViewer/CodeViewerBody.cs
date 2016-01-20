/*****************************
 * TODO: Копирование в буфер текста в rtf
 *****************************/
using System;
using System.ComponentModel;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using SA.CodeView.Utils;

namespace SA.CodeView
{
	class CodeViewerBody : UserControl
	{
		//=========================================================================================
		DocumentViewRenderer Renderer;
		internal TextPoint SelectionStart;
		public TextCaret Caret;
		internal int FirstVisibleCol = 0;
		internal int FirstVisibleRow = 0;
		internal int VisibleRowsCount = 0;
		internal int VisibleColsCount = 0;
		internal int FirstVisibleToken;
		internal int LastVisibleToken;
		//=========================================================================================
		/// <summary>timer for blinking caret.</summary>
		private Timer timerCaret;
		/// <summary>time for smooth scrolling for drag operation.</summary>
		private Timer timerDragScroll;
		private IContainer components = null;
		VScrollBar _VerticalScroll;
		HScrollBar _HorizontalScroll;
		internal new VScrollBar VerticalScroll { get { return this._VerticalScroll; } }
		internal new HScrollBar HorizontalScroll { get { return this._HorizontalScroll; } }
		ScrollBars _ScrollBars = ScrollBars.Both;
		internal CodeViewer Viewer;
		//=========================================================================================
		public new event EventHandler TextChanged;
		void OnTextChanged()
		{
			if (this.TextChanged != null)
				this.TextChanged(this, EventArgs.Empty);
		}
		//=========================================================================================
		#region Public properties
		//=========================================================================================
		public ScrollBars ScrollBars
		{
			get { return _ScrollBars; }
			set
			{
				this._ScrollBars = value;
				switch (this._ScrollBars)
				{
					case ScrollBars.Both:
						this._VerticalScroll.Location = new Point(this.Width - this._VerticalScroll.Width, 0);
						this._VerticalScroll.Height = this.Height - this._HorizontalScroll.Height;
						this._HorizontalScroll.Location = new Point(0, this.Height - this._HorizontalScroll.Height);
						this._HorizontalScroll.Width = this.Width - this._VerticalScroll.Width;
						this._HorizontalScroll.Visible = true;
						this._VerticalScroll.Visible = true;
						break;
					case ScrollBars.Horizontal:
						this._HorizontalScroll.Location = new Point(0, this.Height - this._HorizontalScroll.Height);
						this._HorizontalScroll.Width = this.Width;
						this._HorizontalScroll.Visible = true;
						this._VerticalScroll.Visible = false;
						break;
					case ScrollBars.Vertical:
						this._VerticalScroll.Location = new Point(this.Width - this._VerticalScroll.Width, 0);
						this._VerticalScroll.Height = this.Height;
						this._HorizontalScroll.Visible = false;
						this._VerticalScroll.Visible = true;
						break;
					case ScrollBars.None:
						this._HorizontalScroll.Visible = false;
						this._VerticalScroll.Visible = false;
						break;
				}
				this.InitVisibleArea();
			}
		}
		//=========================================================================================
		public TextPoint CurrentPosition
		{
			get { return this.Caret.Point; }
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		protected override void Dispose(bool disposing)
		{
			if (disposing && components != null)
				components.Dispose();
			base.Dispose(disposing);
		}
		//=========================================================================================
		#region Component Designer generated code

		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.timerCaret = new System.Windows.Forms.Timer(this.components);
			this._VerticalScroll = new System.Windows.Forms.VScrollBar();
			this._HorizontalScroll = new System.Windows.Forms.HScrollBar();
			this.SuspendLayout();
			// 
			// timerCaret
			// 
			this.timerCaret.Interval = 500;
			// 
			// VScroller
			// 
			this._VerticalScroll.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Right)));
			this._VerticalScroll.Cursor = System.Windows.Forms.Cursors.Arrow;
			this._VerticalScroll.Location = new System.Drawing.Point(171, 0);
			this._VerticalScroll.Name = "VScroller";
			this._VerticalScroll.Size = new System.Drawing.Size(17, 171);
			this._VerticalScroll.TabIndex = 0;
			this._VerticalScroll.Visible = false;
			// 
			// HScroller
			// 
			this._HorizontalScroll.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this._HorizontalScroll.Cursor = System.Windows.Forms.Cursors.Arrow;
			this._HorizontalScroll.Location = new System.Drawing.Point(0, 171);
			this._HorizontalScroll.Name = "HScroller";
			this._HorizontalScroll.Size = new System.Drawing.Size(171, 17);
			this._HorizontalScroll.TabIndex = 1;
			this._HorizontalScroll.Visible = false;
			// 
			// CodeViewerBody
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
			this.Controls.Add(this._HorizontalScroll);
			this.Controls.Add(this._VerticalScroll);
			this.Cursor = System.Windows.Forms.Cursors.IBeam;
			this.Name = "CodeViewerBody";
			this.Size = new System.Drawing.Size(188, 188);
			this.ResumeLayout(false);

		}

		#endregion
		//=========================================================================================
		public CodeViewerBody()
		{
			this.InitializeComponent();
			try
			{
				this.Font = new System.Drawing.Font("Consolas", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			}
			catch { }

			this.SetStyle(
				ControlStyles.DoubleBuffer | ControlStyles.UserPaint |
				ControlStyles.AllPaintingInWmPaint | ControlStyles.ResizeRedraw,
				true);
			this.LinkHandlers();
		}
		//=========================================================================================
		internal void SetOwner(CodeViewer viewer)
		{
			this.Viewer = viewer;
			this.Caret = new TextCaret(this);
			this.Renderer = new DocumentViewRenderer(viewer);
		}
		//=========================================================================================
		internal void InitLines(Document doc)
		{
			this.Caret.InitLines(doc);
			this.FirstVisibleRow = 0;
			this.InitScrollBars(true);
			this.ChangeVisibleTokenList();
			this.Invalidate(false);
		}
		//=========================================================================================
		private void LinkHandlers()
		{
			this.timerCaret.Tick += new EventHandler(timerCaret_Tick);
			this._VerticalScroll.ValueChanged += new EventHandler(VScroller_ValueChanged);
			this._HorizontalScroll.ValueChanged += new EventHandler(HScroller_ValueChanged);
		}
		//=========================================================================================
		internal void ScrollIntoView()
		{
			int iBeforeRowsCount = this.VisibleRowsCount > 1 ? 2 : 1;
			if (this.Caret.Line < this.FirstVisibleRow)
				this.FirstVisibleRow = this.Caret.Line;
			else if (this.Caret.Line >= this.FirstVisibleRow + this.VisibleRowsCount - 1)
				this.FirstVisibleRow = this.Caret.Line - this.VisibleRowsCount + iBeforeRowsCount;
			this._VerticalScroll.Value = this.TryGetScrollValue(this._VerticalScroll, this.FirstVisibleRow * this.Viewer.CharHeight);
			
			if (this.Caret.Col < this.FirstVisibleCol)
				this.FirstVisibleCol = this.Caret.Col;
			else if (this.Caret.Col >= this.FirstVisibleCol + this.VisibleColsCount - 1)
				this.FirstVisibleCol = this.Caret.Col - this.VisibleColsCount + 2;
			this._HorizontalScroll.Value = this.TryGetScrollValue(this._HorizontalScroll, this.FirstVisibleCol * this.Viewer.CharWidth);
		}
		//=========================================================================================
		private int TryGetScrollValue(ScrollBar scrollBar, int value)
		{
			if (value <= scrollBar.Minimum)
				return scrollBar.Minimum;
			else if (value >= scrollBar.Maximum)
				return scrollBar.Maximum;
			else
				return value;
		}
		//=========================================================================================
		private TextPoint GetTextPointByXY(Point p)
		{
			int iLine = (p.Y - this.DisplayRectangle.Y) / this.Viewer.CharHeight + this.FirstVisibleRow;
			int iCol = (int)((p.X - this.DisplayRectangle.X - this.Viewer.MarginWidth) / this.Viewer.CharWidth) + this.FirstVisibleCol;
			return new TextPoint(iLine, iCol, iCol);
		}
		//=========================================================================================
		public Point GetXYByTextPoint(TextPoint pos)
		{
			int x = (pos.Col - this.FirstVisibleCol) * this.Viewer.CharWidth + this.Viewer.MarginWidth;
			int y = (pos.Line - this.FirstVisibleRow) * this.Viewer.CharHeight;
			return new Point(x, y);
		}
		//=========================================================================================
		void timerCaret_Tick(object sender, EventArgs e)
		{
			this.Caret.Blink = !this.Caret.Blink;
			this.Invalidate(false);
		}
		//=========================================================================================
		protected override void OnPaint(PaintEventArgs e)
		{
			this.ChangeVisibleTokenList();

			this.Renderer.RenderView(e.Graphics);

			if (this.Caret.Blink)
			{
				//Draw caret
				Point point = this.GetXYByTextPoint(Caret.Point);
				point.X += this.Viewer.CharOffset;
				e.Graphics.DrawLine(SystemPens.WindowText, point.X, point.Y, point.X, point.Y + this.Viewer.CharHeight);
			}

			if (this.VerticalScroll.Visible &&
				this.HorizontalScroll.Visible)
			{
				Rectangle r = new Rectangle(
					this.VerticalScroll.Left,
					this.HorizontalScroll.Top,
					this.HorizontalScroll.Width,
					this.VerticalScroll.Height);
				e.Graphics.FillRectangle(SystemBrushes.Control, r);
			}
		}
		//=========================================================================================
		protected override void OnHandleCreated(EventArgs e)
		{
			this.InitVisibleArea();
			base.OnHandleCreated(e);
		}
		//=========================================================================================
		protected override void OnGotFocus(EventArgs e)
		{
			this.timerCaret.Start();
			this.Invalidate(false);
			base.OnGotFocus(e);
		}
		//=========================================================================================
		protected override void OnLostFocus(EventArgs e)
		{
			this.timerCaret.Stop();
			this.Caret.Blink = false;
			this.Invalidate(false);
			base.OnLostFocus(e);
		}
		//=========================================================================================
		protected override bool IsInputKey(System.Windows.Forms.Keys keyData)
		{
			keyData &= ~(Keys.Shift | Keys.Control);
			switch (keyData)
			{
				case Keys.Up:
				case Keys.Down:
				case Keys.Right:
				case Keys.Left:
				case Keys.PageDown:
				case Keys.PageUp:
				case Keys.End:
				case Keys.Home:
					//case Keys.Enter:
					//case Keys.Tab:
					return true;
				case Keys.Enter:
				case Keys.Escape:
					if (this.Viewer.CodeCompletor != null && this.Viewer.CodeCompletor.IsVariantsVisible)
						return true;
					break;
				case Keys.Tab:
					return this.Viewer.AcceptsTab;
			}
			return base.IsInputKey(keyData);
		}
		//=========================================================================================
		protected override bool IsInputChar(char charCode)
		{
			if (char.IsLetterOrDigit(charCode))
				return true;
			return base.IsInputChar(charCode);
		}
		//=========================================================================================
		protected override void OnKeyDown(KeyEventArgs e)
		{
			this.ProcessKey(e);
			base.OnKeyDown(e);
		}
		//=========================================================================================
		protected override void OnKeyUp(KeyEventArgs e)
		{
			base.OnKeyUp(e);
		}
		//=========================================================================================
		internal void ProcessKey(KeyEventArgs e)
		{
			if (this.Viewer.CodeCompletor != null)
				if (this.Viewer.CodeCompletor.ProcessKey(e))
					return;

			bool bClearSelection = (e.Modifiers & Keys.Shift) == 0;
			switch (e.KeyCode)
			{
				#region Caret's Navigate Buttons
				case Keys.Right:
					if ((e.Modifiers & Keys.Control) == 0)
						this.Caret.MoveRight(bClearSelection);
					else
						this.Caret.MoveWordRight(bClearSelection);
					break;

				case Keys.Left:
					if ((e.Modifiers & Keys.Control) == 0)
						this.Caret.MoveLeft(bClearSelection);
					else
						this.Caret.MoveWordLeft(bClearSelection);
					break;
				case Keys.Up:
					if ((e.Modifiers & Keys.Alt) != 0)
						break;
					if ((e.Modifiers & Keys.Control) != 0)
					{
						if (e.Modifiers != Keys.Control)
							break;
						if (this._VerticalScroll.Value == 0)
							break;
						if (this.Caret.Line == this.FirstVisibleRow + this.VisibleRowsCount - 2)
						{
							this.Caret.MoveUp(1, true);
						}
						int iNewValue = this._VerticalScroll.Value - this._VerticalScroll.SmallChange;
						if (iNewValue < 0)
							break;
						this._VerticalScroll.Value = iNewValue;
						break;
					}
					this.Caret.MoveUp(1, bClearSelection);
					break;
				case Keys.Down:
					if ((e.Modifiers & Keys.Alt) != 0)
						break;
					if ((e.Modifiers & Keys.Control) != 0)
					{
						if (e.Modifiers != Keys.Control)
							break;
						if (this.Caret.Line == this.FirstVisibleRow)
							this.Caret.MoveDown(1, true);

						int iNewValue = this._VerticalScroll.Value + this._VerticalScroll.SmallChange;
						if (iNewValue > this._VerticalScroll.Maximum)
							break;
						this._VerticalScroll.Value = iNewValue;
						break;
					}
					this.Caret.MoveDown(1, bClearSelection);
					break;
				case Keys.End:
					if ((e.Modifiers & Keys.Control) != 0)
						this.Caret.MoveDocEnd(bClearSelection);
					else
						this.Caret.MoveLineEnd(bClearSelection);
					break;
				case Keys.Home:
					if ((e.Modifiers & Keys.Control) != 0)
						this.Caret.MoveDocHome(bClearSelection);
					else
						this.Caret.MoveLineHome(bClearSelection);
					break;
				case Keys.PageDown:
					if ((e.Modifiers & Keys.Control) != 0)
					{
						if (e.Modifiers != Keys.Control)
							break;
						int iLinesCount = this.VisibleRowsCount - 2 - (this.Caret.Line - this.FirstVisibleRow);
						this.Caret.MoveDown(iLinesCount, true);
						break;
					}
					this.Caret.MoveDown(this.VisibleRowsCount, bClearSelection);
					break;
				case Keys.PageUp:
					if ((e.Modifiers & Keys.Control) != 0)
					{
						if (e.Modifiers != Keys.Control)
							break;
						int iLinesCount = this.Caret.Line - this.FirstVisibleRow;
						this.Caret.MoveUp(iLinesCount, true);
						break;
					}
					this.Caret.MoveUp(this.VisibleRowsCount, bClearSelection);
					//========================================
					break;
				#endregion

				case Keys.Enter:
					TryToProcessKey(e);
					break;

				default:
					this.TryToProcessKey(e);
					return;
			}
			this.ScrollIntoView();
			this.Caret.Blink = true;
			this.Invalidate(false);
		}
		//=========================================================================================
		private void TryToProcessKey(KeyEventArgs e)
		{
			if (!this.Viewer.ReadOnly)
			{
				OnTextChanged();
				if (this.Viewer.EditController.ProcessKey(e))
				{
					this.InitScrollBars(false);
					this.Invalidate(false);
				}
			}
		}
		//=========================================================================================
		protected override void OnKeyPress(KeyPressEventArgs e)
		{
			if (this.Viewer.ReadOnly)
				return;

			this.ProcessChar(e.KeyChar);

			base.OnKeyPress(e);
		}
		//=========================================================================================
		internal void ProcessChar(char c)
		{
			if (this.Viewer.CodeCompletor == null ||
				!this.Viewer.CodeCompletor.PreProcessChar(c))
				if (this.Viewer.EditController.ProcessChar(c))
				{
					this.ScrollIntoView();
					this.InitScrollBars(false);
					this.Invalidate(false);
				}

			if (this.Viewer.CodeCompletor != null)
				this.Viewer.CodeCompletor.PostProcessChar(c);
		}
		//=========================================================================================
		protected override void OnMouseDown(MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Left)
			{
                var oSelectionPos = this.SelectionStart;
                TextPoint pos = this.GetTextPointByXY(e.Location);
				this.Caret.MoveToPos(pos.Line, pos.Col, true);
                if ((Control.ModifierKeys & Keys.Shift) == 0)
                    this.SelectionStart = this.Caret.Point;
                else
                    this.SelectionStart = oSelectionPos;
				this.Caret.Blink = true;
				this.Invalidate(false);
				this.Capture = true;
			}
			else if (e.Button == MouseButtons.Right && !this.Viewer.SelectionExists)
			{
				TextPoint pos = this.GetTextPointByXY(e.Location);
				this.Caret.MoveToPos(pos.Line, pos.Col, true);
				this.SelectionStart = this.Caret.Point;
				this.Caret.Blink = true;
				this.Invalidate(false);
			}
			base.OnMouseDown(e);
		}
		//=========================================================================================
		protected override void OnMouseUp(MouseEventArgs e)
		{
			this.Capture = false;
			if (this.timerDragScroll != null)
			{
				this.timerDragScroll.Dispose();
				this.timerDragScroll = null;
			}
			base.OnMouseUp(e);
		}
		//=========================================================================================
		protected override void OnMouseMove(MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Left && this.Capture)
			{
				if (
					(e.Y < 0 && this._VerticalScroll.Value > 0) ||
					(e.Y > this.ClientRectangle.Height && this._VerticalScroll.Value < this._VerticalScroll.Maximum)
					)
				{
					if (this.timerDragScroll == null)
					{
						this.timerDragScroll = new Timer();
						this.timerDragScroll.Interval = 100;
						this.timerDragScroll.Tick += new EventHandler(timerDragScroll_Tick);
						this.timerDragScroll.Start();
					}
				}
				else
				{
					if (this.timerDragScroll != null)
					{
						this.timerDragScroll.Dispose();
						this.timerDragScroll = null;
					}
				}
				TextPoint pos = this.GetTextPointByXY(e.Location);
				this.Caret.MoveToPos(pos.Line, pos.Col, false);
				this.Invalidate(false);
			}
			base.OnMouseMove(e);
		}
		//=========================================================================================
		protected override void OnMouseWheel(MouseEventArgs e)
		{
			int iDelta = -this._VerticalScroll.SmallChange * e.Delta / 120;
			iDelta = iDelta / this.Viewer.CharHeight * this.Viewer.CharHeight;
			int iNewValue = this._VerticalScroll.Value + iDelta;
			if (iNewValue < 0)
				iNewValue = 0;
			else
			{
				int iMax = this.GetVScrollerMax();
				if (iNewValue > iMax)
					iNewValue = iMax;
			}

			this._VerticalScroll.Value = iNewValue;
		}
		//=========================================================================================
		int GetVScrollerMax()
		{
			return this._VerticalScroll.Maximum - this._VerticalScroll.LargeChange + 1;
		}
		//=========================================================================================
		void timerDragScroll_Tick(object sender, EventArgs e)
		{
			Point pos = this.PointToClient(Control.MousePosition);
			int iScrollOffset;
			int iOffset;
			if (pos.Y < 0)
				iOffset = -pos.Y;
			else
				iOffset = pos.Y - this.ClientRectangle.Height;

			if (iOffset < 25)
				iScrollOffset = this._VerticalScroll.SmallChange;
			else if (iOffset < 50)
				iScrollOffset = 2 * this._VerticalScroll.SmallChange;
			else
				iScrollOffset = this._VerticalScroll.LargeChange;

			int iNewValue;
			if (pos.Y < 0)
			{
				iNewValue = this._VerticalScroll.Value - iScrollOffset;
				if (iNewValue < 0)
					iNewValue = 0;
			}
			else
			{
				iNewValue = this._VerticalScroll.Value + iScrollOffset;
				int iMax = this.GetVScrollerMax();
				if (iNewValue > iMax)
					iNewValue = iMax;
			}
			this._VerticalScroll.Value = iNewValue;

			TextPoint textPoint = this.GetTextPointByXY(pos);
			this.Caret.MoveToPos(textPoint.Line, textPoint.Col, false);
			this.Invalidate(false);
		}
		//=========================================================================================
		protected override void OnMouseDoubleClick(MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Left)
			{
				if (this.Viewer.Document.Count > 0)
				{
					string sLine = this.Viewer.Document[this.Caret.Line].Text;
					if (sLine.Length > 0)
					{
						int[] arrIndexes = WordFinder.GetWord(sLine, this.Caret.Char, this.Viewer._TabSize);
						int iChar = this.Caret.GetChar(sLine, arrIndexes[0]);
						this.SelectionStart.SetPos(this.Caret.Line, arrIndexes[0], iChar);
						this.Caret.MoveToPos(this.Caret.Line, arrIndexes[1], false);
					}
				}
				this.Invalidate(false);
			}
			base.OnMouseDoubleClick(e);
		}
		//=========================================================================================
		protected override void OnResize(EventArgs e)
		{
			if (this.Viewer == null)
				return;
			this.InitVisibleArea();
			base.OnResize(e);
		}
		//=========================================================================================
		void InitVisibleArea()
		{
			if (this.ChangeVisibleRowCount())
			{
				this.InitScrollBars(false);
				this.ChangeVisibleTokenList();
			}
		}
		//=========================================================================================
		void InitScrollBars(bool resetPosition)
		{
			int iMax = 0;
			foreach (DocumentLine oLine in this.Viewer.Document)
				if (oLine.Text.Length > iMax)
					iMax = oLine.Text.Length;

			this._HorizontalScroll.SmallChange = this.Viewer.CharWidth;
			this._HorizontalScroll.LargeChange = this.VisibleColsCount * this.Viewer.CharWidth;

			this._VerticalScroll.LargeChange = this.VisibleRowsCount * this.Viewer.CharHeight;
			this._VerticalScroll.SmallChange = this.Viewer.CharHeight;
			if (resetPosition)
			{
				this._VerticalScroll.Value = 0;
				this._HorizontalScroll.Value = 0;
			}
			this._VerticalScroll.Maximum = Math.Max(this.Viewer.CharHeight * (this.Viewer.Document.Count - 1) + this._VerticalScroll.LargeChange, 1);
			this._HorizontalScroll.Maximum = this.Viewer.CharWidth * (iMax + 20);

			this._HorizontalScroll.Enabled = this._HorizontalScroll.LargeChange < this._HorizontalScroll.Maximum;
			this._VerticalScroll.Enabled = this._VerticalScroll.LargeChange < this._VerticalScroll.Maximum && this.Viewer.Document.Count > 1;
		}
		//=========================================================================================
		bool ChangeVisibleRowCount()
		{
			int iWidth = this.ClientRectangle.Width - this.Viewer.MarginWidth;
			if (this._VerticalScroll.Visible)
				iWidth -= this._VerticalScroll.Width;
			if (iWidth < 0)
				iWidth = 0;

			int iHeight = this.ClientRectangle.Height;
			if (this._HorizontalScroll.Visible)
				iHeight -= this._HorizontalScroll.Height;
			if (iHeight < 0)
				iHeight = 0;

			int iNewHeight = (int)Math.Ceiling((decimal)iHeight / this.Viewer.CharHeight);
			int iNewWidth = (int)Math.Ceiling((decimal)iWidth / this.Viewer.CharWidth);
			if (iNewHeight != this.VisibleRowsCount || iNewWidth != this.VisibleColsCount)
			{
				this.VisibleColsCount = iNewWidth;
				this.VisibleRowsCount = iNewHeight;
				return true;
			}
			else
				return false;
		}
		//=========================================================================================
		void ChangeVisibleTokenList()
		{
			if (this.Viewer.Tokens == null)
			{
				this.FirstVisibleToken = 0;
				this.LastVisibleToken = 0;
				return;
			}
			int iLastRow = FirstVisibleRow + VisibleRowsCount - 1;
			int iState = 0;
			for (int i = 0; i < this.Viewer.Tokens.Count; i++)
			{
				if (iState == 0)
				{
					if (this.Viewer.Tokens[i].End.Line >= FirstVisibleRow)
					{
						FirstVisibleToken = i;
						iState = 1;
					}
				}
				else
				{
					if (this.Viewer.Tokens[i].Start.Line > iLastRow)
					{
						LastVisibleToken = i - 1;
						iState = 2;
						break;
					}
				}
			}
			if (iState == 1)
				LastVisibleToken = this.Viewer.Tokens.Count - 1;
		}
		//=========================================================================================
		void VScroller_ValueChanged(object sender, EventArgs e)
		{
			int iValue = this._VerticalScroll.Value / this.Viewer.CharHeight;
			if (this.FirstVisibleRow == iValue)
				return;
			this.FirstVisibleRow = iValue;
			this.ChangeVisibleTokenList();
			this.Invalidate();
		}
		//=========================================================================================
		void HScroller_ValueChanged(object sender, EventArgs e)
		{
			int iValue = this._HorizontalScroll.Value / this.Viewer.CharWidth;
			if (this.FirstVisibleCol == iValue)
				return;
			this.FirstVisibleCol = iValue;
			this.Invalidate();
		}
		//=========================================================================================
		internal void ResetScrollBars()
		{
			this._VerticalScroll.Value = 0;
			this.Caret.MoveDocHome();
			this.SelectionStart.SetPos(0, 0, 0);
		}
		//=========================================================================================
	}
}
