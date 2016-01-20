using System.Windows.Forms;
using NUnit.Framework;
using Rhino.Mocks;
using SA.CodeView;
using SA.CodeView.Editing;

namespace Tests.CodeViewing
{
	/// <summary>Test editing features.</summary>
	[TestFixture]
	public class EditingTests
	{
		CodeViewer Viewer;
		EditingController EditController;
		ClipboardProxyClass ClipboardProxy;
		//=========================================================================================
		#region Service functions
		[SetUp]
		public void Setup()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;
			this.EditController = new EditingController(Viewer);
		}
		//=========================================================================================
		/// <summary>Process key press.</summary>
		void ProcessKey(Keys keys)
		{
			this.EditController.ProcessKey(new KeyEventArgs(keys));
		}
		//=========================================================================================
		/// <summary>Process char input.</summary>
		void ProcessChar(char c)
		{
			this.EditController.ProcessChar(c);
		}
		//=========================================================================================
		/// <summary>Check current selection and caret position.</summary>
		void AssertSelection(int caretLine, int caretChar, int selectionStartLine, int selectionStartChar)
		{
			this.AssertPoint(this.Viewer.Caret.Point, caretLine, caretChar);
			this.AssertPoint(this.Viewer.Body.SelectionStart, selectionStartLine, selectionStartChar);
		}
		//=========================================================================================
		/// <summary>Check caret position.</summary>
		void AssertCaret(int line, int chr)
		{
			this.AssertPoint(this.Viewer.Caret.Point, line, chr);
			this.AssertPoint(this.Viewer.Body.SelectionStart, line, chr);
		}
		//=========================================================================================
		/// <summary>Check position.</summary>
		void AssertPoint(TextPoint point, int line, int chr)
		{
			Assert.AreEqual(point.Line, line);
			Assert.AreEqual(point.Char, chr);
		}
		//=========================================================================================
		/// <summary>Mock text in clipboard.</summary>
		void SetTextToClipboard(string text)
		{
			ClipboardProxy = MockRepository.GenerateStub<ClipboardProxyClass>();
			ClipboardProxy.Stub(x => x.ContainsText()).Return(true);
			ClipboardProxy.Stub(x => x.GetText()).Return(text);
			this.EditController.ClipboardProxy = this.ClipboardProxy;
		}
		//=========================================================================================
		void ExpectTextInClipboard(string text)
		{
			ClipboardProxy = MockRepository.GenerateMock<ClipboardProxyClass>();
			ClipboardProxy.Expect(x => x.SetText(text));
			this.EditController.ClipboardProxy = this.ClipboardProxy;
		}
		#endregion
		//=========================================================================================
		[Test]
		public void Delete_one_symbol_by_delete_key()
		{
			this.Viewer.Text = "Test\r\nSet\r\n3";

			//Delete symbol in the middle of line
			this.Viewer.Caret.MoveToPos(0, 1, true);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "Tst\r\nSet\r\n3");

