using System;
using System.Collections.Generic;
using SA.CodeView.Languages;
using SA.CodeView.Parsing;

namespace SA.CodeView.ParsingOnElements
{
	/// <summary>Разбивает текст на подстроки, которые впоследствие будут окрашены в разные цвета.</summary>
	class SyntaxParser : SA.CodeView.Parsing.ISyntaxParser
	{
		enum LetterType { Normal = 0, Operator, WhiteSpace, }
		//=========================================================================================
		readonly SyntaxSettings Settings;
		readonly LetterType[] charMap;
		/// <summary>Карта, по которой можно найти стиль отображения по ключевому слову.</summary>
		readonly Dictionary<string, TextStyle> KeywordsMap;
		readonly Dictionary<string, BoundedElement> QuotedTokenRules;
		int _TabSize;
		//=========================================================================================
		public SyntaxParser(SyntaxSettings settings, int tabsize)
		{
			this._TabSize = tabsize;
			this.Settings = settings;

			this.charMap = new LetterType[256];
			for (char c = '\0'; c < (char)256; c++)
			{
				if (char.IsWhiteSpace(c))
					this.charMap[c] = LetterType.WhiteSpace;
			}
			foreach (char c in this.Settings.Operators)
				this.charMap[c] = LetterType.Operator;

			this.QuotedTokenRules = new Dictionary<string, BoundedElement>();
			foreach (BaseElement oGroup in this.Settings.Elements)
			{
				BoundedElement oRealGroup = oGroup as BoundedElement;
				if (oRealGroup != null)
					this.QuotedTokenRules.Add(oRealGroup.StartSymbols, oRealGroup);
			}

			this.KeywordsMap = new Dictionary<string, TextStyle>(StringComparer.OrdinalIgnoreCase);
			foreach (BaseElement oRule in this.Settings.Elements)
			{
				if (oRule is FixedListElement)
				{
					foreach (string sKeyword in ((FixedListElement)oRule).Keywords)
						this.KeywordsMap.Add(sKeyword, oRule.Style);
				}
			}
		}
		//=========================================================================================
		TextPoint CurPos;
		List<string> Lines;
		//=========================================================================================
		public List<Token> Parse(List<string> lines)
		{
			List<Token> tokens = new List<Token>();

			this.Lines = lines;
			this.CurPos = new TextPoint();
			//string sWord = string.Empty;
			int iWordLen = 0;

			while (true)
			{
				if (!this.SkipWhiteSpaces())
					break;
				iWordLen = this.GetNextWordLength();
				if (iWordLen == 0)
					break;

				string sLine = this.Lines[this.CurPos.Line];
				BoundedElement oVarGroup = null;
				foreach (string sKey in this.QuotedTokenRules.Keys)
					if (string.Compare(sLine, this.CurPos.Char, sKey, 0, sKey.Length, false) == 0)
					{
						oVarGroup = this.QuotedTokenRules[sKey];
						break;
					}
				if (oVarGroup != null)
				{
					this.GetQuotedToken(tokens, oVarGroup);
					continue;
				}
				string sWord = sLine.Substring(this.CurPos.Char, iWordLen);
				TextStyle oStyle;
				if (this.charMap[(byte)sWord[0]] == LetterType.Operator)
					oStyle = this.Settings.OperatorsTextStyle;
				else
				{
					if (!this.KeywordsMap.TryGetValue(sWord, out oStyle))
						oStyle = this.Settings.NormalTextStyle;
				}

				TextPoint oStart = this.CurPos;
				this.CurPos.Char += iWordLen;
				this.CurPos.Col += iWordLen;
				tokens.Add(new Token(sWord, oStart, this.CurPos, oStyle));
			}

			return tokens;
		}
		//=========================================================================================
		void GetQuotedToken(List<Token> tokens, BoundedElement group)
		{
			int iCol, iChar;
			TextPoint endPoint;
			Token oToken;
			string sLine = this.Lines[this.CurPos.Line];

			///Если указан стиль оформления границ блока, то надо создать отдельный токен для начала блока
			if (group.BoundStyle != null)
			{
				iChar = this.CurPos.Char + group.StartSymbols.Length;
				iCol = TextCaret.GetCol(sLine, iChar, this._TabSize);
				endPoint = new TextPoint(this.CurPos.Line, iCol, iChar);
				oToken = new Token(
					group.StartSymbols, this.CurPos,
					endPoint, group.BoundStyle);
				tokens.Add(oToken);
				this.CurPos = endPoint;
			}
			///Если не указаны конечные символы блока, то блок длится до конца строки
			if (group.EndSymbols.Length == 0)
			{
				string sWord = sLine.Substring(this.CurPos.Char);
				iCol = TextCaret.GetLastCol(sLine, this._TabSize);
				oToken = new Token(sWord, this.CurPos, new TextPoint(this.CurPos.Line, iCol, sLine.Length - 1), group.Style);
				tokens.Add(oToken);
				this.CurPos.Line++;
				this.CurPos.Char = 0;
				this.CurPos.Col = 0;
				return;
			}
			bool bFirstLine = true;

			while (true)
			{
				int iIndex = this.CurPos.Char;
				if (bFirstLine)
					iIndex += group.StartSymbols.Length;
				if (iIndex >= sLine.Length)
					iIndex = -1;
				else
					iIndex = sLine.IndexOf(group.EndSymbols, iIndex);

				if (iIndex >= 0)
				{
					bool bEnd = true;
					if (group.Escape != null)
					{
						int iEscapeIndex = sLine.IndexOf(group.Escape);
						if (iEscapeIndex >= 0 && iEscapeIndex <= iIndex && iEscapeIndex + group.Escape.Length > iIndex)
							bEnd = false;
					}
					if (bEnd)
					{
						if (group.BoundStyle == null)
							iIndex += group.EndSymbols.Length;
						string sText = sLine.Substring(this.CurPos.Char, iIndex - this.CurPos.Char);
						iCol = TextCaret.GetCol(sLine, iIndex, this._TabSize);
						endPoint = new TextPoint(this.CurPos.Line, iCol, iIndex);
						tokens.Add(new Token(sText, this.CurPos, endPoint, group.Style));
						this.CurPos = endPoint;
						break;
					}
				}
				iCol = TextCaret.GetLastCol(sLine, this._TabSize);
				endPoint = new TextPoint(this.CurPos.Line, iCol, sLine.Length);
				if (bFirstLine)
					sLine = sLine.Substring(this.CurPos.Char);
				tokens.Add(new Token(sLine, this.CurPos, endPoint, group.Style));

				this.CurPos.Line++;
				this.CurPos.Char = 0;
				this.CurPos.Col = 0;
				if (this.CurPos.Line >= this.Lines.Count)
					break;
				sLine = this.Lines[this.CurPos.Line];
				bFirstLine = false;
			}

			///Если указан стиль оформления границ блока, то надо создать отдельный токен для конца блока
			if (group.BoundStyle != null)
			{
				iChar = this.CurPos.Char + group.EndSymbols.Length;
				sLine = this.Lines[this.CurPos.Line];
				iCol = TextCaret.GetCol(sLine, iChar, this._TabSize);
				endPoint = new TextPoint(this.CurPos.Line, iCol, iChar);
				oToken = new Token(
					group.EndSymbols, this.CurPos,
					endPoint, group.BoundStyle);
				tokens.Add(oToken);
				this.CurPos = endPoint;
			}
		}
		//=========================================================================================
		/// <summary>Пропустить пробелы и прочие нечитаемые символы.</summary>
		bool SkipWhiteSpaces()
		{
			while (this.CurPos.Line < this.Lines.Count)
			{
				string sLine = this.Lines[this.CurPos.Line];
				if (this.CurPos.Char >= sLine.Length)
				{
					this.CurPos.Line++;
					this.CurPos.Col = 0;
					this.CurPos.Char = 0;
					continue;
				}
				if (charMap[(byte)sLine[this.CurPos.Char]] == LetterType.WhiteSpace)
				{
					if (sLine[this.CurPos.Char] == '\t')
					{
						do
							this.CurPos.Col++;
						while (this.CurPos.Col % this._TabSize != 0);
					}
					else
						this.CurPos.Col++;
					this.CurPos.Char++;
					continue;
				}
				return true;
			}
			return false;
		}
		//=========================================================================================
		/// <summary>Получить следующее слово (последовательность из символов одного типа).</summary>
		int GetNextWordLength()
		{
			string sLine = this.Lines[this.CurPos.Line];
			int iStart = this.CurPos.Char;
			LetterType letterType = this.charMap[(byte)sLine[iStart]];

			for (int i = iStart; i < sLine.Length; i++)
				if (this.charMap[(byte)sLine[i]] != letterType)
					return i - iStart;
			return sLine.Length - iStart;
		}
		//=========================================================================================
	}
}
