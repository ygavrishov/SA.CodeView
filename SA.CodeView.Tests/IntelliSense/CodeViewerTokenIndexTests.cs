using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.IntelliSense;
using Tests.IntelliSense.BLL;

namespace Tests.IntelliSense
{
	/// <summary>Current token detection.</summary>
	[TestFixture]
	public class CodeViewerTokenIndexTests
	{
		private readonly CodeViewer Viewer;
		//=========================================================================================
		public CodeViewerTokenIndexTests()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;
			var oTestProvider = new TestDbInfoProvider();
			var oSuggestionBuilder = new EditQueryRegExBuilder(this.Viewer, oTestProvider);
			this.Viewer.UseSuggestionRules(oSuggestionBuilder);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_when_doc_is_empty()
		{
			this.Viewer.Text = "";
			Assert.AreEqual(-1, Viewer.Caret.TokenIndex);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_at_the_end_of_document_after_several_whitespaces()
		{
			this.Viewer.Text = "select * from   \t ";

			this.Viewer.Caret.MoveDocEnd(true);
			Assert.AreEqual(2, Viewer.Caret.TokenIndex);
			Assert.AreEqual(CaretLocationType.BetweenWords, Viewer.Caret.RegardingToken);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_between_2_words()
		{
			this.Viewer.Text = "select  from";
			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);

			Assert.AreEqual(0, this.Viewer.Caret.TokenIndex);
			Assert.AreEqual(CaretLocationType.BetweenWords, this.Viewer.Caret.RegardingToken);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_at_the_beginning_of_the_token()
		{
			this.Viewer.Text = "select user_name from   \t ";

			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);
			Assert.AreEqual(1, this.Viewer.Caret.TokenIndex);
			Assert.AreEqual(CaretLocationType.WordStart, this.Viewer.Caret.RegardingToken);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_at_the_end_of_the_token()
		{
			this.Viewer.Text = "select user_name from   \t ";

			this.Viewer.Caret.MoveToPos(0, "select user_name".Length, true);
			Assert.AreEqual(1, this.Viewer.Caret.TokenIndex);
			Assert.AreEqual(CaretLocationType.WordEnd, this.Viewer.Caret.RegardingToken);
		}
		//=========================================================================================
		[Test]
		public void Detect_caret_location_in_the_middle_of_the_token()
		{
			this.Viewer.Text = "select user_name from   \t ";

			this.Viewer.Caret.MoveToPos(0, "select user_name fr".Length, true);
			Assert.AreEqual(2, this.Viewer.Caret.TokenIndex);
			Assert.AreEqual(CaretLocationType.WordCenter, this.Viewer.Caret.RegardingToken);
		}
		//=========================================================================================
	}
}
