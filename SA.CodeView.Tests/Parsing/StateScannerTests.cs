using NUnit.Framework;
using SA.CodeView.Parsing;

namespace Tests.Parsing
{
	[TestFixture]
	public class StateScannerTests
	{
		//=========================================================================================
		ScannerSpecification CreateSpecification()
		{
			ScannerSpecification oSpec = new ScannerSpecification();
			oSpec.AddLiteral("l", CharType.Letters, '_');
			oSpec.AddLiteral("d", CharType.Numbers);
			oSpec.AddLiteral("minus", '-');
			oSpec.AddLiteral("plus", '+');
			oSpec.AddLiteral("x", '|', '=', ';');
			oSpec.AddLiteral("slash", '/');
			oSpec.AddLiteral("asterisk", '*');
			oSpec.AddLiteral("n", 'N');
			oSpec.AddLiteral("singleQuote", '\'');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("backSlash", '\\');
			oSpec.AddLiteral("caretReturn", '\n');
			return oSpec;
		}
		//=========================================================================================
		void IsValidToken(ScannerSpecification spec, string text)
		{
			StateScanner oStateScanner = new StateScanner(spec, 4);

			oStateScanner.SetSource(text + "|");
			var oToken = oStateScanner.ReadNextToken();
			Assert.That(oStateScanner.Errors, Has.Count.EqualTo(0));
			Assert.That(oToken.Text, Is.EqualTo(text));
		}
		//=========================================================================================
		void IsInvalidToken(ScannerSpecification spec, string text)
		{
			StateScanner oStateScanner = new StateScanner(spec, 4);

			oStateScanner.SetSource(text + "|");
			oStateScanner.ReadNextToken();
			Assert.That(oStateScanner.Errors, Has.Count.EqualTo(1));
		}
		//=========================================================================================
		Token ReadAndAssertToken(StateScanner scanner, string tokenType, string text)
		{
			var oToken = scanner.ReadNextToken();
			Assert.That(scanner.Errors, Has.Count.EqualTo(0));
			Assert.That(oToken.Text, Is.EqualTo(text));
			Assert.That(oToken.TokenTypeName, Is.EqualTo(tokenType));
			return oToken;
		}
		//=========================================================================================
		void AssertTokenRange(Token token, int startLine, int startCol, int startChar, int endLine, int endCol, int endChar)
		{
			Assert.That(token.Start.ToString(), Is.EqualTo(string.Format("Ln:{0}, col:{1}, ch:{2}", startLine, startCol, startChar)));
			Assert.That(token.End.ToString(), Is.EqualTo(string.Format("Ln:{0}, col:{1}, ch:{2}", endLine, endCol, endChar)));
		}
		//=========================================================================================
		/// <summary>Токен описывается простой последовательностью литералов. Проверяем, как обрабатываеся правильная и неправильная цепочка.</summary>
		[Test]
		public void SubsequentTokens()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l d l d");
			Assert.That(oSpec.States, Has.Count.EqualTo(7));

			this.IsInvalidToken(oSpec, "qqq");
			this.IsValidToken(oSpec, "q1w2");
		}
		//=========================================================================================
		/// <summary>Правило формирования токена содержит [необязательные элементы].</summary>
		[Test]
		public void SquareBrackets()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l[d]l");
			Assert.That(oSpec.States, Has.Count.EqualTo(6));

