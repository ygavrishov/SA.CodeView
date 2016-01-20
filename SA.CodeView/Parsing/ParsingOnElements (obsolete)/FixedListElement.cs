using System;
using System.Collections.Generic;

namespace SA.CodeView.ParsingOnElements
{
	/// <summary>Фрагмент текста сопоставляется с элементом, если он совпадает с одним из ключевых слов элемента.</summary>
	class FixedListElement : BaseElement
	{
		/// <summary>Список ключевых слов.</summary>
		public List<string> Keywords;
		//=========================================================================================
		public FixedListElement(TextStyle style)
			: base(style)
		{
			this.Keywords = new List<string>();
		}
		//=========================================================================================
	}
}
