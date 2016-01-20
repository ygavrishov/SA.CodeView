using System;

namespace SA.CodeView.Parsing
{
	/// <summary>Фрагмент текста, имеющий координаты в исходном тексте и обладающий собственным стилем отображения.</summary>
	public class Token
	{
		/// <summary>Указатель на начало подстроки в исходном тексте.</summary>
		public readonly TextPoint Start;
		/// <summary>Указатель на символ, следующий за последним.</summary>
		public readonly TextPoint End;
		/// <summary>Стиль отображения текста токена.</summary>
		public TextStyle Style { get; internal set; }
		/// <summary>Текст, составляющий токен.</summary>
		public readonly string Text;
		/// <summary>Название токена, характеризующее его тип.</summary>
		public readonly string TokenTypeName;
		//=========================================================================================
		public Token(string typeName, string text, TextPoint start, TextPoint end, TextStyle style)
		{
			this.TokenTypeName = typeName;
			this.Text = text;
			this.Start = start;
			this.End = end;
			this.Style = style;
		}
		//=========================================================================================
		public Token(string text, TextPoint start, TextPoint end, TextStyle style)
			: this(null, text, start, end, style)
		{
		}
		//=========================================================================================
		public override string ToString()
		{
			if (this.Style == null)
				return this.Text;
			else
				return string.Format("{0} - {1}", this.Style.Name, this.Text);
		}
		//=========================================================================================
	}
}
