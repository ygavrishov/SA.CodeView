using System;
using System.Collections.Generic;
using SA.CodeView.Languages;
using SA.CodeView.Utils;

namespace SA.CodeView.Parsing
{
	class StateParser : ISyntaxParser
	{
		public readonly List<string> Errors;
		public readonly ParserSpecification Spec;
		readonly StateScanner Scanner;
		readonly Queue<Token> TokenPool;
		StateParserState CurrentState;
		Token CurrentToken;
		readonly SyntaxSettings Settings;
		//=========================================================================================
		private StateParser()
		{
			this.Errors = new List<string>();
			this.TokenPool = new Queue<Token>();
			this.Spec = new ParserSpecification();
		}
		//=========================================================================================
		public StateParser(SyntaxSettings settings, int tabsize)
			: this()
		{
			this.Settings = settings;
			ScannerSpecification oScannerSpec = this.Settings.CreateScannerSpecification();
			this.Scanner = new StateScanner(oScannerSpec, tabsize);
			this.Spec = this.Settings.CreateParserSpecification(oScannerSpec);
		}
		//=========================================================================================
		internal StateParser(StateScanner scanner)
			: this()
		{
			this.Scanner = scanner;
			this.Spec = new ParserSpecification();
			this.Settings = new NonSyntaxSettings();
		}
		//=========================================================================================
		internal void SetSource(string text)
		{
			this.Scanner.SetSource(text);
			this.TokenPool.Clear();
			this.CurrentToken = null;
		}
		//=========================================================================================
		internal Token GetNextToken()
		{
			if (this.TokenPool.Count == 0)
				this.GetNextSentence();
			if (this.TokenPool.Count == 0)
				return null;
			var oToken = this.TokenPool.Dequeue();
			if (oToken.Style == null)
				oToken.Style = this.Settings.NormalTextStyle;
			return oToken;
		}
		//=========================================================================================
		void GetNextSentence()
		{
			///Становимся на начальное состояние
			this.CurrentState = this.Spec.StartState;
			if (!this.ReadNextToken())
				return;

			while (true)
			{
				///Ищем следующее состояние на основании текущего символа
				var oNewState = this.CurrentState.GetNextState(this.CurrentToken);
				///Если мы перешли в состоянии ошибки, генерим ошибку
				if (oNewState == this.Spec.FailState)
				{
					this.Errors.Add(this.CurrentState.GetExpectationToString());
				}
				///Если пора выходить
				if (oNewState == this.Spec.EndState)
				{
					this.Scanner.BackToToken();
					return;
				}
				if (oNewState == null)
					throw new NullReferenceException(this.CurrentState.Name);
				this.CurrentState = oNewState;

				if (this.Scanner.StartLimiterLength > 0)
					this.EnqueueBoundedToken();
				else
				{
					this.CurrentToken.Style = this.Settings.GetStyleFor(this.CurrentToken, this.CurrentState.StyleName);
					this.EnqueueMultilineToken(this.CurrentToken.Text, this.CurrentToken.Start, this.CurrentToken.End);
					//this.TokenPool.Enqueue(this.CurrentToken);
				}

				///Читаем новый токен
				if (!this.ReadNextToken())
					return;
			}
		}
		//=========================================================================================
		/// <summary>Поместить в очередь токены, описывающие текст в ограничителях.</summary>
		void EnqueueBoundedToken()
		{
			///Входной ограничитель
			int iStartLen = this.Scanner.StartLimiterLength;
			TextPoint pointStartBody = new TextPoint(
				this.CurrentToken.Start.Line,
				this.CurrentToken.Start.Col + iStartLen,
				this.CurrentToken.Start.Char + iStartLen);
			string sText1 = this.CurrentToken.Text.Substring(0, iStartLen);

			Token oToken1 = new Token(
				this.CurrentToken.TokenTypeName + "-start",	//TODO: Избавиться от постоянного порождения строк
				sText1, this.CurrentToken.Start, pointStartBody, this.CurrentToken.Style);
			oToken1.Style = this.Settings.GetStyleFor(oToken1, this.CurrentState.StyleName);
			this.TokenPool.Enqueue(oToken1);

			///Текст между ограничителей
			int iEndLen = this.Scanner.EndLimiterLength;
			TextPoint pointEndBody = new TextPoint(
				this.CurrentToken.End.Line,
				this.CurrentToken.End.Col - iEndLen,
				this.CurrentToken.End.Char - iEndLen);
			string sText2 = this.CurrentToken.Text.Substring(iStartLen, this.CurrentToken.Text.Length - iStartLen - iEndLen);
			this.EnqueueMultilineToken(sText2, pointStartBody, pointEndBody);

			///Концевой ограничитель
			string sText3 = this.CurrentToken.Text.Substring(this.CurrentToken.Text.Length - iEndLen);
			Token oToken3 = new Token(
				this.CurrentToken.TokenTypeName + "-end",
				sText3, pointEndBody, this.CurrentToken.End, this.CurrentToken.Style);
			oToken3.Style = this.Settings.GetStyleFor(oToken3, this.CurrentState.StyleName);
			this.TokenPool.Enqueue(oToken3);

			this.CurrentToken = oToken1;
		}
		//=========================================================================================
		/// <summary>Если токен многострочный, разбиваем его на строки и добавляем в очередь.</summary>
		private void EnqueueMultilineToken(string text, TextPoint startPoint, TextPoint endPoint)
		{
			TextStyle oStyle = null;

			///Если текст однострочный
			if (text.IndexOf('\n') < 0)
			{
				var oToken = new Token(
					this.CurrentToken.TokenTypeName,
					text, startPoint, endPoint, this.CurrentToken.Style);
				oToken.Style = this.Settings.GetStyleFor(oToken, this.CurrentState.StyleName);
				this.TokenPool.Enqueue(oToken);
			}
			else
			{
				///Разбиваем текст на строки
				List<string> lines = TextSplitter.SplitTextToLines(text);

				///Первая строка
				{
					string sLine = lines[0];
					///Начало токена
					var startTokenPoint = startPoint;
					///Конец токена
					int iChar = startPoint.Char + sLine.Length;
					int iCol = iChar;	//TODO: если перед нашим токеном были табы, то iCol мы вычисляем неверно.
					var endTokenPoint = new TextPoint(startTokenPoint.Line, iCol, iChar);
					///Создаем токен
					var oToken = new Token(
						this.CurrentToken.TokenTypeName,
						sLine, startPoint, endTokenPoint, this.CurrentToken.Style);
					///Выясняем стиль
					oStyle = this.Settings.GetStyleFor(oToken, this.CurrentState.StyleName);
					oToken.Style = oStyle;
					///Добавляем в очередь
					this.TokenPool.Enqueue(oToken);
				}

				///Проходим по остальным строкам
				for (int iLine = 1; iLine < lines.Count; iLine++)
				{
					string sLine = lines[iLine];
					if (sLine.Length == 0)
						continue;
					///Начало токена
					var startTokenPoint = new TextPoint(startPoint.Line + iLine, 0, 0);
					///Конец токена
					int iChar = startTokenPoint.Char + sLine.Length;
					int iCol = TextCaret.GetCol(sLine, iChar, this.Scanner.TabSize);
					var endTokenPoint = new TextPoint(startTokenPoint.Line, iCol, iChar);
					///Создаем токен
					var oToken = new Token(
						this.CurrentToken.TokenTypeName,
						sLine, startTokenPoint, endTokenPoint, this.CurrentToken.Style);
					///Выясняем стиль
					oToken.Style = oStyle;
					///Добавляем в очередь
					this.TokenPool.Enqueue(oToken);
				}
			}
		}
		//=========================================================================================
		bool ReadNextToken()
		{
			this.CurrentToken = this.Scanner.ReadNextToken();
			if (this.CurrentToken == null)
				return false;
			else
				return true;
		}
		//=========================================================================================
		public List<Token> Parse(List<string> lines)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			foreach (string sLine in lines)
				sb.AppendLine(sLine);
			this.SetSource(sb.ToString());
			List<Token> tokens = new List<Token>();
			Token oToken;
			while (true)
			{
				oToken = this.GetNextToken();
				if (oToken == null)
					break;
				tokens.Add(oToken);
			}
			return tokens;
		}
		//=========================================================================================
		public List<Token> Parse(string text)
		{
			this.SetSource(text);
			List<Token> tokens = new List<Token>();
			Token oToken;
			while (true)
			{
				oToken = this.GetNextToken();
				if (oToken == null)
					break;
				tokens.Add(oToken);
			}
			return tokens;
		}
		//=========================================================================================
	}
}
