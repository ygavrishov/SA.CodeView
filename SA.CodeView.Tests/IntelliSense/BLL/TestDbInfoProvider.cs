using System.Collections.Generic;
using SA.CodeView.IntelliSense;

namespace Tests.IntelliSense.BLL
{
	/// <summary>Базовый класс варианта выпадающего списка</summary>
	abstract class BaseVariant
	{
		public string Name;
	}
	/// <summary>Класс варианта выпадающего списка со списком схем</summary>
	class TopLevelVariant : BaseVariant
	{
		public List<SchemaVariant> Schemas;
	}
	/// <summary>Класс варианта выпадающего списка со списком таблиц</summary>
	class SchemaVariant : BaseVariant
	{
		public List<TableVariant> Tables;
	}
	/// <summary>Класс варианта выпадающего списка со списком колонок</summary>
	class TableVariant : BaseVariant
	{
		public string[] Columns;
	}
	/// <summary>Тестовый провайдер данных БД</summary>
	public class TestDbInfoProvider : IDbInfoProvider
	{
		/// <summary>Тестовые данные псевдо-БД</summary>
		TopLevelVariant Variants;
		//=========================================================================================
		public TestDbInfoProvider()
		{
			CreateTestData();
		}
		//=========================================================================================
		/// <summary>Создает данные о псевдо-БД.</summary>
		private void CreateTestData()
		{
			TableVariant oTableUser = new TableVariant() { Name = "User", Columns = new string[] { "First Name", "Last Name" } };
			TableVariant oTableOrg = new TableVariant() { Name = "Org", Columns = new string[] { "Name", "Address" } };

			SchemaVariant oSchemaFirst = new SchemaVariant() { Name = "Schema_First", Tables = new List<TableVariant>() { oTableUser, oTableOrg } };

			TableVariant oTableFruits = new TableVariant() { Name = "Fruits", Columns = new string[] { "Apple", "Lemon" } };
			TableVariant oTableVitamins = new TableVariant() { Name = "Vitamins", Columns = new string[] { "A", "B" } };

			SchemaVariant oSchemaSecond = new SchemaVariant() { Name = "Schema_Second", Tables = new List<TableVariant>() { oTableFruits, oTableVitamins } };
			SchemaVariant oSchemaThird = new SchemaVariant() { Name = "Schema Third", Tables = new List<TableVariant>() { oTableFruits, oTableVitamins } };
			//SchemaVariant oSchemaTest = new SchemaVariant() { Name = "Test" };

			this.Variants = new TopLevelVariant() { Schemas = new List<SchemaVariant>() { oSchemaFirst, oSchemaSecond, oSchemaThird } };
		}
		//=========================================================================================
		/// <summary>Возвращает список схем.</summary>
		public List<string> GetSchemas()
		{
			List<string> items = new List<string>();

			foreach (SchemaVariant var in Variants.Schemas)
			{
				items.Add(var.Name);
			}

			return items;
		}
		//=========================================================================================
		/// <summary>Возвращает список таблиц.</summary>
		public List<string> GetObjectsInSchema(string schema)
		{
			//TODO: возвращать null, если пусто
			//schema = schema.Trim(new char[] { '[', ']', '~', '\'' });

			List<string> items = new List<string>();

			foreach (SchemaVariant var in Variants.Schemas)
			{
				bool bIsEqualSchemas = string.Compare(var.Name, schema, true) == 0;
				if (bIsEqualSchemas)
					foreach (TableVariant tableVar in var.Tables)
						items.Add(tableVar.Name);
			}

			return items;
		}
		//=========================================================================================
		/// <summary>Возвращает список колонок.</summary>
		public List<string> GetColumnsFor(string schema, string table)
		{
			//schema = schema.Trim(new char[] { '[', ']', '~', '\'' });
			//table = table.Trim(new char[] { '[', ']', '~', '\'' });

			List<string> items = new List<string>();

			foreach (SchemaVariant var in Variants.Schemas)
			{
				bool isEqualSchemas = string.Compare(var.Name, schema, true) == 0;
				if (isEqualSchemas)
				{
					foreach (TableVariant tableVar in var.Tables)
					{
						bool isEqualTables = string.Compare(tableVar.Name, table, true) == 0;
						if (isEqualTables)
						{
							return new List<string>(tableVar.Columns);
						}
					}
				}
			}

			return items;
		}
	}
}
