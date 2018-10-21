using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using SA.CodeView.Editing;
using SA.CodeView.IntelliSense;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;

namespace SA.CodeView
{
	/// <summary>Code viewer with syntax highlighting.</summary>
	public class CodeViewer : UserControl
	{
		internal const int MARGIN_STANDARD_WIDTH = 20;
		//=========================================================================================
		/// <summary>Can setup line background color</summary>
		public bool DrawingLineBackgroundColorsEnabled;
		//=========================================================================================
		internal int _TabSize = 4;
		/// <summary>Sets the distance in spaces between tab stops.</summary>
		[Description("Sets the distance in spaces between tab stops.")]
		[DefaultValue(4)]
		public int TabSize
		{
			get { return this._TabSize; }
			set
			{
				this._TabSize = value;
				this.InitTokens(this.Text);
				this.Body.Invalidate(false);
			}
		}
		//=========================================================================================
		/// <summary>Margin area width</summary>
		internal int MarginWidth = 0;
		internal int CharOffset { get; private set; }
		internal int CharWidth { get; private set; }
		internal int CharHeight { get; private set; }
		//=========================================================================================
		[Browsable(false)]
		public Document Document { get; private set; }
		internal EditingController EditController;
		CodeViewerBody _Body;
		bool _ShowLineNumbers;
		bool _ShowMargin;
		internal List<Token> Tokens { get; private set; }
		bool _ReadOnly = true;
		//=========================================================================================
		internal Pen PenGrayDot;
		private System.ComponentModel.IContainer components = null;
		public ImageList ImageList;
		//=========================================================================================
		internal CodeCompletor CodeCompletor { get; set; }
		//=========================================================================================
		#region Public properties
		//=========================================================================================
		/// <summary>Indicates if tab characters are accepted as input.</summary>
		[Category("Behavior")]
		[Description("Indicates if tab characters are accepted as input.")]
		[DefaultValue(false)]
		public bool AcceptsTab { get; set; }

