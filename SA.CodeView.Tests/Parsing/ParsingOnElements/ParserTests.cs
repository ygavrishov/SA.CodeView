using System.Collections.Generic;
using System.Drawing;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;
using SA.CodeView.ParsingOnElements;

namespace Tests.CodeViewing
{
	[TestFixture]
	public class ParserTests
	{
		//=========================================================================================
		List<string> GetLines(string text)
		{
			List<string> lines = new List<string>();
			string[] arrLines = text.Split('\r', '\n');
			foreach (string sLine in arrLines)
				if (sLine.Length > 0)
					lines.Add(sLine);
			return lines;
		}
		//=========================================================================================
		[Test]
		public void Simple()
		{
			string sText = @"create xxx";
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);
			Token oToken;

			oToken = tokens[0];
			Assert.AreEqual(oToken.Style.Name, "Keywords1");
			Assert.AreEqual(oToken.Text, "create");
			oToken = tokens[1];
			Assert.AreEqual(oToken.Style.Name, "Normal");
			Assert.AreEqual(oToken.Text, "xxx");

			Assert.AreEqual(tokens.Count, 2);
		}
		//=========================================================================================
		/// <summary>Проверяем свойство Start.Char и End.Char у разобранных токенов.</summary>
		[Test]
		public void CharsInTokens()
		{
			string sText = "Create table\tT1(\r\n\tx\tint)";
			//xxxxxxxxxxxxxx			
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);

