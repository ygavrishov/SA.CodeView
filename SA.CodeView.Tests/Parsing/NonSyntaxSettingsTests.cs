using NUnit.Framework;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;

namespace Tests.Parsing
{
	/// <summary>Тесты на разбор текста, для которого не определен язык</summary>
	[TestFixture]
	public class NonSyntaxSettingsTests
	{
		readonly StateParser Parser;
		//=========================================================================================
		public NonSyntaxSettingsTests()
		{
			this.Parser = new StateParser(new NonSyntaxSettings(), 4);
		}
		//=========================================================================================
		void ReadTokenWithStyle(string style, string text)
		{
			var oToken = this.Parser.GetNextToken();
			if (this.Parser.Errors.Count > 0)
				Assert.Fail(this.Parser.Errors[0]);
			Assert.That(oToken.Text, Is.EqualTo(text));
			Assert.AreEqual(oToken.Style.Name, style);
		}
		//=========================================================================================
		/// <summary>Текст должен разбиваться на токены по словам.</summary>
		[Test]
		public void Split_to_words()
		{
			this.Parser.SetSource("select 1+2\ttest()");
			this.ReadTokenWithStyle("Normal", "select");
			this.ReadTokenWithStyle("Normal", "1+2");
			this.ReadTokenWithStyle("Normal", "test()");
		}
		//=========================================================================================
	}
}
