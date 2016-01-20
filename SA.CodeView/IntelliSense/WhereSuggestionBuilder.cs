using System;

namespace SA.CodeView.IntelliSense
{
	public class WhereSuggestionBuilder : SuggestionBuilder
	{
		readonly IDbInfoProvider InfoProvider;
		//=========================================================================================
		readonly string Schema;
		readonly string Table;
		//=========================================================================================
		public WhereSuggestionBuilder(CodeViewer viewer, IDbInfoProvider infoProvider, string schema, string table)
			: base(viewer)
		{
			this.InfoProvider = infoProvider;
			this.Schema = schema;
			this.Table = table;
		}
		//=========================================================================================
		public override CompletionVariantList GetVariants()
		{
			CompletionVariantList items = null;
			var names = this.InfoProvider.GetColumnsFor(this.Schema, this.Table);
			items = CompletionVariantList.Combine(items, names, DataBaseLevel.Columns);

			return items;
		}
		//=========================================================================================
	}
}
