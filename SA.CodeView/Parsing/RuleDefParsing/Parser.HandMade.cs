using System;

namespace SA.CodeView.Parsing.RuleDefParsing
{
	partial class Parser
	{
		/// <summary>Спецификация работы сканера, для которой мы формируем граф переходов.</summary>
		public ParserSpecification Spec;
		//=========================================================================================
		public void Parse()
		{
			this._Parse();
		}
		//=========================================================================================
	}
}
