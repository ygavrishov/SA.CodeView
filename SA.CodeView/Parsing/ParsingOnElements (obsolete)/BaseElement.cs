using System;

namespace SA.CodeView.ParsingOnElements
{
	/// <summary>Базовый класс для элементов, на которые нужно разбить входной текст.</summary>
	public abstract class BaseElement
	{
		/// <summary>Стиль отображения текста.</summary>
		public readonly TextStyle Style;
		//=========================================================================================
		public BaseElement(TextStyle style)
		{
			this.Style = style;
		}
		//=========================================================================================
	}
}