			//Deletion at the end of line should lead to conjunction of lines
			this.Viewer.Caret.MoveToPos(0, 3, true);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "TstSet\r\n3");

			//Deletion at the end of document leads to nothing.
			this.Viewer.Caret.MoveDocEnd(true);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "TstSet\r\n3");
		}
		//=========================================================================================
		[Test]
		public void Delete_one_symbol_by_backspace()
		{
			this.Viewer.Text = "Test\r\nSet";

			//Delete symbol in the middle of line
			this.Viewer.Caret.MoveToPos(0, 2, true);
			this.ProcessKey(Keys.Back);
			Assert.AreEqual(this.Viewer.Text, "Tst\r\nSet");
			this.AssertCaret(0, 1);

			//Deletion at the beginning of document leads to nothing.
			this.Viewer.Caret.MoveDocHome(true);
			this.ProcessKey(Keys.Back);
			Assert.AreEqual(this.Viewer.Text, "Tst\r\nSet");

			//Deletion at the beginning of line should lead to conjunction of lines
			this.Viewer.Caret.MoveToPos(1, 0, true);
			this.ProcessKey(Keys.Back);
			Assert.AreEqual(this.Viewer.Text, "TstSet");
			this.AssertCaret(0, 3);
		}
		//=========================================================================================
		[Test]
		public void letters_typing()
		{
			this.Viewer.Text = "";

			this.ProcessChar('a');
			Assert.AreEqual(this.Viewer.Text, "a");
			this.AssertCaret(0, 1);
		}
		//=========================================================================================
		[Test]
		public void Type_enter()
		{
			this.Viewer.Text = "abc";

			this.Viewer.Caret.MoveToPos(0, 1, true);
			this.ProcessKey(Keys.Enter);
			Assert.AreEqual(this.Viewer.Text, "a\r\nbc");
			this.AssertCaret(1, 0);
		}
		//=========================================================================================
		[Test]
		public void Delete_selected_text_by_delete_key()
		{
			//Delete substring
			this.Viewer.Text = "1234\r\n2345\r\n3456\r\n4567\r\n5678";
			this.Viewer.Caret.MoveToPos(1, 1, true);
			this.Viewer.Caret.MoveToPos(1, 3, false);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "1234\r\n25\r\n3456\r\n4567\r\n5678");
			this.AssertCaret(1, 1);

			//Delete two lines
			this.Viewer.Text = "1234\r\n2345\r\n3456\r\n4567\r\n5678";
			this.Viewer.Caret.MoveToPos(1, 0, true);
			this.Viewer.Caret.MoveToPos(3, 0, false);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "1234\r\n4567\r\n5678");
			this.AssertCaret(1, 0);

			//Delete line ending and next 2 lines
			this.Viewer.Text = "1234\r\n2345\r\n3456\r\n4567\r\n5678";
			this.Viewer.Caret.MoveToPos(0, 2, true);
			this.Viewer.Caret.MoveToPos(3, 4, false);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "12\r\n5678");

			//Delete the whole document
			this.Viewer.Text = "1234\r\n2345\r\n3456\r\n4567\r\n5678";
			this.Viewer.Caret.MoveToPos(0, 0, true);
			this.Viewer.Caret.MoveToPos(0, 4, false);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "\r\n2345\r\n3456\r\n4567\r\n5678");

			//concatenate 2 lines
			this.Viewer.Text = "1234\r\n2345\r\n3456\r\n4567\r\n5678";
			this.Viewer.Caret.MoveToPos(0, 3, true);
			this.Viewer.Caret.MoveToPos(4, 1, false);
			this.ProcessKey(Keys.Delete);
			Assert.AreEqual(this.Viewer.Text, "123678");
		}
		//=========================================================================================
		/// <summary>Deletion by Ctrl+Delete.</summary>
		[Test]
		public void Delete_with_Control()
		{
			//Delete from the middle of the word
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 11, true);
			this.ProcessKey(Keys.Delete | Keys.Control);
			Assert.AreEqual(this.Viewer.Text, "select * frsys.objects");
			this.AssertCaret(0, 11);

			//Delete whitespaces
			this.Viewer.Text = "select \t  * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 6, true);
			this.ProcessKey(Keys.Delete | Keys.Control);
			Assert.AreEqual(this.Viewer.Text, "select* from sys.objects");

			//Delete with selection
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 0, true);
			this.Viewer.Caret.MoveToPos(0, 4, false);
			this.ProcessKey(Keys.Delete | Keys.Control);
			Assert.AreEqual(this.Viewer.Text, "* from sys.objects");
			this.AssertCaret(0, 0);
		}
		//=========================================================================================
		/// <summary>Delete by Shift+Delete.</summary>
		[Test]
		public void Delete_with_Shift()
		{
			//Delete a single line
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 11, true);
			this.ProcessKey(Keys.Delete | Keys.Shift);
			Assert.AreEqual(this.Viewer.Text, "");
			this.AssertCaret(0, 0);

			//Delete only one line
			this.Viewer.Text = @"select *
