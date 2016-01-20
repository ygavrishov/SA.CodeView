using NUnit.Framework;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;

namespace Tests.Parsing
{
	[TestFixture]
	public class XmlParsingTests
	{
		readonly StateParser Parser;
		//=========================================================================================
		public XmlParsingTests()
		{
			this.Parser = new StateParser(new XmlSyntaxSettings(), 4);
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
		void ReadTokenWithStyle(string style, string text, int startLine, int startCol, int startChar, int endLine, int endCol, int endChar)
		{
			var oToken = this.Parser.GetNextToken();
			if (this.Parser.Errors.Count > 0)
				Assert.Fail(this.Parser.Errors[0]);
			Assert.That(oToken.Text, Is.EqualTo(text));
			Assert.AreEqual(oToken.Style.Name, style);
			Assert.That(oToken.Start.ToString(), Is.EqualTo(string.Format("Ln:{0}, col:{1}, ch:{2}", startLine, startCol, startChar)));
			Assert.That(oToken.End.ToString(), Is.EqualTo(string.Format("Ln:{0}, col:{1}, ch:{2}", endLine, endCol, endChar)));
		}
		//=========================================================================================
		/// <summary>Проверяем, как определяется указанный в правиле стиль.</summary>
		[Test]
		public void Tag_Attribute_Value()
		{
			this.Parser.SetSource("<assembly style=\"simple style\" x=\"y\">");

			this.ReadTokenWithStyle("separator", "<");
			this.ReadTokenWithStyle("tagName", "assembly");
			this.ReadTokenWithStyle("attribute", "style");
			this.ReadTokenWithStyle("separator", "=");
			this.ReadTokenWithStyle("Normal", "\"");
			this.ReadTokenWithStyle("attributeValue", "simple style");
			this.ReadTokenWithStyle("Normal", "\"");
			this.ReadTokenWithStyle("attribute", "x");
			this.ReadTokenWithStyle("separator", "=");
			this.ReadTokenWithStyle("Normal", "\"");
			this.ReadTokenWithStyle("attributeValue", "y");
			this.ReadTokenWithStyle("Normal", "\"");
			this.ReadTokenWithStyle("separator", ">");
			var oToken = this.Parser.GetNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Открывающий и закрывающий тег.</summary>
		[Test]
		public void Opening_And_Closing_Tags()
		{
			this.Parser.SetSource("<Tag></Tag>");

			this.ReadTokenWithStyle("separator", "<");
			this.ReadTokenWithStyle("tagName", "Tag");
			this.ReadTokenWithStyle("separator", ">");
			this.ReadTokenWithStyle("separator", "</");
			this.ReadTokenWithStyle("tagName", "Tag");
			this.ReadTokenWithStyle("separator", ">");
			var oToken = this.Parser.GetNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Комментарии в тексте без перевода строки.</summary>
		[Test]
		public void CommentsInLine()
		{
			this.Parser.SetSource("<!--<Id>Technology</Id>--><x>");
			this.ReadTokenWithStyle("separator", "<!--", 0, 0, 0, 0, 4, 4);
			this.ReadTokenWithStyle("comments", "<Id>Technology</Id>", 0, 4, 4, 0, 23, 23);
			this.ReadTokenWithStyle("separator", "-->", 0, 23, 23, 0, 26, 26);
		}
		//=========================================================================================
		/// <summary>Комментарии в мнострочном тексте.</summary>
		[Test]
		public void CommentsInText()
		{
			//this.Parser.SetSource("<![CDATA[</Config>]]>");
			this.Parser.SetSource(@"
<x>
	<!--<Id>Technology</Id>-->
</x>
");
			this.Parser.GetNextToken();
			this.Parser.GetNextToken();
			this.Parser.GetNextToken();
			this.ReadTokenWithStyle("separator", "<!--", 2, 4, 1, 2, 8, 5);
			this.ReadTokenWithStyle("comments", "<Id>Technology</Id>", 2, 8, 5, 2, 27, 24);
			this.ReadTokenWithStyle("separator", "-->", 2, 27, 24, 2, 30, 27);
		}
		//=========================================================================================
		/// <summary>Проверяем, как читается CDATA.</summary>
		[Test]
		public void ReadCData()
		{
			this.Parser.SetSource("<![CDATA[</Config>]]>");
			this.ReadTokenWithStyle("separator", "<![CDATA[");
			this.ReadTokenWithStyle("cdata", "</Config>");
			this.ReadTokenWithStyle("separator", "]]>");
		}
		//=========================================================================================
	}
}
