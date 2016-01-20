using NUnit.Framework;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;

namespace Tests.Parsing
{
	/// <summary>Проверяем качество разбора MS SQL Server скриптов.</summary>
	[TestFixture]
	public class MsSqlParsingTests
	{
		readonly StateParser Parser;
		//=========================================================================================
		public MsSqlParsingTests()
		{
			this.Parser = new StateParser(new MsSqlSyntaxSettings(), 4);
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
		/// <summary>Простая конструкция select ... from system table.</summary>
		[Test]
		public void SimpleSelect()
		{
			this.Parser.SetSource(@"
Select 1
FROM
	sysobjects");

			this.ReadTokenWithStyle("Keywords1", "Select");
			this.ReadTokenWithStyle("Numbers", "1");
			this.ReadTokenWithStyle("Keywords1", "FROM");
			this.ReadTokenWithStyle("SysTables", "sysobjects");
			var oToken = this.Parser.GetNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Многострочные комментарии.</summary>
		[Test]
		public void MultiLineComments()
		{
			this.Parser.SetSource(@"
/** x
**/
-- /* asd
select");

			this.ReadTokenWithStyle("MultiLine Comment", "/** x");
			this.ReadTokenWithStyle("MultiLine Comment", "**/");
			this.ReadTokenWithStyle("SingleLine Comment", "-- /* asd");
			this.ReadTokenWithStyle("Keywords1", "select");
			var oToken = this.Parser.GetNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Строковая константа в одинарных ковычках с использованием escape-символов.</summary>
		[Test]
		public void StringConst()
		{
			this.Parser.SetSource(@"
select 'xx''xx'
");

			this.ReadTokenWithStyle("Keywords1", "select");
			this.ReadTokenWithStyle("String", "'xx''xx'");
			var oToken = this.Parser.GetNextToken();
			Assert.IsNull(oToken);
		}
		//=========================================================================================
		/// <summary>Строковая константа в одинарных ковычках с префиксом N.</summary>
		[Test]
		public void StringConstUnicode()
		{
			this.Parser.SetSource(@"select N'xxxx', n'ab c'");
			this.Parser.GetNextToken();
			this.ReadTokenWithStyle("String", "N'xxxx'");
			this.Parser.GetNextToken();
			this.ReadTokenWithStyle("String", "n'ab c'");
		}
		//=========================================================================================
		/// <summary>Идентификатор в квадратных скобках.</summary>
		[Test]
		public void Id_In_Square_Brackets()
		{
			this.Parser.SetSource("select [T 1]");
			this.Parser.GetNextToken();
			this.ReadTokenWithStyle("Normal", "[T 1]");
		}
		//=========================================================================================
		/// <summary>Использование разделителей в однострочных комментариях. Тест на исправление ошибки.</summary>
		[Test]
		public void Separators_And_Comments()
		{
			this.Parser.SetSource("--select dbo.t1\r\nselect");
			this.ReadTokenWithStyle("SingleLine Comment", "--select dbo.t1");
		}
		//=========================================================================================
		/// <summary>Однострочный комментарии идут после операторов.Тест на исправление ошибки.</summary>
		[Test]
		public void Comments_After_Separator()
		{
			this.Parser.SetSource("select (--xxxxxxx\r\n 1)");
			this.Parser.GetNextToken();
			this.ReadTokenWithStyle("Operators", "(");
			this.ReadTokenWithStyle("SingleLine Comment", "--xxxxxxx");
		}
		//=========================================================================================
		/// <summary>Ключевые слова, начинающиеся на N, должны обрабатываться корректно.</summary>
		[Test]
		public void Keywords_With_Letter_N_Must_Be_Processed_Correctly()
		{
			this.Parser.SetSource("nocount on");
			//this.ReadTokenWithStyle("Keywords1", "set");
			this.ReadTokenWithStyle("Keywords1", "nocount");
			this.ReadTokenWithStyle("Keywords1", "on");
		}
		//=========================================================================================
	}
}