from
	sys.objects";
			this.Viewer.Caret.MoveToPos(1, 3, true);
			this.ProcessKey(Keys.Delete | Keys.Shift);
			Assert.AreEqual(this.Viewer.Text, @"select *
	sys.objects");
			this.AssertCaret(1, 1);

			//Delete last line
			this.Viewer.Text = @"select * from
	sys.objects";
			this.Viewer.Caret.MoveToPos(2, 12, true);
			this.ProcessKey(Keys.Delete | Keys.Shift);
			Assert.AreEqual(this.Viewer.Text, @"select * from
");
			this.AssertCaret(1, 0);
		}
		//=========================================================================================
		/// <summary>Delete by Ctrl+Backspace.</summary>
		[Test]
		public void Delete_by_Ctrl_Backspace()
		{
			//Delete from the middle of the word
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 11, true);
			this.ProcessKey(Keys.Back | Keys.Control);
			Assert.AreEqual(this.Viewer.Text, "select * om sys.objects");
			this.AssertCaret(0, 9);

			//Delete with selection
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveDocEnd(true);
			this.Viewer.Caret.MoveToPos(0, 9, false);
			this.ProcessKey(Keys.Back | Keys.Control);
			Assert.AreEqual(this.Viewer.Text, "select ");
			this.AssertCaret(0, 7);
		}
		//=========================================================================================
		[Test]
		public void Type_when_some_text_is_selected()
		{
			//Delete from the middle of the word
			this.Viewer.Text = "select * from sys.objects";
			this.Viewer.Caret.MoveToPos(0, 3, true);
			this.Viewer.Caret.MoveDocEnd(false);
			this.ProcessChar('_');
			Assert.AreEqual(this.Viewer.Text, "sel_");
			this.AssertCaret(0, 4);
		}
		//=========================================================================================
		[Test]
		public void Paste_from_clipboard()
		{
			//Paste single line
			this.SetTextToClipboard("Hello!");
			this.Viewer.Text = "select '' ";
			this.Viewer.Caret.MoveToPos(0, 8, true);
			this.ProcessKey(Keys.Control | Keys.V);
			Assert.AreEqual(this.Viewer.Text, "select 'Hello!' ");
			this.AssertCaret(0, 14);

			//Paste when some text is selected (the same text)
			this.Viewer.Text = "select '' ";
			this.Viewer.Caret.MoveDocHome(true);
			this.Viewer.Caret.MoveDocEnd(false);
			this.ProcessKey(Keys.Control | Keys.V);
			Assert.AreEqual(this.Viewer.Text, "Hello!");
			this.AssertCaret(0, 6);

			//Paste 2 lines
			this.SetTextToClipboard("Hello \r\nWorld!");
			this.Viewer.Text = "select '' ";
			this.Viewer.Caret.MoveToPos(0, 8, true);
			this.ProcessKey(Keys.Control | Keys.V);
			Assert.AreEqual(this.Viewer.Text, "select 'Hello \r\nWorld!' ");
			this.AssertCaret(1, 6);
		}
		//=========================================================================================
		[Test]
		public void Cut_text()
		{
			//Cut substring
			this.Viewer.Text = "select 12;";
			this.Viewer.Caret.MoveToPos(0, 1, true);
			this.Viewer.Caret.MoveDocEnd(false);

			this.ExpectTextInClipboard("elect 12;");
			this.ProcessKey(Keys.Control | Keys.X);
			Assert.AreEqual(this.Viewer.Text, "s");
			this.AssertCaret(0, 1);
			this.ClipboardProxy.VerifyAllExpectations();

			//Cut multiple lines
			this.Viewer.Text = @"select *
from sys.objects
where name = 'x'";
			this.Viewer.Caret.MoveToPos(0, 4, true);
			this.Viewer.Caret.MoveToPos(2, 3, false);

			this.ExpectTextInClipboard(@"ct *
from sys.objects
whe");
			this.ProcessKey(Keys.Control | Keys.X);
			Assert.AreEqual(this.Viewer.Text, "selere name = 'x'");
			this.AssertCaret(0, 4);
			this.ClipboardProxy.VerifyAllExpectations();
		}
		//=========================================================================================
		[Test]
		public void Copy_from_clipboard()
		{
			string sText = @"select *
from sys.objects
where name = 'x'";
			this.Viewer.Text = sText;
			this.Viewer.Caret.MoveToPos(0, 1, true);
			this.Viewer.Caret.MoveToPos(0, 8, false);

			this.ExpectTextInClipboard("elect *");
			this.ProcessKey(Keys.Control | Keys.C);
			Assert.AreEqual(this.Viewer.Text, sText);
			this.AssertSelection(0, 8, 0, 1);
			this.ClipboardProxy.VerifyAllExpectations();

			//Copy some lines
			this.Viewer.Caret.MoveToPos(2, 3, true);
			this.Viewer.Caret.MoveToPos(0, 4, false);

			this.ExpectTextInClipboard(@"ct *
from sys.objects
whe");
			this.ProcessKey(Keys.Control | Keys.C);
			Assert.AreEqual(this.Viewer.Text, sText);
			this.AssertSelection(0, 4, 2, 3);
			this.ClipboardProxy.VerifyAllExpectations();

			//Last selected symbol is caret return.
			this.Viewer.Caret.MoveToPos(0, 1, true);
			this.Viewer.Caret.MoveToPos(1, 0, false);

			this.ExpectTextInClipboard("elect *\r\n");
			this.ProcessKey(Keys.Control | Keys.C);
			Assert.AreEqual(this.Viewer.Text, sText);
			this.AssertSelection(1, 0, 0, 1);
			this.ClipboardProxy.VerifyAllExpectations();
		}
		//=========================================================================================
	}
}
