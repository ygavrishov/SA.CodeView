using System;

namespace SA.CodeView.Parsing.TokenDefParsing
{
	partial class Parser
	{
		/// <summary>Спецификация работы сканера, для которой мы формируем граф переходов.</summary>
		public ScannerSpecification Spec;
		//=========================================================================================
		public void Parse()
		{
			this._Parse();
		}
		//=========================================================================================
	}
}
