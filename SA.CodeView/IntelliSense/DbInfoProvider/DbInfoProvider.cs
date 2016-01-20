using System;
using System.Collections.Generic;
using System.Text;

namespace SA.CodeView.IntelliSense
{
	public interface IDbInfoProvider
	{
		List<string> GetSchemas();
		List<string> GetObjectsInSchema(string schema);
		List<string> GetColumnsFor(string schema, string table);
	}
}
