using System.Collections.Generic;

namespace SA.CodeView.Parsing
{
	interface ISyntaxParser
	{
		List<Token> Parse(List<string> lines);
	}
}
