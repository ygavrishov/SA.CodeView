using System;

namespace SA.CodeView.Parsing
{
	interface IBufferReader
	{
		/// <summary>Прочитать очередной символ из потока.</summary>
		char ReadChar();
		/// <summary>Вернуться назад на один символ.</summary>
		void BackToChar();
		/// <summary>Получить подстроку в указанных границах.</summary>
		string GetSubstring(int start, int length);
		/// <summary>Текущее смещение от начала потока.</summary>
		int Position { get; }
		/// <summary>Номер текущего символа в текущей строке.</summary>
		int CharInLine { get; }
		/// <summary>Текущая колонка в текущей строке.</summary>
		int Column { get; }
		/// <summary>Номер текущей строки.</summary>
		int Line { get; }
		TextPoint Point { get; }
		TextPoint PreviousPoint { get; }
		void SetSource(string text);
	}
	//#############################################################################################
	/// <summary>Поставляет символы на вход сканера.</summary>
	class BufferReader : IBufferReader
	{
		string Text;
		/// <summary>Размер табуляции в символах.</summary>
		readonly int TabSize;
		/// <summary>Описывает текущие координаты в многострочном тексте.</summary>
		TextPoint _CurPoint;
		/// <summary>Описывает координаты в многострочном тексте предыдущего символа.</summary>
		TextPoint _PrevPoint;
		/// <summary>Текущее смещение от начала текста.</summary>
		int _Position;
		//=========================================================================================
		/// <summary>Текущая позиция во входном потоке.</summary>
		public int Position { get { return _Position; } }
		public int CharInLine { get { return this._CurPoint.Char; } }
		public int Column { get { return this._CurPoint.Col; } }
		public int Line { get { return this._CurPoint.Line; } }
		public TextPoint Point { get { return this._CurPoint; } }
		public TextPoint PreviousPoint { get { return this._PrevPoint; } }
		//=========================================================================================
		public BufferReader(int tabsize)
		{
			this.TabSize = tabsize;
		}
		//=========================================================================================
		public char ReadChar()
		{
			if (this.Position >= this.Text.Length)
				return '\0';

			this._PrevPoint = this._CurPoint;

			char cChar;
			do
			{
				if (this.Position >= this.Text.Length)
					return '\0';
				cChar = this.Text[this._Position];
				this._Position++;

				if (cChar == '\n')
				{
					this._CurPoint.Char = 0;
					this._CurPoint.Col = 0;
					this._CurPoint.Line++;
				}
				else
				{
					this._CurPoint.Char++;
					if (cChar == '\t')
					{
						do
							this._CurPoint.Col++;
						while (this._CurPoint.Col % this.TabSize != 0);
					}
					else
						this._CurPoint.Col++;
				}
			}
			while (cChar == '\r');

			return cChar;
		}
		//=========================================================================================
		public string GetSubstring(int start, int length)
		{
			for (int i = start + length - 1; i >= start; i--)
			{
				if (this.Text[i] == '\r')
					length--;
				else
					break;
			}
			return this.Text.Substring(start, length);
		}
		//=========================================================================================
		public void BackToChar()
		{
			if (this._Position <= 0)
				return;
			this._Position--;
			_CurPoint = _PrevPoint;
		}
		//=========================================================================================
		public void SetSource(string text)
		{
			this.Text = text;
			this._Position = 0;
			this._CurPoint = new TextPoint(0, 0, 0);
			this._PrevPoint = new TextPoint(0, 0, 0);
		}
		//=========================================================================================
	}
}
