using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.ParsingOnElements;
using SA.CodeView.Parsing;

namespace SA.CodeView.Languages
{
	class XmlSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public XmlSyntaxSettings()
		{
			this.Operators = new char[] { };
		}
		//=========================================================================================
		protected override Dictionary<string, TextStyle> CreateTextStyles()
		{
			var styles = base.CreateTextStyles();
			this.AddStyle(styles, new TextStyle("separator", Color.Blue));
			this.AddStyle(styles, new TextStyle("tagName", Color.Brown));
			this.AddStyle(styles, new TextStyle("attribute", Color.Red));
			this.AddStyle(styles, new TextStyle("attributeValue", Color.Blue));
			this.AddStyle(styles, new TextStyle("quotes", Color.Red));
			this.AddStyle(styles, new TextStyle("comments", Color.Green));
			this.AddStyle(styles, new TextStyle("cdata", Color.Teal));

			return styles;
		}
		//=========================================================================================
		internal override ScannerSpecification CreateScannerSpecification()
		{
			var oSpec = new ScannerSpecification();
			oSpec.AddLiteral("letter", CharType.Letters, '_');
			oSpec.AddLiteral("digit", CharType.Numbers);
			oSpec.AddLiteral("lt", '<');
			oSpec.AddLiteral("gt", '>');
			oSpec.AddLiteral("sqBr1", '[');
			oSpec.AddLiteral("sqBr2", ']');
			oSpec.AddLiteral("slash", '/');
			oSpec.AddLiteral("quest", '?');
			oSpec.AddLiteral("excl", '!');
			oSpec.AddLiteral("minus", '-');
			oSpec.AddLiteral("eq", '=');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("c", 'C');
			oSpec.AddLiteral("d", 'D');
			oSpec.AddLiteral("a", 'A');
			oSpec.AddLiteral("t", 'T');

			oSpec.AddTokenDeclaration("id", "letter{letter|digit}");
			oSpec.AddTokenDeclaration("lt", "lt[slash|quest]");
			oSpec.AddTokenDeclaration("gt", "[slash|quest]gt");
			oSpec.AddTokenDeclaration("eq", "eq");
			oSpec.AddBoundedToken("attrValue", "doubleQuote", "doubleQuote", null, 1, 1);
			oSpec.AddBoundedToken("comment", "lt excl minus minus", "minus minus gt", null, 4, 3);
			oSpec.AddBoundedToken("cdata", "lt excl sqBr1 c d a t a sqBr1", "sqBr2 sqBr2 gt", null, 9, 3);

			return oSpec;
		}
		//=========================================================================================
		internal override ParserSpecification CreateParserSpecification(ScannerSpecification scannerSpecification)
		{
			var oSpec = new ParserSpecification();
			oSpec.AddRule("Tag", "lt?separator? id?tagName? {id?attribute? eq?separator? attrValue?attributeValue?} gt?separator?");
			oSpec.AddRule("Comment", "comment?comments?");
			oSpec.AddRule("Cdata", "cdata?cdata?");
			return oSpec;
		}
		//=========================================================================================
		internal override TextStyle GetStyleFor(Token token, string styleName)
		{
			if (token.TokenTypeName == "comment-start")
				return this.GetStyleByName("separator");
			if (token.TokenTypeName == "comment-end")
				return this.GetStyleByName("separator");

			if (token.TokenTypeName == "attrValue-start")
				return this.NormalTextStyle;
			if (token.TokenTypeName == "attrValue-end")
				return this.NormalTextStyle;

			if (token.TokenTypeName == "cdata-start")
				return this.GetStyleByName("separator");
			if (token.TokenTypeName == "cdata-end")
				return this.GetStyleByName("separator");

			return base.GetStyleFor(token, styleName);
		}
		//=========================================================================================
		protected override List<BaseElement> CreateElements()
		{
			var elements = new List<BaseElement>();
			TextStyle oBoundStyle = new TextStyle("Brackets", Color.Blue);
			{
				///CDATA
				BoundedElement oBlock = new BoundedElement(new TextStyle("CDATA", Color.Gray), oBoundStyle, "<![CDATA[", "]]>");
				elements.Add(oBlock);
			}
			{
				///комментарии
				BoundedElement oBlock = new BoundedElement(new TextStyle("Comment", Color.Green), oBoundStyle, "<!--", "-->");
				elements.Add(oBlock);
			}

			{
				///закрывающие теги
				BoundedElement oBlock = new BoundedElement(new TextStyle("Tag", Color.Black), oBoundStyle, "</", ">");
				elements.Add(oBlock);
			}

			{
				///Простые теги в угловых скобках
				BoundedElement oBlock = new BoundedElement(new TextStyle("Tag", Color.Black), oBoundStyle, "<", ">");
				elements.Add(oBlock);
			}
			return elements;
		}
		//=========================================================================================
	}
}
