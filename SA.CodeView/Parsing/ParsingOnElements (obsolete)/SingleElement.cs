using System;

namespace SA.CodeView.ParsingOnElements
{
	class SingleElement : BaseElement
	{
		public readonly string Text;
		ElementContent Content;
		//=========================================================================================
		public SingleElement(string text)
			: base(null)
		{
			this.Content = ElementContent.Specified;
			this.Text = text;
		}
		//=========================================================================================
		public SingleElement(ElementContent content)
			: base(null)
		{
			this.Content = content;
			this.Text = string.Empty;
		}
		//=========================================================================================
	}
}
