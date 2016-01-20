using System.Drawing;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.Utils;

namespace Tests.CodeViewing
{
	[TestFixture]
	public class EditorFeatures
	{
		CodeViewer Viewer;
		//=========================================================================================
		#region Service functions 
		/// <summary>Assert current selection and caret position.</summary>
		private void AssertSelection(int caretLine, int caretChar, int selectionStartLine, int selectionStartChar)
		{
			this.AssertPoint(this.Viewer.Caret.Point, caretLine, caretChar);
			this.AssertPoint(this.Viewer.Body.SelectionStart, selectionStartLine, selectionStartChar);
		}
		//=========================================================================================
		/// <summary>Assert caret position.</summary>
		private void AssertCaret(int line, int chr)
		{
			this.AssertPoint(this.Viewer.Caret.Point, line, chr);
			this.AssertPoint(this.Viewer.Body.SelectionStart, line, chr);
		}
		//=========================================================================================
		/// <summary>Compare specified position with some expected.</summary>
		private void AssertPoint(TextPoint point, int line, int chr)
		{
			Assert.AreEqual(point.Line, line);
			Assert.AreEqual(point.Char, chr);
		}
		//=========================================================================================
		/// <summary>Compare specified position with some expected.</summary>
		private void AssertPoint(TextPoint point, int line, int chr, int col)
		{
			Assert.AreEqual(point.ToString(), string.Format("Ln:{0}, col:{1}, ch:{2}", line, col, chr));
		}
		#endregion
		//=========================================================================================
		[Test]
		public void GetCol_method()
		{
			string sLine = "\t\tab\tx";
			int iChar;
			int iTabSize = 4;
			iChar = TextCaret.GetCol(sLine, 0, iTabSize);
			Assert.AreEqual(iChar, 0);
			iChar = TextCaret.GetCol(sLine, 1, iTabSize);
			Assert.AreEqual(iChar, 4);
			iChar = TextCaret.GetCol(sLine, 2, iTabSize);
			Assert.AreEqual(iChar, 8);
			iChar = TextCaret.GetCol(sLine, 3, iTabSize);
			Assert.AreEqual(iChar, 9);
			iChar = TextCaret.GetCol(sLine, 5, iTabSize);
			Assert.AreEqual(iChar, 12);
			iChar = TextCaret.GetCol(sLine, 777, iTabSize);
			Assert.AreEqual(iChar, 13);
		}
		//=========================================================================================
		[Test]
		public void Text_caret_movements()
		{
			string sText =
@"Create table T1(--xxxxxxx
	x		int,
	y1		int
)";
			var oViewer = new CodeViewer();
			oViewer.Text = sText;
			//To doc end
			oViewer.Body.Caret.MoveDocEnd(true);
			Assert.AreEqual("Ln:3, col:1, ch:1", oViewer.Body.Caret.Point.ToString());

