using System;
using System.Collections.Generic;

namespace SA.CodeView.Parsing
{
	[Flags]
	enum CharType { Letters = 0x01, Numbers = 0x02, AnyNonSpaces = 0x04, Unknown = 0x08 }
	//#############################################################################################
	/// <summary>Разбивает входной поток на токены. Работает на основе конечного автомата.</summary>
	class StateScanner
	{
		public readonly List<string> Errors;
		readonly ScannerSpecification Specification;
		StateScannerState CurrentState;
		IBufferReader _Reader;
		/// <summary>Последний считанный токен.</summary>
		Token LastToken;
		/// <summary>Вернуть тот же токен, что и в предыдущий раз.</summary>
		bool ReturnPreviousToken;
		/// <summary>Если последний считанный сканером токен имеет ограничители, то это длина НАЧАЛЬНОГО ограничителя; иначе 0</summary>
		internal int StartLimiterLength;
		/// <summary>Если последний считанный сканером токен имеет ограничители, то это длина КОНЕЧНОГО ограничителя; иначе 0</summary>
		internal int EndLimiterLength;
		internal int TabSize;
		//=========================================================================================
		public StateScanner(ScannerSpecification specification, int tabsize)
		{
			this.Errors = new List<string>();
			this.Specification = specification;
			this._Reader = new BufferReader(tabsize);
			this.TabSize = tabsize;
		}
		//=========================================================================================
		/// <summary>Задать строку для нового разбора на токены.</summary>
		public void SetSource(string text)
		{
			this.CurrentState = null;
			this.ReturnPreviousToken = false;
			this.Errors.Clear();
			this._Reader.SetSource(text);
		}
		//=========================================================================================
		/// <summary>Получить очередной токен.</summary>
		public Token ReadNextToken()
		{
			if (this.ReturnPreviousToken && this.LastToken != null)
			{
				this.ReturnPreviousToken = false;
				return this.LastToken;
			}

			///Пропускаем все пробелы
			char cChar;
			do
			{
				cChar = this._Reader.ReadChar();
				if (cChar == '\0')
					return null;
			}
			while (char.IsWhiteSpace(cChar));

			///Становимся на начальное состояние
			this.CurrentState = this.Specification.StartState;
			///Засекаем начало токена
			int iStart = this._Reader.Position - 1;
			var pointStart = this._Reader.PreviousPoint;

			while (true)
			{
				///Ищем следующее состояние на основании текущего символа
				var oNewState = this.CurrentState.GetNextState(cChar);
				///Если мы перешли в состоянии ошибки, генерим ошибку
				if (oNewState == this.Specification.FailState)
				{
					this.Errors.Add(this.CurrentState.GetExpectationToString());
				}
				///Если пора выходить
				if (oNewState == this.Specification.EndState)
				{
					var oToken = this.GetToken(iStart, pointStart, this._Reader.Position - 1, this._Reader.PreviousPoint);
					///Возвращаемся на символ назад, чтобы в следующий раз начать с правильной позиции
					this._Reader.BackToChar();
					return oToken;
				}
				if (oNewState == null)
					throw new NullReferenceException(this.CurrentState.Name);
				this.CurrentState = oNewState;

				///Читаем новый символ
				cChar = this._Reader.ReadChar();
				if (cChar == '\0')
					return this.GetToken(iStart, pointStart, this._Reader.Position, this._Reader.Point);
			}
		}
		//=========================================================================================
		/// <summary>Сформировать новый токен.</summary>
		Token GetToken(int start, TextPoint pointStart, int end, TextPoint pointEnd)
		{
			if (start >= end)
				return null;

			///Определяем тип токена
			string sTokenType = (this.CurrentState != null) ? this.CurrentState.ResultTokenName : null;

			///Указываем ограничители для текущего токена
			this.StartLimiterLength = this.CurrentState.StartLimiterLength;
			this.EndLimiterLength = this.CurrentState.EndLimiterLength;

			this.LastToken = new Token(
				sTokenType,
				this._Reader.GetSubstring(start, end - start),
				pointStart,
				pointEnd,
				null);
			return this.LastToken;
		}
		//=========================================================================================
		/// <summary>Вернуться на один токен назад.</summary>
		internal void BackToToken()
		{
			this.ReturnPreviousToken = true;
		}
		//=========================================================================================
	}
}
