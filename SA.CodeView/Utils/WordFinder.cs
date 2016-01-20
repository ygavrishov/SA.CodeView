using System;

namespace SA.CodeView.Utils
{
	/// <summary>Помогает выделять слова в строке.</summary>
	static class WordFinder
	{
		enum LetterType { WhiteSpace, LetterOrDigit, Separator, Punctuation }
		//=========================================================================================
		/// <summary>Найти начало следующего слова</summary>
		static public int GetNextWordStart(string line, int col)
		{
			LetterType type = GetLetterType(line[col]);
			if (type != LetterType.WhiteSpace)
			{
				while (col < line.Length &&
					GetLetterType(line[col]) == type)
					col++;
			}
			while (col < line.Length &&
				GetLetterType(line[col]) == LetterType.WhiteSpace)
				col++;
			return col;
		}
		//=========================================================================================
		/// <summary>Найти начало текущего слова</summary>
		static public int GetWordStart(string line, int col)
		{
			while (col > 0 &&
				GetLetterType(line[col - 1]) == LetterType.WhiteSpace)
				col--;

			if (col > 0)
			{
				LetterType type = GetLetterType(line[col - 1]);
				while (col > 0 &&
					GetLetterType(line[col - 1]) == type)
					col--;
			}
			return col;
		}
		//=========================================================================================
		/// <summary>Найти начало и конец слова, определенного позицией col.</summary>
		public static int[] GetWord(string line, int chr, int tabsize)
		{
			int iStart, iEnd;
			if (chr >= line.Length)
			{
				//Последнее слово
				line = line.TrimEnd();
				if (line.Length == 0)
					return new int[] { 0, 0 };
				LetterType letterType = GetLetterType(line[line.Length - 1]);
				iStart = GetFirstLetter(line, line.Length, letterType);
				iEnd = line.Length;
			}
			else if (chr == 0)
			{
				if (line.Length == 0)
					return new int[] { 0, 0 };
				LetterType letterType = GetLetterType(line[0]);

				iStart = 0;
				if (letterType == LetterType.WhiteSpace)
					iEnd = line.Length - line.TrimStart().Length;
				else
					iEnd = GetLastLetter(line, 0, letterType);
			}
			else if (!char.IsWhiteSpace(line, chr))
			{
				//Текущее слово
				LetterType letterType = GetLetterType(line[chr]);
				iStart = GetFirstLetter(line, chr, letterType);
				iEnd = GetLastLetter(line, chr, letterType);
			}
			else if (!char.IsWhiteSpace(line, chr - 1))
			{
				//Предыдущее слово
				LetterType letterType = GetLetterType(line[chr - 1]);
				iStart = GetFirstLetter(line, chr - 1, letterType);
				iEnd = chr;
			}
			else
			{
				//Текущий набор пробелов
				LetterType letterType = LetterType.WhiteSpace;
				iStart = GetFirstLetter(line, chr, letterType);
				iEnd = GetLastLetter(line, chr, letterType);
			}
			iStart = TextCaret.GetCol(line, iStart, tabsize);
			iEnd = TextCaret.GetCol(line, iEnd, tabsize);

			return new int[] { iStart, iEnd };
		}
		//=========================================================================================
		/// <summary>Найти позицию первого символа с указанным типом.</summary>
		static int GetFirstLetter(string line, int chr, LetterType letterType)
		{
			while (chr > 0 && GetLetterType(line[chr - 1]) == letterType)
				chr--;
			return chr;
		}
		//=========================================================================================
		/// <summary>Найти позицию последнего символа с указанным типом + 1.</summary>
		static int GetLastLetter(string line, int chr, LetterType letterType)
		{
			while (chr < line.Length && GetLetterType(line[chr]) == letterType)
				chr++;
			return chr;
		}
		//=========================================================================================
		/// <summary>Определить тип символа</summary>
		static LetterType GetLetterType(char c)
		{
			if (char.IsLetterOrDigit(c) || c == '_')
				return LetterType.LetterOrDigit;
			if (char.IsWhiteSpace(c))
				return LetterType.WhiteSpace;
			if (char.IsSeparator(c))
				return LetterType.Separator;
			if (char.IsPunctuation(c))
				return LetterType.Punctuation;
			if (char.IsControl(c))
				return LetterType.WhiteSpace;
			return LetterType.Punctuation;
		}
		//=========================================================================================
	}
}
