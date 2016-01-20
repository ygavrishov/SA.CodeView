using NUnit.Framework;
using SA.CodeView.Parsing;

namespace Tests.Parsing
{
	[TestFixture]
	public class StateParserTests
	{
		//=========================================================================================
		void ReadAndAssertToken(StateParser parser, string tokenType, string text)
		{
			var oToken = parser.GetNextToken();
			Assert.That(parser.Errors, Has.Count);
			Assert.That(oToken.Text, Is.EqualTo(text));
			Assert.That(oToken.TokenTypeName, Is.EqualTo(tokenType));
		}
		//=========================================================================================
		void ReadTokenWithStyle(StateParser parser, string style, string text)
		{
			var oToken = parser.GetNextToken();
			Assert.That(parser.Errors, Has.Count);
			Assert.That(oToken.Text, Is.EqualTo(text));
			Assert.AreEqual(oToken.Style.Name, style);

			//Assert.That(oToken.TokenTypeName, Is.EqualTo(tokenType));
		}
		//=========================================================================================
		/// <summary>Читаем последовательность токенов, описывающих присваивание переменной числу.</summary>
		[Test]
		public void VariablesAssignment()
		{
			ScannerSpecification oSpec = new ScannerSpecification();
			oSpec.AddLiteral("l", CharType.Letters, '_');
			oSpec.AddLiteral("d", CharType.Numbers);
			oSpec.AddLiteral("x", '=', ';');

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("sep", "x");

			StateParser oStateParser = new StateParser(new StateScanner(oSpec, 4));
			oStateParser.Spec.AddRule("Tag", "id sep number sep");

			{
				oStateParser.SetSource("sText=10;");
				this.ReadAndAssertToken(oStateParser, "id", "sText");
				this.ReadAndAssertToken(oStateParser, "sep", "=");
				this.ReadAndAssertToken(oStateParser, "number", "10");
				this.ReadAndAssertToken(oStateParser, "sep", ";");
				var oToken = oStateParser.GetNextToken();
				Assert.IsNull(oToken);
			}
		}
		//=========================================================================================
		/// <summary>Многострочные токены должны разбиваться по числу строк.</summary>
		[Test]
		public void MultiLineTokens()
		{
			ScannerSpecification oSpec = new ScannerSpecification();
			oSpec.AddLiteral("l", CharType.Letters, '_');
			oSpec.AddLiteral("d", CharType.Numbers);
			oSpec.AddLiteral("br1", '[');
			oSpec.AddLiteral("br2", ']');

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddBoundedToken("id2", "br1", "br2", null);


			StateParser oStateParser = new StateParser(new StateScanner(oSpec, 4));
			oStateParser.Spec.AddRule("id", "id|id2");

			{
				oStateParser.SetSource(
@"select [
 x int] from x
");
				this.ReadAndAssertToken(oStateParser, "id", "select");
				this.ReadAndAssertToken(oStateParser, "id2", "[");
				this.ReadAndAssertToken(oStateParser, "id2", " x int]");
			}
		}
		//=========================================================================================
	}
}
