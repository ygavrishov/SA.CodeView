using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.Parsing;
using SA.CodeView.ParsingOnElements;

namespace SA.CodeView.Languages
{
	class NonSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public NonSyntaxSettings()
		{
			this.Operators = new char[] { };
		}
		//=========================================================================================
		protected override Dictionary<string, TextStyle> CreateTextStyles()
		{
			var styles = base.CreateTextStyles();
			this.AddStyle(styles, new TextStyle(S_OPERATORS, Color.Teal));
			return styles;
		}
		//=========================================================================================
		protected override List<BaseElement> CreateElements()
		{
			return new List<BaseElement>();
		}
		//=========================================================================================
		internal override ScannerSpecification CreateScannerSpecification()
		{
			var oSpec = new ScannerSpecification();
			oSpec.AddLiteral("any", CharType.AnyNonSpaces);
			oSpec.AddTokenDeclaration("all", "any{any}");
			return oSpec;
		}
		//=========================================================================================
	}
}
