using System.Windows.Forms;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.Editing;

namespace Tests.Editing
{
	[TestFixture]
	public class UndoRedoTests
	{
		CodeViewer Viewer;
		EditingController EditController;

		[SetUp]
		public void Setup()
		{
			Viewer = new CodeViewer();
			Viewer.Language = PredefinedLanguage.MsSql;
			EditController = new EditingController(Viewer);
		}

		/// <summary>Process key press.</summary>
		void ProcessKey(Keys keys)
		{
			EditController.ProcessKey(new KeyEventArgs(keys));
		}

		/// <summary>Process char input.</summary>
		void ProcessChar(char c)
		{
			this.EditController.ProcessChar(c);
		}

		[Test]
		public void Undo_text_input()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			Assert.AreEqual(Viewer.Text, "0123456789");
			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "");
		}

		[Test]
		public void Type_change_position_type_undo()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			Viewer.Caret.MoveToPos(0, 3, true);
			for (char letter = 'a'; letter <= 'c'; letter++)
				ProcessChar(letter);
			Assert.AreEqual(Viewer.Text, "012abc3456789");
			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123456789");
			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "");
			Assert.AreEqual(0, Viewer.Caret.Char);
		}

		[Test]
		public void Undo_caret_return()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			ProcessKey(Keys.Enter);
			for (char letter = 'a'; letter <= 'c'; letter++)
				ProcessChar(letter);
			Assert.AreEqual(Viewer.Text, @"0123456789
abc");
			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, @"0123456789
");
			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123456789");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "");
		}

		[Test]
		public void Undo_backspace_button_processing()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			for (int i = 0; i < 2; i++)
				ProcessKey(Keys.Back);

			Assert.AreEqual(Viewer.Text, @"01234567");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "012345678");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123456789");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "");
		}

		[Test]
		public void Undo_selection_deletion()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			Viewer.Caret.MoveToPos(0, 7, true);
			Viewer.Caret.MoveToPos(0, 4, false);
			ProcessKey(Keys.Back);
			Assert.AreEqual(Viewer.Text, @"0123789");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123456789");
		}

		[Test]
		public void Undo_delete_button_processing()
		{
			Viewer.Text = "";
			for (char letter = '0'; letter <= '9'; letter++)
				ProcessChar(letter);
			Viewer.Caret.MoveToPos(0, 7, true);
			Viewer.Caret.MoveToPos(0, 4, false);
			for (int i = 0; i < 2; i++)
				ProcessKey(Keys.Delete);
			Assert.AreEqual(Viewer.Text, @"012389");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123789");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "0123456789");
		}

		[Test]
		public void Undo_text_replacement()
		{
			Viewer.Text = "";
			for (char letter = '1'; letter <= '3'; letter++)
				ProcessChar(letter);
			Viewer.SelectAll();
			for (char letter = 'a'; letter <= 'c'; letter++)
				ProcessChar(letter);
			Assert.AreEqual(Viewer.Text, @"abc");

			ProcessKey(Keys.Control | Keys.Z);
			Assert.AreEqual(Viewer.Text, "123");

			//for (char letter = 'A'; letter <= 'C'; letter++)
			//	ProcessChar(letter);

			//ProcessKey(Keys.Control | Keys.Z);
			//Assert.AreEqual(Viewer.Text, "123");
		}
	}
}
