using System;

namespace SA.CodeView.ParsingOnElements
{
	/// <summary>Правило, по которому токен должен иметь определенные начальные и конечные символы.</summary>
	class BoundedElement : BaseElement
	{
		public readonly TextStyle BoundStyle;
		/// <summary>Текст токена должен начинаться с этих символов.</summary>
		public readonly string StartSymbols;
		/// <summary>Текст токена должен завершаться этими символами. Если это поле пустое, то токен длится до конца строки.</summary>
		public readonly string EndSymbols;
		/// <summary>Указывает, как можно вставить в текст завершающие символы, так чтобы они не считались завершающими.</summary>
		public readonly string Escape;
		//=========================================================================================
		public BoundedElement(TextStyle style, string startSymbols, string endSymbols, string escape)
			: this(style, (TextStyle)null, startSymbols, endSymbols)
		{
			this.Escape = escape;
		}
		//=========================================================================================
		public BoundedElement(TextStyle style, string startSymbols, string endSymbols)
			: this(style, (TextStyle)null, startSymbols, endSymbols) { }
		//=========================================================================================
		public BoundedElement(TextStyle bodyStyle, TextStyle boundStyle, string startSymbols, string endSymbols)
			: base(bodyStyle)
		{
			this.BoundStyle = boundStyle;
			this.StartSymbols = startSymbols;
			this.EndSymbols = endSymbols;
		}
		//=========================================================================================
	}
}