			Assert.AreEqual("Ln:0, col:0, ch:0", tokens[0].Start.ToString());
			Assert.AreEqual("Ln:0, col:6, ch:6", tokens[0].End.ToString());
			Assert.AreEqual("Ln:0, col:7, ch:7", tokens[1].Start.ToString());
			Assert.AreEqual("Ln:0, col:12, ch:12", tokens[1].End.ToString());
			Assert.AreEqual("Ln:0, col:16, ch:13", tokens[2].Start.ToString());
			Assert.AreEqual("Ln:0, col:18, ch:15", tokens[2].End.ToString());
			Assert.AreEqual("Ln:0, col:18, ch:15", tokens[3].Start.ToString());
			Assert.AreEqual("Ln:0, col:19, ch:16", tokens[3].End.ToString());
			Assert.AreEqual("Ln:1, col:4, ch:1", tokens[4].Start.ToString());
			Assert.AreEqual("Ln:1, col:5, ch:2", tokens[4].End.ToString());
			Assert.AreEqual("Ln:1, col:8, ch:3", tokens[5].Start.ToString());
			Assert.AreEqual("Ln:1, col:11, ch:6", tokens[5].End.ToString());
		}
		//=========================================================================================
		[Test]
		public void SingleComment()
		{
			string sText =
@"--Комментарий create 
create
-- function (*/)
 xxx";
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);
			Token oToken;

			oToken = tokens[0];
			Assert.AreEqual(oToken.Style.Name, "SingleLine Comment");
			Assert.AreEqual(oToken.Text, "--Комментарий create ");
			oToken = tokens[2];
			Assert.AreEqual(oToken.Style.Name, "SingleLine Comment");
			Assert.AreEqual(oToken.Text, "-- function (*/)");

			Assert.AreEqual(tokens.Count, 4);
		}
		//=========================================================================================
		[Test]
		public void MultiLineComments()
		{
			string sText =
@"/*Комментарий create 
create
-- function (*/x/**/function/*
 xxx";
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);
			List<Token> expectedTokens = new List<Token>(new Token[]
			{
				new Token("/*Комментарий create ", new TextPoint(0, 0, 0), new TextPoint(0, 21, 21), new TextStyle("MultiLine Comment", Color.Black)),
				new Token("create", new TextPoint(1, 0, 0), new TextPoint(1, 6, 6), new TextStyle("MultiLine Comment", Color.Black)),
				new Token("-- function (*/", new TextPoint(2, 0, 0), new TextPoint(2, 15, 15), new TextStyle("MultiLine Comment", Color.Black)),
				new Token("x", new TextPoint(2, 15, 15), new TextPoint(2, 16, 16), new TextStyle("Normal", Color.Black)),
				new Token("/**/", new TextPoint(2, 16, 16), new TextPoint(2, 20, 20), new TextStyle("MultiLine Comment", Color.Black)),
				new Token("function", new TextPoint(2, 20, 20), new TextPoint(2, 28, 28), new TextStyle("Keywords1", Color.Black)),
				new Token("/*", new TextPoint(2, 28, 28), new TextPoint(2, 30, 30), new TextStyle("MultiLine Comment", Color.Black)),
				new Token(" xxx", new TextPoint(3, 0, 0), new TextPoint(3, 4, 4), new TextStyle("MultiLine Comment", Color.Black))
			});
			for (int i = 0; i < tokens.Count; i++)
			{
				Token oToken1 = tokens[i];
				Token oToken2 = expectedTokens[i];
				Assert.AreEqual(oToken1.Text, oToken2.Text);
				Assert.AreEqual(oToken1.Style.Name, oToken2.Style.Name);
				Assert.AreEqual(oToken1.Start.ToString(), oToken2.Start.ToString());
				Assert.AreEqual(oToken1.End.ToString(), oToken2.End.ToString());
			}
		}
		//=========================================================================================
		[Test]
		public void Operators()
		{
			string sText = "seLect -+-+		12+33(--xxx";
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);
			Token oToken;

			oToken = tokens[0];
			Assert.AreEqual(oToken.Style.Name, "Keywords1");
			Assert.AreEqual(oToken.Text, "seLect");

			oToken = tokens[1];
			Assert.AreEqual(oToken.Style.Name, "Operators");
			Assert.AreEqual(oToken.Text, "-+-+");

			//Assert.AreEqual(tokens.Count, 5);
		}
		//=========================================================================================
		[Test]
		public void QuotesInComments()
		{
			string sText = "seLect N'xx[x]'";
			List<string> lines = this.GetLines(sText);

			SyntaxParser oParser = new SyntaxParser(new MsSqlSyntaxSettings(), 4);
			List<Token> tokens = oParser.Parse(lines);
			Token oToken;

			oToken = tokens[1];
			Assert.AreEqual(oToken.Style.Name, "String");
			Assert.AreEqual(oToken.Text, "N'xx[x]'");
		}
		//=========================================================================================
		[Test]
		public void BoundedElements()
		{
			///Задаем настройки
			TextStyle oStyle = new TextStyle("String", Color.Red);
			BoundedElement oStringConst = new BoundedElement(oStyle, "'", "'", "''");
			NonSyntaxSettings oSettings = new NonSyntaxSettings();
			oSettings.Elements.Add(oStringConst);

			///Образец текста
			string sText = "seLect 'xx ''xx[x]'";
			List<string> lines = this.GetLines(sText);

			///Разбираем
			SyntaxParser oParser = new SyntaxParser(oSettings, 4);
			List<Token> tokens = oParser.Parse(lines);

			///Проверяем
			Token oToken;

			oToken = tokens[1];
			Assert.AreEqual(oToken.Style.Name, "String");
			Assert.AreEqual(oToken.Text, "'xx ''xx[x]'");
		}
		//=========================================================================================
		public void NewTestsForImplementation()
		{
			//---------- Синтаксический разбор ----------
			///Example: string sValue = "ab cd \" ef gh";
			///Element oElement = new BoundedElement("\"", "\"");
			///oElement.Escape = "\"";

			///Example: <Root>value</Root>
			///Element oStart = new BoundedElement("<", ">");
			///Element oEnd = new BoundedElement("<", "/>");
			///Sequence oSeq = new Sequence();
			///oSeq.Items.Add(oStart);
			///oSeq.Items.Add(Element.Any);
			///oSeq.Items.Add(oEnd);

			///Example: <Root name="x1" name2="x3">value</Root>
			///Element oStart = new BoundedElement("<", ">");
			///Element oSeqAttr = new Sequence();
			///oSeqAttr.Add(new ConstantElement(Letters, Any);
			///oSeqAttr.Add(new ConstantElement(Separator, "=", 1));
			///oSeqAttr.Add(oItemQuotedString);
			///oSeqAttr.MinOccurs = 0;
			///oSeqAttr.MaxOccurs = -1;
			///Element oEnd = new BoundedElement("<", "/>");
			///Sequence oSeq = new Sequence();
			///oSeq.Items.Add(oStart);
			///oSeq.Items.Add(Element.Any);
			///oSeq.Items.Add(oEnd);
		}
		//=========================================================================================
	}
}
