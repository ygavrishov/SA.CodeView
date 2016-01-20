using System.Collections.Generic;
using NUnit.Framework;
using SA.CodeView.Utils;

namespace Tests.Parsing
{
	/// <summary>Тесты класса SyntaxSettings.</summary>
	[TestFixture]
	public class SyntaxSettingsTests
	{
		//=========================================================================================
		/// <summary>Проверяем, как извлекаются слова из переданного текста.</summary>
		[Test]
		public void GetKeywordsFromText()
		{
			string sText = " GO\tя12\r\n\tANY ";
			List<string> words = new List<string>();
			foreach (string sWord in TextSplitter.GetWordsFromText(sText))
				words.Add(sWord);
			Assert.That(words, Is.EquivalentTo(new string[] { "GO", "я12", "ANY" }));
		}
		//=========================================================================================
	}
}
