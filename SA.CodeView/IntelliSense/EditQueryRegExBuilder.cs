///Список тесты:

/// Автопостановка при редактировании списка колонок:
/// Выдача на ситуацию 1 ( пробел, запятая и скобка)
/// Выдача на ситуацию 2 (после первой встреченной точки)
/// Выдача на ситуацию 3 (вторая точка в конструкции)
/// Экстраситуация: 3 точки в одном имени

/// Автопостановка при редактировании списка источников:
/// Выдача на ситуацию 4 (ЗАПЯТАЯ или пробел)
/// Выдача на ситуацию 5 (по нажатию точки)

/// Использование квадратных скобок для SQL Server, тильда для MySQL, кавычки для Access, Oracle.
/// Ситуация: ... from TableName where x < 10
/// [Все тесты реализованы]

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using SA.CodeView.Parsing;

namespace SA.CodeView.IntelliSense
{
	//#############################################################################################
	public class EditQueryRegExBuilder : SuggestionBuilder
	{
		readonly IDbInfoProvider InfoProvider;
		readonly Regex RegexSources;
		readonly List<string> Keywords;
		//=========================================================================================
		public string DefaultSchema;
		//=========================================================================================
		public EditQueryRegExBuilder(CodeViewer viewer, IDbInfoProvider infoProvider)
			: base(viewer)
		{
			this.Keywords = new List<string> { "WHERE", "SELECT", "JOIN", "ORDER", "FROM", "AS", "UPDATE", "SET" };

			this.InfoProvider = infoProvider;
			this.DefaultSchema = "dbo";

			string sWordDefinition;
			const string sWordPattern = @"(?:\w+|{0}.*?{1})";
			switch (this.Viewer.Language)
			{
				case PredefinedLanguage.MySql:
					sWordDefinition = String.Format(sWordPattern, "`", "`");
					break;

				case PredefinedLanguage.Oracle:
				case PredefinedLanguage.Access:
					sWordDefinition = String.Format(sWordPattern, "\"", "\"");
					break;

				case PredefinedLanguage.MsSql:
				default:
					sWordDefinition = String.Format(sWordPattern, @"\[", @"\]");
					break;
			}

			const string sFromJoinDefinition = @"(?:from|join|update)\s+";
			string sRegexDefinition = string.Format(
				@"(?<source>(?:(?<schema>{0})\s*\.\s*)?(?<table>{0})(?:\s*(?:AS)?\s*(?<alias>{0}))?)", sWordDefinition);
			string sRegexMultiple = string.Format(@"{0}{1}(?:\s*,\s*{1})*", sFromJoinDefinition, sRegexDefinition);
			this.RegexSources = new Regex(sRegexMultiple, RegexOptions.IgnoreCase);
		}
		//=========================================================================================
		/// <summary>Возвращает список вариантов для автоподстановки.</summary>
		public override CompletionVariantList GetVariants()
		{
			ClauseType clauseType = this.GetClauseType();
			if (clauseType == ClauseType.Unknown)
				return null;

			var components = this.GetIdComponents();
			int iComponentsCount = components == null ? 0 : components.Count;
			switch (clauseType)
			{
				case ClauseType.From:
					switch (iComponentsCount)
					{
						case 0:
							return this.Get_Variants_For_Sources_1();
						case 1:
							return this.Get_Variants_For_Sources_2(components[0]);
					}
					break;
				case ClauseType.Select:
					var sources = this.GetSources();
					switch (iComponentsCount)
					{
						case 0:
							return this.Get_Variants_For_Items_1(sources);
						case 1:
							return this.Get_Variants_For_Items_2(components[0], sources);
						case 2:
							return this.Get_Variants_For_Items_3(components[1], components[0], sources);
					}
					break;
			}

			return null;
		}
		//=========================================================================================
		/// <summary>Возвращает список источников данных.</summary>
		List<SourceInfo> GetSources()
		{
			var sources = new List<SourceInfo>();
			var matches = this.RegexSources.Matches(this.Viewer.Text);
			// Перебираем все совпадения JOIN и FROM
			foreach (Match oMatch in matches)
			{
				var sourceCaptures = oMatch.Groups["source"].Captures;
				var tableCaptures = oMatch.Groups["table"].Captures;
				var schemaCaptures = oMatch.Groups["schema"].Captures;
				var aliasCaptures = oMatch.Groups["alias"].Captures;
				foreach (Capture oSourceCapture in sourceCaptures) // Перебираем все источники
				{
					string sTable = null;
					string sSchema = null;
					string sAlias = null;

					// Перебираем все таблицы и если в источнике таблица стоит первой
					foreach (Capture oTable in tableCaptures)
						if (oTable.Index == oSourceCapture.Index)
						{
							sSchema = string.Empty;
							sTable = oTable.Value;
							break;
						}

					// Если схема указана в источнике
					if (sSchema == null)
						foreach (Capture oSchema in schemaCaptures) // Перебираем все схемы в поисках той которая совпадает с началом источника
							if (oSchema.Index == oSourceCapture.Index)
							{
								sSchema = oSchema.Value;
								foreach (Capture cTable in tableCaptures)
									if (cTable.Index == oSchema.Index + oSchema.Length + 1)
									{
										sTable = cTable.Value;
										break;
									}
								break;
							}

					// Перебираем все псевдонимы окончание которой совпадает с окончанием источника
					foreach (Capture oAlias in aliasCaptures)
						if (oAlias.Index + oAlias.Length == oSourceCapture.Index + oSourceCapture.Length)
							sAlias = oAlias.Value;

					// Перебираем все ключевые слова на случай если одно из них воспринято псевдонимом
					if (!string.IsNullOrEmpty(sAlias))
						foreach (string sKeyword in this.Keywords)
							if (string.Compare(sAlias, sKeyword, true) == 0)
							{
								sAlias = null;
								break;
							}
					var oSourceInfo = new SourceInfo(sSchema, sTable, sAlias);
					sources.Add(oSourceInfo);
				}
			}
			return sources;
		}
		//=========================================================================================
		CompletionVariantList Get_Variants_For_Items_3(string first, string second, List<SourceInfo> sources)
		{
			SourceInfo oCurrentSource = null;
			foreach (var oSource in sources)
			{
				if (string.IsNullOrEmpty(oSource.Alias) &&
					string.Compare(oSource.Schema, first, true) == 0 &&
					string.Compare(oSource.Name, second, true) == 0
					)
				{
					oCurrentSource = oSource;
					break;
				}
			}
			if (oCurrentSource != null)
				return CompletionVariantList.Combine(null,
					this.InfoProvider.GetColumnsFor(this.DropBrackets(oCurrentSource.Schema), this.DropBrackets(oCurrentSource.Name)),
					DataBaseLevel.Columns);
			else
				return CompletionVariantList.Combine(null,
					this.InfoProvider.GetColumnsFor(this.DropBrackets(first), this.DropBrackets(second)),
					DataBaseLevel.Columns);
		}
		//=========================================================================================
		CompletionVariantList Get_Variants_For_Items_2(string first, List<SourceInfo> sources)
		{
			SourceInfo oCurrentSource = null;
			foreach (var oSource in sources)
			{
				string sKey = !string.IsNullOrEmpty(oSource.Alias) ? oSource.Alias : oSource.Name;
				if (string.Compare(sKey, first, true) == 0)
				{
					oCurrentSource = oSource;
					break;
				}
			}
			if (oCurrentSource != null)
			{
				string sSchema = !string.IsNullOrEmpty(oCurrentSource.Schema) ? oCurrentSource.Schema : this.DefaultSchema;
				var names = this.InfoProvider.GetColumnsFor(this.DropBrackets(sSchema), this.DropBrackets(oCurrentSource.Name));
				return CompletionVariantList.Combine(null, names, DataBaseLevel.Columns);
			}
			CompletionVariantList items = null;
			{
				var names = this.InfoProvider.GetColumnsFor(this.DefaultSchema, this.DropBrackets(first));
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Columns);
			}
			{
				var names = this.InfoProvider.GetObjectsInSchema(this.DropBrackets(first));
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Table);
			}
			return items;
		}
		//=========================================================================================
		CompletionVariantList Get_Variants_For_Items_1(List<SourceInfo> sources)
		{
			CompletionVariantList items = null;
			//Колонки из указанных источников
			foreach (var oSource in sources)
			{
				string sSchema = !string.IsNullOrEmpty(oSource.Schema) ? oSource.Schema : this.DefaultSchema;
				var names = this.InfoProvider.GetColumnsFor(this.DropBrackets(sSchema), this.DropBrackets(oSource.Name));
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Columns);
			}
			//Указанные источники (таблицы)
			foreach (var oSource in sources)
			{
				string sName = !string.IsNullOrEmpty(oSource.Alias) ? oSource.Alias : oSource.Name;
				items = CompletionVariantList.Combine(items, sName, DataBaseLevel.Table);
			}
			//Таблицы из схемы по умолчанию
			{
				var names = this.InfoProvider.GetObjectsInSchema(this.DropBrackets(this.DefaultSchema));
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Table);
			}
			//Схемы
			{
				var names = this.InfoProvider.GetSchemas();
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Schema);
			}
			return items;
		}
		//=========================================================================================
		CompletionVariantList Get_Variants_For_Sources_2(string schema)
		{
			var names = this.InfoProvider.GetObjectsInSchema(this.DropBrackets(schema));
			return CompletionVariantList.Combine(null, names, DataBaseLevel.Table);
		}
		//=========================================================================================
		CompletionVariantList Get_Variants_For_Sources_1()
		{
			CompletionVariantList items = null;
			{
				var names = this.InfoProvider.GetSchemas();
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Schema);
			}
			{
				var names = this.InfoProvider.GetObjectsInSchema(this.DefaultSchema);
				items = CompletionVariantList.Combine(items, names, DataBaseLevel.Table);
			}
			return items;
		}
		//=========================================================================================
		/// <summary>Получить составные части идентификатора, выделенного кареткой.</summary>
		List<string> GetIdComponents()
		{
			//TODO: вынести повторяющиеся куски
			List<string> list = null;
			Token oToken;
			int iTokenIndex = this.Viewer.Caret.TokenIndex;
			oToken = this.Viewer.Tokens[iTokenIndex];
			bool bDot = oToken.Text == ".";
			if (!bDot)
			{
				if (oToken.TokenTypeName != "id" && oToken.TokenTypeName != "quotedId")
					return list;
			}
			iTokenIndex--;

			while (iTokenIndex >= 0)
			{
				oToken = this.Viewer.Tokens[iTokenIndex];
				bool bDot2 = oToken.Text == ".";
				if (bDot == bDot2)
					break;
				bDot = !bDot;
				if (!bDot)
				{
					if (oToken.TokenTypeName != "id" && oToken.TokenTypeName != "quotedId")	//TODO: уточнить условие
						break;
					if (list == null)
						list = new List<string>();
					list.Add(oToken.Text);
				}

				iTokenIndex--;
			}
			return list;
		}
		//=========================================================================================
		string DropBrackets(string text)
		{
			if (!string.IsNullOrEmpty(text) && text.Length > 2)
				switch (this.Viewer.Language)
				{
					case PredefinedLanguage.MySql:
						if (text.StartsWith("`") && text.EndsWith("`"))
							return text.Substring(1, text.Length - 2);
						break;

					case PredefinedLanguage.Oracle:
					case PredefinedLanguage.Access:
						if (text.StartsWith("\"") && text.EndsWith("\""))
							return text.Substring(1, text.Length - 2);
						break;

					case PredefinedLanguage.MsSql:
					default:
						if (text.StartsWith("[") && text.EndsWith("]"))
							return text.Substring(1, text.Length - 2);
						break;
				}
			return text;
		}
		//=========================================================================================
		enum ClauseType { Unknown, Select, From }
		//=========================================================================================
		/// <summary>Определить тип выражения, в котором находится каретка.</summary>
		ClauseType GetClauseType()
		{
			for (int i = this.Viewer.Caret.TokenIndex; i >= 0; i--)
			{
				if (
					string.Compare(this.Viewer.Tokens[i].Text, "UPDATE", true) == 0 ||
					string.Compare(this.Viewer.Tokens[i].Text, "FROM", true) == 0 ||
					string.Compare(this.Viewer.Tokens[i].Text, "JOIN", true) == 0
					)
					return ClauseType.From;
				if (
					string.Compare(this.Viewer.Tokens[i].Text, "SET", true) == 0 ||
					string.Compare(this.Viewer.Tokens[i].Text, "SELECT", true) == 0 ||
					string.Compare(this.Viewer.Tokens[i].Text, "BY", true) == 0 ||
					string.Compare(this.Viewer.Tokens[i].Text, "WHERE", true) == 0
					)
					return ClauseType.Select;
			}
			return ClauseType.Unknown;
		}
		//=========================================================================================
		//#########################################################################################
		/// <summary>Класс-посредник хранящие источник данных.</summary>
		class SourceInfo
		{
			public readonly string Schema;
			public readonly string Name;
			public readonly string Alias;
			//=====================================================================================
			public SourceInfo(string schema, string name, string alias)
			{
				this.Schema = schema;
				this.Name = name;
				this.Alias = alias;
			}
			//=====================================================================================
		}
		//#########################################################################################
	}
}