			///Left
			oViewer.Body.Caret.MoveToPos(2, 13, true);
			Assert.AreEqual("Ln:2, col:13, ch:6", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveLeft();
			Assert.AreEqual("Ln:2, col:12, ch:5", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveLeft();
			Assert.AreEqual("Ln:2, col:8, ch:4", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveLeft();
			Assert.AreEqual("Ln:2, col:6, ch:3", oViewer.Body.Caret.Point.ToString());

			//Line home
			oViewer.Body.Caret.MoveLineHome();
			Assert.AreEqual("Ln:2, col:4, ch:1", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveLineHome();
			Assert.AreEqual("Ln:2, col:0, ch:0", oViewer.Body.Caret.Point.ToString());

			//Right and word right
			oViewer.Body.Caret.MoveRight();
			Assert.AreEqual("Ln:2, col:4, ch:1", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveRight();
			Assert.AreEqual("Ln:2, col:5, ch:2", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveRight();
			Assert.AreEqual("Ln:2, col:6, ch:3", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveRight();
			Assert.AreEqual("Ln:2, col:8, ch:4", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveRight();
			Assert.AreEqual("Ln:2, col:12, ch:5", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveToPos(2, 5, true);
			oViewer.Body.Caret.MoveWordRight();
			Assert.AreEqual("Ln:2, col:12, ch:5", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveWordRight();
			Assert.AreEqual("Ln:2, col:15, ch:8", oViewer.Body.Caret.Point.ToString());

			//word left
			oViewer.Body.Caret.MoveLineEnd(true);
			Assert.AreEqual("Ln:2, col:15, ch:8", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveWordLeft();
			Assert.AreEqual("Ln:2, col:12, ch:5", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveWordLeft();
			Assert.AreEqual("Ln:2, col:4, ch:1", oViewer.Body.Caret.Point.ToString());

			//Down
			oViewer.Body.Caret.MoveToPos(0, 100, true);
			oViewer.Body.Caret.MoveDown(1, true);
			Assert.AreEqual("Ln:1, col:16, ch:8", oViewer.Body.Caret.Point.ToString());
			//Up
			oViewer.Body.Caret.MoveDown(1, true);
			oViewer.Body.Caret.MoveDown(1, true);
			oViewer.Body.Caret.MoveUp(1, true);
			Assert.AreEqual("Ln:2, col:15, ch:8", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveDocEnd(true);
			oViewer.Body.Caret.MoveUp(1, true);
			Assert.AreEqual("Ln:2, col:0, ch:0", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveRight();
			oViewer.Body.Caret.MoveUp(1, true);
			Assert.AreEqual("Ln:1, col:4, ch:1", oViewer.Body.Caret.Point.ToString());

			oViewer.Body.Caret.MoveToPos(1, 9, true);
			Assert.AreEqual("Ln:1, col:8, ch:3", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveToPos(1, 10, true);
			Assert.AreEqual("Ln:1, col:8, ch:3", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveToPos(1, 11, true);
			Assert.AreEqual("Ln:1, col:12, ch:4", oViewer.Body.Caret.Point.ToString());
			oViewer.Body.Caret.MoveToPos(1, 12, true);
			Assert.AreEqual("Ln:1, col:12, ch:4", oViewer.Body.Caret.Point.ToString());
		}
		//=========================================================================================
		[Test]
		public void WordFinder_GetWord()
		{
			string sLine = "\tx\t\tint,";
			int[] arrBounds = WordFinder.GetWord(sLine, 3, 4);
			Assert.AreEqual(arrBounds[0], 5);
			Assert.AreEqual(arrBounds[1], 12);
			arrBounds = WordFinder.GetWord(sLine, 0, 4);
			Assert.AreEqual(arrBounds[0], 0);
			Assert.AreEqual(arrBounds[1], 4);
		}
		//=========================================================================================
		/// <summary>Spans shoul be sorted. Each span should be started and finished on one line.</summary>
		[Test]
		public void Spans_should_be_sorted_and_occupy_one_line()
		{
			string sText =
@"Create table T1(--xxxxxxx
	x		int
)
GO
CREATE T";
			CodeViewer oViewer = new CodeViewer();
			oViewer.Text = sText;

			oViewer.Spans.Add(Brushes.Red, 2, 0, 5);
			oViewer.Spans.Add(Brushes.Red, 0, 7, 4);
			oViewer.Spans.Add(Brushes.Red, 0, 1, 3);
			oViewer.Spans.Add(Brushes.Red, 1, 1, 4);
			Assert.AreEqual(oViewer.Spans.Count, 6);
			Assert.AreEqual(oViewer.Spans[0].Start.ToString(), "Ln:0, col:1, ch:1");
			Assert.AreEqual(oViewer.Spans[1].Start.ToString(), "Ln:0, col:7, ch:7");
			Assert.AreEqual(oViewer.Spans[2].End.ToString(), "Ln:1, col:13, ch:5");

			Assert.AreEqual(oViewer.Spans[3].End.ToString(), "Ln:2, col:1, ch:1");
			Assert.AreEqual(oViewer.Spans[4].End.ToString(), "Ln:3, col:2, ch:2");
		}
		//=========================================================================================
		[Test]
		public void Caret_returns_and_empty_lines()
		{
			{
				//Single caret return at the end of document
				string sText = "create table t1 (id int)\r\n";
				CodeViewer oViewer = new CodeViewer();
				oViewer.Text = sText;
				Assert.AreEqual(oViewer.Document.Count, 2);
			}
			{
				//Two caret returns at the end of document
				string sText = "create table t1 (id int)\r\n\r\n";
				CodeViewer oViewer = new CodeViewer();
				oViewer.Text = sText;
				Assert.AreEqual(oViewer.Document.Count, 3);
				Assert.AreEqual(oViewer.Document[1].Text, string.Empty);
				Assert.AreEqual(oViewer.Document[2].Text, string.Empty);
			}
			{
				//Last line is empty but next to last contains tab
				string sText = "create table t1 (id int)\r\n\t\r\n";
				CodeViewer oViewer = new CodeViewer();
				oViewer.Text = sText;
				Assert.AreEqual(oViewer.Document.Count, 3);
				Assert.AreEqual(oViewer.Document[1].Text, "\t");
				Assert.AreEqual(oViewer.Document[2].Text, string.Empty);
			}
		}
		//=========================================================================================
		[Test]
		public void Select_the_whole_document()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Text = @"Create table [T 1](--xxxxxxx
 x int,
 y1  int
)
";
			this.Viewer.Caret.MoveDocHome(true);
			this.Viewer.SelectAll();
			this.AssertSelection(4, 0, 0, 0);

			this.Viewer.Caret.MoveToPos(2, 0, true);
			this.Viewer.SelectAll();
			this.AssertSelection(4, 0, 0, 0);
		}
		//=========================================================================================
		/// <summary>Check SelectionChanged event generation.</summary>
		[Test]
		public void CheckEvent_SelectionChanged()
		{
			int iCounter = 0, iHasSelectionCounter = 0;
			this.Viewer = new CodeViewer();
			this.Viewer.Text = @"Create table [T 1](id int)";
			this.Viewer.Caret.MoveDocHome(true);
			this.Viewer.SelectionChange += (sender, e) =>
			{
				iCounter++;
				if (this.Viewer.SelectionExists)
					iHasSelectionCounter++;
			};

			//Move caret left
			this.Viewer.Caret.MoveRight(false);
			Assert.AreEqual(1, iCounter);
			Assert.AreEqual(1, iHasSelectionCounter);

			//Go to the end of document
			this.Viewer.Caret.MoveDocEnd(true);
			Assert.AreEqual(2, iCounter);
			Assert.AreEqual(1, iHasSelectionCounter);

			//Go to the specified position
			this.Viewer.Caret.MoveToPos(0, 3, true);
			Assert.AreEqual(3, iCounter);
			Assert.AreEqual(1, iHasSelectionCounter);

			//Repeate previous movement. Event should not be generated.
			this.Viewer.Caret.MoveToPos(0, 3, false);
			Assert.AreEqual(3, iCounter);
			Assert.AreEqual(1, iHasSelectionCounter);

			//Go to the start of line
			this.Viewer.Caret.MoveLineHome(true);
			Assert.AreEqual(4, iCounter);
			Assert.AreEqual(1, iHasSelectionCounter);
		}
		//=========================================================================================
		/// <summary>Check token start detection when there are tabs in document.</summary>
		[Test]
		public void Tabs_and_spaces()
		{
			{
				this.Viewer = new CodeViewer();
				this.Viewer.Language = PredefinedLanguage.MsSql;
				this.Viewer.Text = "\t \tselect";
				var oToken = this.Viewer.Tokens[0];
				Assert.AreEqual(oToken.Start.Col, 8);
				Assert.AreEqual(oToken.Start.Char, 3);
			}
		}
		//=========================================================================================
		[Test]
		public void Change_selection()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Text = "\t \tselect\r\n'Привет!';";
			//Select the whole document
			this.Viewer.Caret.MoveDocHome(true);
			this.Viewer.Caret.MoveDocEnd(false);
			this.AssertSelection(1, 10, 0, 0);
		}
		//=========================================================================================
		/// <summary>Check document text after tab size changing.</summary>
		[Test]
		public void Change_tab_size()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;
			this.Viewer.Text = "\tselect\r\n\t \t'a'";
			this.AssertPoint(this.Viewer.Tokens[0].Start, 0, 1, 4);
			this.AssertPoint(this.Viewer.Tokens[1].Start, 1, 3, 8);
			//Change Tab Size and check token positions
			this.Viewer.TabSize = 7;
			this.AssertPoint(this.Viewer.Tokens[0].Start, 0, 1, 7);
			this.AssertPoint(this.Viewer.Tokens[1].Start, 1, 3, 14);
		}
		//=========================================================================================
	}
}
