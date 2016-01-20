using System;
using System.Collections.Generic;

namespace SA.CodeView.ParsingOnElements
{
	class Sequence : BaseElement
	{
		public int MinOccurs = 1;
		public int MaxOccurs = 1;
		public readonly List<BaseElement> Elements;
		//=========================================================================================
		public Sequence() : base(null)
		{
			this.Elements = new List<BaseElement>();
		}
		//=========================================================================================
	}
}