		/// <summary>Controls whether the text in the edit control can be changed or not.</summary>
		[Category("Behavior")]
		[Description("Controls whether the text in the edit control can be changed or not.")]
		[DefaultValue(true)]
		public bool ReadOnly
		{
			get { return this._ReadOnly; }
			set
			{
				this._ReadOnly = value;
				if (!value)
					if (this.EditController == null)
						this.EditController = new EditingController(this);
			}
		}
		//=========================================================================================
		SyntaxSettings _SyntaxSettings;
		[Browsable(false)]
		public SyntaxSettings SyntaxSettings
		{
			get
			{
				if (this._SyntaxSettings == null)
					this._SyntaxSettings = SyntaxSettings.CreateSettings(this.Language);
				return this._SyntaxSettings;
			}
		}
		//=========================================================================================
		public new Font Font
		{
			get { return this.Body.Font; }
			set
			{
				this.Body.Font = value;
				this.InitFontProperties();
			}
		}
		PredefinedLanguage _Language;
		/// <summary>Programming language for which syntax highlighting will be used.</summary>
		[DefaultValue(PredefinedLanguage.None)]
		[Category("Syntax")]
		public PredefinedLanguage Language
		{
			get { return this._Language; }
			set
			{
				if (this._Language == value)
					return;

				this._Language = value;

				this._SyntaxSettings = SyntaxSettings.CreateSettings(this.Language);
				this.InitTokens(this.Text);
				this._Body.Invalidate(false);
			}
		}
		//=========================================================================================
		internal CodeViewerBody Body
		{
			get { return _Body; }
		}
		//=========================================================================================
		internal void InitTokens(string text)
		{
			var oParser = new SA.CodeView.Parsing.StateParser(this.SyntaxSettings, this._TabSize);
			this.Tokens = oParser.Parse(text);
		}
		//=========================================================================================
		public new string Text
		{
			get
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				if (this.Document != null && this.Document.Count > 0)
				{
					foreach (DocumentLine oLine in this.Document)
						sb.AppendLine(oLine.Text);
					sb.Remove(sb.Length - 2, 2);
				}
				return sb.ToString();
			}
			set
			{
				this._Body.ResetScrollBars();
				if (value == null)
					value = string.Empty;

				try
				{
					this.Document.SetText(value);
					this.Spans.Clear();
					this.DetermineMarginWidth();
					this.InitTokens(value);
					this._Body.InitLines(this.Document);
					this._Body.Invalidate(false);
				}
				catch (Exception ex)
				{
					if (!string.IsNullOrEmpty(value) && value.Length < 16384)
						ex.Data.Add("ViewerText", value);
					throw;
				}

				this.OnTextChanged();
			}
		}
		//=========================================================================================
		internal void PasteText(string text)
		{
			string sLine = this.Document[Caret.Line].Text;

			this.Document[Caret.Line].Text = sLine.Insert(Caret.Char, text);

			this.Caret.MoveToPos(Caret.Line, Caret.Char + text.Length, true);

			this.InitTokens(this.Text);
		}
		//=========================================================================================
		[Browsable(false)]
		public TextSpanCollection Spans { get; private set; }
		//=========================================================================================
		[DefaultValue(ScrollBars.None), Category("Appearance")]
		[Description("Indicates which scroll bars will be shown for this control")]
		public ScrollBars ScrollBars
		{
			get { return _Body.ScrollBars; }
			set { _Body.ScrollBars = value; }
		}
		//=========================================================================================
		[DefaultValue(false)]
		[Category("Behavior")]
		public bool HighlightCurrentLine { get; set; }
		//=========================================================================================
		/// <summary>Specifies whether line numbers are shown on the left to the text view.</summary>
		[DefaultValue(false)]
		[Description("Specifies whether line numbers are shown on the left to the text view.")]
		[Category("Appearance")]
		public bool ShowLineNumbers
		{
			get { return this._ShowLineNumbers; }
			set
			{
				if (this._ShowLineNumbers == value)
					return;
				this._ShowLineNumbers = value;
				this.DetermineMarginWidth();
				this._Body.Invalidate(false);
			}
		}
		//=========================================================================================
		/// <summary>Specifies whether margin area are shown on the left to the text view.</summary>
		[DefaultValue(false)]
		[Description("Specifies whether line numbers are shown on the left to the text view.")]
		[Category("Appearance")]
		public bool ShowMargin
		{
			get { return _ShowMargin; }
			set
			{
				_ShowMargin = value;
				this.DetermineMarginWidth();
				this._Body.Invalidate(false);
			}
		}
		//=========================================================================================
		public new VScrollBar VerticalScroll
		{
			get { return this._Body.VerticalScroll; }
		}
		public new HScrollBar HorizontalScroll
		{
			get { return this._Body.HorizontalScroll; }
		}
		//=========================================================================================
		[Browsable(false)]
		public TextCaret Caret
		{
			get { return this.Body.Caret; }
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		protected override void Dispose(bool disposing)
		{
			if (this.PenGrayDot != null)
			{
				this.PenGrayDot.Dispose();
				this.PenGrayDot = null;
			}
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
			this._Body = new CodeViewerBody();
			this.SuspendLayout();
			// 
			// _Body
			// 
			this._Body.Cursor = System.Windows.Forms.Cursors.IBeam;
			this._Body.Dock = System.Windows.Forms.DockStyle.Fill;
			this._Body.Location = new System.Drawing.Point(1, 1);
			this._Body.Name = "_Body";
			this._Body.Size = new System.Drawing.Size(198, 198);
			this._Body.TabIndex = 0;
			// 
			// CodeViewer
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
			this.Controls.Add(this._Body);
			this.Name = "CodeViewer";
			this.Padding = new System.Windows.Forms.Padding(1);
			this.Size = new System.Drawing.Size(200, 200);
			this.ResumeLayout(false);

		}
		#endregion
		//=========================================================================================
		public CodeViewer()
		{
            this.BackColor = SystemColors.Window;
            this._Language = PredefinedLanguage.None;
			this.Document = new Document();
			this.Spans = new TextSpanCollection(this);
			this.InitializeComponent();
			this.SetDefaultFont();

			this.SetStyle(ControlStyles.DoubleBuffer, true);
			this.SetStyle(ControlStyles.UserPaint, true);
			this.SetStyle(ControlStyles.AllPaintingInWmPaint, true);
			this.SetStyle(ControlStyles.ResizeRedraw, true);

			this._Body.SetOwner(this);

			this._Body.KeyDown += new KeyEventHandler(_Body_KeyDown);
			this._Body.KeyUp += new KeyEventHandler(_Body_KeyUp);
			this._Body.MouseDown += new MouseEventHandler(_Body_MouseDown);

			this._Body.TextChanged += new EventHandler(_Body_TextChanged);
		}
		//=========================================================================================
		private void SetDefaultFont()
		{
			try
			{
				this.Font = new System.Drawing.Font("Consolas", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
				this._Body.Font = new System.Drawing.Font("Consolas", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			}
			catch { }
		}
		//=========================================================================================
		void _Body_TextChanged(object sender, EventArgs e)
		{
			this.OnTextChanged();
		}
		//=========================================================================================
		private void InitFontProperties()
		{
			Size size1 = TextRenderer.MeasureText(new string('x', 10), this.Font);
			Size size2 = TextRenderer.MeasureText(new string('x', 20), this.Font);
			this.CharWidth = (size2.Width - size1.Width) / 10;
			this.CharHeight = size1.Height;
			this.CharOffset = (size1.Width - 10 * this.CharWidth) >> 1;
		}
		//=========================================================================================
		void _Body_KeyUp(object sender, KeyEventArgs e)
		{
			this.OnKeyUp(e);
		}
		//=========================================================================================
		void _Body_KeyDown(object sender, KeyEventArgs e)
		{
			switch (e.KeyCode)
			{
				case Keys.A:
					if (e.Modifiers == Keys.Control)
						this.SelectAll();
					break;
				case Keys.C:
					if (e.Modifiers == Keys.Control)
						this.CopyToClipboard();
					break;
			}
			this.OnKeyDown(e);
		}
		//=========================================================================================
		void _Body_MouseDown(object sender, MouseEventArgs e)
		{
			this.OnMouseDown(e);
		}
		//=========================================================================================
		protected override void OnPaint(PaintEventArgs e)
		{
			var oBorderPen = SystemPens.ControlDark;
			if (this.BorderLines == BorderLine.All)
				e.Graphics.DrawRectangle(oBorderPen, 0, 0, this.Width - 1, this.Height - 1);
			else if (this.BorderLines == BorderLine.None)
				return;
			else
			{
				if ((this.BorderLines & BorderLine.Left) != 0)
					e.Graphics.DrawLine(oBorderPen, 0, 0, 0, this.Height - 1);
				if ((this.BorderLines & BorderLine.Top) != 0)
					e.Graphics.DrawLine(oBorderPen, 0, 0, this.Width - 1, 0);
				
				if ((this.BorderLines & BorderLine.Right) != 0)
					e.Graphics.DrawLine(oBorderPen, this.Width - 1, 0, this.Width - 1, this.Height - 1);
				else if(this.Body.VerticalScroll.Visible)
					e.Graphics.DrawLine(SystemPens.Control, this.Width - 1, 1, this.Width - 1, this.Height - 2);
				
				if ((this.BorderLines & BorderLine.Bottom) != 0)
					e.Graphics.DrawLine(oBorderPen, 0, this.Height - 1, this.Width - 1, this.Height - 1);
				else if (this.Body.HorizontalScroll.Visible)
					e.Graphics.DrawLine(SystemPens.Control, 1, this.Height - 1, this.Width - 2, this.Height - 1);
			}
			base.OnPaint(e);
		}
		//=========================================================================================
		public void ScrollIntoView()
		{
			this.Body.ScrollIntoView();
		}
		//=========================================================================================
		#region Selection processing
		//=========================================================================================
		public void SelectAll()
		{
			this.Caret.MoveDocHome(true);
			this.Caret.MoveDocEnd(false);

			this.ScrollIntoView();
			this._Body.Invalidate(false);
		}
		//=========================================================================================
		[Browsable(false)]
		public bool SelectionExists
		{
			get
			{
				if (this._Body == null || this.Caret == null)
					return false;
				TextPoint startPoint = this._Body.SelectionStart;
				return startPoint.CompareTo(this.Caret.Point) != 0;
			}
		}
		//=========================================================================================
		[Browsable(false)]
		public string SelectionText
		{
			get
			{
				return this.Document.GetText(this._Body.SelectionStart, this.Caret.Point);
			}
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		public void CopyToClipboard()
		{
			string sText = this.SelectionText;
			if (string.IsNullOrEmpty(sText))
				return;
			try
			{
				//http://stackoverflow.com/questions/930219/how-to-handle-blocked-clipboard-and-other-oddities
				Clipboard.SetDataObject(sText, true, 20, 150);
				//Clipboard.SetText(sText);
			}
			catch (System.Runtime.InteropServices.ExternalException) { }
		}
		//=========================================================================================
		public void PasteFromClipboard()
		{
			if (this.EditController != null)
				this.EditController.PasteFromClipboard();
		}
		//=========================================================================================
		public void CutSelectedText()
		{
			this.EditController.CopyToClipboard(true);
		}
		//=========================================================================================
		internal TextPoint GetSelectionBoundary(bool first)
		{
			var startPoint = Body.SelectionStart;
			var caretPos = Caret.Point;

			if (first)
				return TextPoint.Min(startPoint, caretPos);
			else
				return TextPoint.Max(startPoint, caretPos);
		}
		//=========================================================================================
		public event EventHandler SelectionChange;
		internal void OnChangeSelection()
		{
			if (this.SelectionChange != null)
				this.SelectionChange(this, EventArgs.Empty);
		}
		//=========================================================================================
		public new event EventHandler TextChanged;
		void OnTextChanged()
		{
			if (this.TextChanged != null)
				this.TextChanged(this, EventArgs.Empty);
		}
		//=========================================================================================
		private void DetermineMarginWidth()
		{
			if (!this._ShowLineNumbers)
				this.MarginWidth = 0;
			else
			{
				int iCount = 0;
				int iLineCount = this.Document.Count;
				while (iLineCount > 0)
				{
					iLineCount /= 10;
					iCount++;
				}
				if (iCount <= 1)
					iCount = 2;
				this.MarginWidth = this.CharWidth * iCount + this.CharOffset + 1;

				if (this.PenGrayDot == null)
				{
					this.PenGrayDot = new Pen(Color.Gray);
					this.PenGrayDot.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
				}
			}
			if (this._ShowMargin)
				this.MarginWidth += MARGIN_STANDARD_WIDTH;
		}
		//=========================================================================================
		TextFinder Finder;
		List<string> listSearch;
		public void ShowFind()
		{
			FindForm findForm = new FindForm();

			if (this.Finder == null)
				this.Finder = new TextFinder(this);
			if (listSearch == null)
				listSearch = new List<string>();

			findForm.Init(this.Finder, listSearch);

			findForm.Show(this);
		}
		//=========================================================================================
		/// <summary>Set position of vertical scrollbar</summary>
		public void SetPositionVert(int value)
		{
			if (value > this.Body.VerticalScroll.Maximum)
				this.Body.VerticalScroll.Value = this.Body.VerticalScroll.Maximum;
			else
				this.Body.VerticalScroll.Value = value;

			this.Body.Invalidate(false);
		}
		//=========================================================================================
		/// <summary>Get current caret position.</summary>
		public Point GetCaretLocation()
		{
			return this.Body.GetXYByTextPoint(this.Caret.Point);
		}
		//=========================================================================================
		public void UseSuggestionRules(SuggestionBuilder builder)
		{
			if (this.CodeCompletor == null)
				this.CodeCompletor = new CodeCompletor();
			this.CodeCompletor.LinkWithViewer(this);
			this.CodeCompletor.Builder = builder;
		}
		//=========================================================================================
		public int GetCharHeight()
		{
			return this.CharHeight;
		}
		//=========================================================================================
        internal int GetTextIndexByTextPoint(TextPoint textPoint)
        {
            int iTextIndex = textPoint.Char;

            for (int i = 0; i < textPoint.Line; i++)
                iTextIndex += this.Document[i].Text.Length + "\r\n".Length;

            return iTextIndex;

        }
		//=========================================================================================
		/// <summary>Specifies what side borders should be displayed</summary>
		public BorderLine BorderLines = BorderLine.All;
		public enum BorderLine : byte
		{
			None = 0x00,
			Left = 0x01,
			Top = 0x02,
			Right = 0x04,
			Bottom = 0x08,
			All = 0x0F,
		}
		//=========================================================================================
	}
}