			this.IsValidToken(oSpec, "XG");
			this.IsInvalidToken(oSpec, "X55G");
			this.IsInvalidToken(oSpec, "5");
		}
		//=========================================================================================
		/// <summary>Правило формирования токена содержит {необязательные элементы, которые могут повторяться много раз}.</summary>
		[Test]
		public void CurlyBrackets()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l{d}l");
			Assert.That(oSpec.States, Has.Count.EqualTo(6));

			this.IsValidToken(oSpec, "XG");
			this.IsValidToken(oSpec, "X5G");
			this.IsValidToken(oSpec, "X51241243144141241D");
		}
		//=========================================================================================
		/// <summary>Случай, когда необязательные элементы имеют альтернетивы.</summary>
		[Test]
		public void CurlyBracketsWithAlternatives()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l{d|minus}l");
			Assert.That(oSpec.States, Has.Count.EqualTo(7));

			this.IsValidToken(oSpec, "XG");
			this.IsValidToken(oSpec, "X3G");
			this.IsValidToken(oSpec, "X---2-2-222G");
		}
		//=========================================================================================
		/// <summary>Альтернативы последовательностей.</summary>
		[Test]
		public void AlternativeOfSequences()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("s1", "l{plus plus|minus minus}d");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			this.IsValidToken(oSpec, "a2");
			this.IsValidToken(oSpec, "a++2");
			this.IsValidToken(oSpec, "b++++2");
			this.IsValidToken(oSpec, "b++++++2");
			this.IsInvalidToken(oSpec, "b+2");
		}
		//=========================================================================================
		/// <summary>Правило формирования токена содержит альтернативы.</summary>
		[Test]
		public void Alternatives()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l l | d d");
			Assert.That(oSpec.States, Has.Count.EqualTo(7));

			this.IsValidToken(oSpec, "xx");
			this.IsValidToken(oSpec, "20");
			this.IsInvalidToken(oSpec, "2a");
		}
		//=========================================================================================
		/// <summary>Альтернативы в круглых скобках.</summary>
		[Test]
		public void AlternativesInRoundBrackets()
		{
			var oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("X", "l(l|d|minus)d");
			Assert.That(oSpec.States, Has.Count.EqualTo(8));

			this.IsValidToken(oSpec, "a22");
			this.IsValidToken(oSpec, "aa2");
			this.IsValidToken(oSpec, "a-2");
			this.IsInvalidToken(oSpec, "a2a");
			this.IsInvalidToken(oSpec, "xx");
			this.IsInvalidToken(oSpec, "a");
		}
		//=========================================================================================
		/// <summary>Читаем все токены из входного потока.</summary>
		[Test]
		public void ReadAllTokens()
		{
			ScannerSpecification oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("id", "l l");
			oSpec.AddTokenDeclaration("number", "d d");
			oSpec.AddTokenDeclaration("sep", "x");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);
			oStateScanner.SetSource("qq|22");
			this.ReadAndAssertToken(oStateScanner, "id", "qq");
			this.ReadAndAssertToken(oStateScanner, "sep", "|");
			this.ReadAndAssertToken(oStateScanner, "number", "22");
			var oToken = oStateScanner.ReadNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Проверяем, как определяется положение токенов.</summary>
		[Test]
		public void CheckTokenRange_01()
		{
			ScannerSpecification oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("number", "d{d}");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);
			oStateScanner.SetSource("33");

			var oToken = this.ReadAndAssertToken(oStateScanner, "number", "33");
			Assert.That(oToken.Start.ToString(), Is.EqualTo("Ln:0, col:0, ch:0"));
			Assert.That(oToken.End.ToString(), Is.EqualTo("Ln:0, col:2, ch:2"));

			oToken = oStateScanner.ReadNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Проверяем, как определяется положение токенов в многострочном тексте.</summary>
		[Test]
		public void CheckTokenRangeMultiLines()
		{
			ScannerSpecification oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("number", "d{d}");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);
			oStateScanner.SetSource("33\r\n2\n\n 3");

			{
				var oToken = oStateScanner.ReadNextToken();
				this.AssertTokenRange(oToken, 0, 0, 0, 0, 2, 2);
			}
			{
				var oToken = oStateScanner.ReadNextToken();
				this.AssertTokenRange(oToken, 1, 0, 0, 1, 1, 1);
			}
			{
				var oToken = oStateScanner.ReadNextToken();
				this.AssertTokenRange(oToken, 3, 1, 1, 3, 2, 2);
			}
		}
		//=========================================================================================
		/// <summary>Проверяем чтение однострочных комментариев.</summary>
		[Test]
		public void ReadSingleLineComments()
		{
			ScannerSpecification oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddBoundedToken("c1", "slash asterisk", "asterisk slash", null);
			oSpec.AddBoundedToken("c2", "minus minus", "caretReturn", null);

			StateScanner oStateScanner = new StateScanner(oSpec, 4);
			oStateScanner.SetSource("-- 22 33\r\n12");

			{
				var oToken = oStateScanner.ReadNextToken();
				this.AssertTokenRange(oToken, 0, 0, 0, 1, 0, 0);
			}
			{
				var oToken = oStateScanner.ReadNextToken();
				this.AssertTokenRange(oToken, 1, 0, 0, 1, 2, 2);
			}
		}
		//=========================================================================================
		/// <summary>Читаем все токены из входного потока с учетом пробелов.</summary>
		[Test]
		public void ReadAllTokensWithSpaces()
		{
			ScannerSpecification oSpec = this.CreateSpecification();
			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("sep", "x");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);
			oStateScanner.SetSource(" q2 \t 33 ");

			//Пропускаем начальный пробел
			var oToken = this.ReadAndAssertToken(oStateScanner, "id", "q2");
			Assert.That(oToken.Start.ToString(), Is.EqualTo("Ln:0, col:1, ch:1"));
			Assert.That(oToken.End.ToString(), Is.EqualTo("Ln:0, col:3, ch:3"));

			//Пропускаем пробелы и табы
			oToken = this.ReadAndAssertToken(oStateScanner, "number", "33");
			Assert.That(oToken.Start.ToString(), Is.EqualTo("Ln:0, col:9, ch:6"));
			Assert.That(oToken.End.ToString(), Is.EqualTo("Ln:0, col:11, ch:8"));

			oToken = oStateScanner.ReadNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Читаем последовательность токенов, описывающих присваивание переменной числу.</summary>
		[Test]
		public void VariablesAssignment()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("sep", "x");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			oStateScanner.SetSource("sText=10;");
			this.ReadAndAssertToken(oStateScanner, "id", "sText");
			this.ReadAndAssertToken(oStateScanner, "sep", "=");
			this.ReadAndAssertToken(oStateScanner, "number", "10");
			this.ReadAndAssertToken(oStateScanner, "sep", ";");
		}
		//=========================================================================================
		/// <summary>Прочитать строковую константу в одинарных ковычках. Фишка в том, что внутри могут быть пробелы и в принципе все, что угодно.</summary>
		[Test]
		public void ReadStringConst()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddBoundedToken("s1", "singleQuote", "singleQuote", null);

			StateScanner oStateScanner = new StateScanner(oSpec, 4);


			const string sText = "'a2 a'";
			oStateScanner.SetSource(sText);
			this.ReadAndAssertToken(oStateScanner, "s1", sText);
			Assert.IsNull(oStateScanner.ReadNextToken());
		}
		//=========================================================================================
		/// <summary>Комментарии в /* */.</summary>
		[Test]
		public void ReadComment01()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddBoundedToken("s1", "slash asterisk", "asterisk slash", null);

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			const string sText = "/** x **/ select";
			oStateScanner.SetSource(sText);
			this.ReadAndAssertToken(oStateScanner, "s1", "/** x **/");
			oStateScanner.ReadNextToken();
			Assert.IsNull(oStateScanner.ReadNextToken());
		}
		//=========================================================================================
		/// <summary>Строковые константы в двойных ковычках с экранированием.</summary>
		[Test]
		public void ReadStringConstWithEscape()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddBoundedToken("s1", "doubleQuote", "doubleQuote", "backSlash");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			const string sText = "\"a \\\" 2 \"";
			oStateScanner.SetSource(sText);
			this.ReadAndAssertToken(oStateScanner, "s1", sText);
			Assert.IsNull(oStateScanner.ReadNextToken());
		}
		//=========================================================================================
		/// <summary>Строковые константы в одинарных ковычках с экранированием.</summary>
		[Test]
		public void ReadStringConstWithEscape_2()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddBoundedToken("s1", "singleQuote", "singleQuote", "singleQuote");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			const string sText = "'a '' 2 '''";
			oStateScanner.SetSource(sText);
			this.ReadAndAssertToken(oStateScanner, "s1", sText);
			Assert.IsNull(oStateScanner.ReadNextToken());
		}
		//=========================================================================================
		/// <summary>Проверяем, как обрабатываются знаки операций и комментарии с учетом того, что и то и другое начинается с одинаковых символов.</summary>
		[Test]
		public void OperatorsAndComment()
		{
			ScannerSpecification oSpec = this.CreateSpecification();

			oSpec.AddBoundedToken("c1", "minus minus", "backSlash", null);
			oSpec.AddBoundedToken("c2", "minus plus", "backSlash", null);
			oSpec.AddTokenDeclaration("operations", "minus{d}");

			StateScanner oStateScanner = new StateScanner(oSpec, 4);

			const string sText = "-+x\\ -23400 --+-+x\\";
			oStateScanner.SetSource(sText);
			this.ReadAndAssertToken(oStateScanner, "c2", "-+x\\");
			this.ReadAndAssertToken(oStateScanner, "operations", "-23400");
			this.ReadAndAssertToken(oStateScanner, "c1", "--+-+x\\");
			oStateScanner.ReadNextToken();
			Assert.IsNull(oStateScanner.ReadNextToken());
		}
		//=========================================================================================
	}
}
