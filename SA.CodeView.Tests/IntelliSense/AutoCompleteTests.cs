using System.Drawing;
using System.Windows.Forms;
using Moq;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.IntelliSense;
using Tests.IntelliSense.BLL;

namespace Tests.IntelliSense
{
	[TestFixture]
	public class AutoCompleteTests
	{
		readonly CodeViewer Viewer;
		/// <summary>Substitution variants were displayed.</summary>
		bool VariantsWereShown;
		//=========================================================================================
		public AutoCompleteTests()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.ReadOnly = false;
			this.Viewer.Language = PredefinedLanguage.MsSql;

			var oTestProvider = new TestDbInfoProvider();
			var oSuggestionBuilder = new EditQueryRegExBuilder(Viewer, oTestProvider);
			oSuggestionBuilder.DefaultSchema = "Schema_Second";

			//Create mock
			var oMock = new Mock<CodeCompletor>(MockBehavior.Default);
			//Mock variants list drawing
			oMock.Setup(x => x.ShowVariants(It.IsAny<Point>())).Callback(() => this.VariantsWereShown = true);
			oMock.Setup(x => x.HideVariants()).Callback(() => this.VariantsWereShown = false);
			oMock.Setup(x => x.IsVariantsVisible).Returns(() => this.VariantsWereShown);

			Viewer.CodeCompletor = oMock.Object;
			this.Viewer.UseSuggestionRules(oSuggestionBuilder);
		}
		//=========================================================================================
		[SetUp]
		public void SetUp()
		{
			this.VariantsWereShown = false;
		}
		//=========================================================================================
		/// <summary>Autocomplete when there is only one possible variant</summary>
		[Test]
		public void AutoCompete_with_one_variant()
		{
			Viewer.Text = "Select app from   Schema_Second.Fruits      \t    ";
			Viewer.Caret.MoveToPos(0, "Select app".Length, true);

			Viewer.CodeCompletor.AutoComplete();
			Assert.AreEqual("Select Apple from   Schema_Second.Fruits      \t    ", Viewer.Text);
		}
		//=========================================================================================
		/// <summary>Auto complete when there are many variants.</summary>
		[Test]
		public void AutoCompete_with_many_variants()
		{
			string sText = "Select from   Schema_      \t    ";
			this.Viewer.Text = sText;
			this.Viewer.Caret.MoveToPos(0, "Select from   Schema_".Length, true);

			this.Viewer.CodeCompletor.AutoComplete();
			//Text shoulb be the same as before
			Assert.AreEqual(sText, this.Viewer.Text);
			//variant list should be displayed
			Assert.IsTrue(this.VariantsWereShown);
		}
		//=========================================================================================
		/// <summary>Auto complete after inner join.</summary>
		[Test]
		public void AutoComplete_with_many_variants_after_join()
		{
			string sText = "Select lemon from Schema_Second.Fruits\r\ninner join ";
			this.Viewer.Text = sText;
			this.Viewer.Caret.MoveDocEnd(true);

			this.Viewer.CodeCompletor.AutoComplete();
			//Text shoulb be the same as before
			Assert.AreEqual(sText, this.Viewer.Text);
			//variant list should be displayed
			Assert.IsTrue(this.VariantsWereShown);
		}
		//=========================================================================================
		[Test]
		public void AutoComplete_table_name()
		{
			//Arrange
			this.Viewer.Text = "Select * from f";
			this.Viewer.Caret.MoveDocEnd(true);

			//Act
			this.Viewer.CodeCompletor.AutoComplete();

			//Assert
			Assert.AreEqual(this.Viewer.Text, "Select * from Fruits");
			Assert.IsFalse(this.VariantsWereShown);
		}
		//=========================================================================================
		/// <summary>Bug fix test: previous word (select) was erased after autocompletion.</summary>
		[Test]
		public void Select_Variant_From_List()
		{
			this.Viewer.Text = "Select";
			this.Viewer.Caret.MoveDocEnd(true);
			this.Viewer.Body.ProcessChar(' ');
			this.Viewer.Body.ProcessKey(new KeyEventArgs(Keys.Down));
			this.Viewer.Body.ProcessKey(new KeyEventArgs(Keys.Down));
			this.Viewer.Body.ProcessKey(new KeyEventArgs(Keys.Enter));
			Assert.AreEqual("Select Vitamins", Viewer.Text);
		}
		//=========================================================================================
	}
}
