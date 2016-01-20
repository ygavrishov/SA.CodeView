using System.Collections.Generic;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.IntelliSense;
using Tests.IntelliSense.BLL;

namespace Tests.IntelliSense
{
	[TestFixture]
	public class CodeCompletorTests
	{
		CodeViewer Viewer;
		//=========================================================================================
		[SetUp]
		public void SetUp()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;

			var oTestProvider = new TestDbInfoProvider();
			var oSuggestionBuilder = new EditQueryRegExBuilder(Viewer, oTestProvider);
			oSuggestionBuilder.DefaultSchema = "Schema_Second";

			Viewer.UseSuggestionRules(oSuggestionBuilder);
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_schemas()
		{
			Viewer.Text = "select * from ";
			Viewer.Caret.MoveDocEnd(true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table },
			});
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_tables_after_schema()
		{
			this.Viewer.Text = "select * from Schema_First.";
			this.Viewer.Caret.MoveDocEnd(true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "User", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Org", ImageIndex = (int)DataBaseLevel.Table },
			});

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns()
		{
			this.Viewer.Text = "select  from Schema_First.User";
			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "First Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Last Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "User", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
			});
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		/// <summary>Getting column variants when we know table name.</summary>
		[Test]
		public void Get_variants_for_items_2_columns_for_table()
		{
			this.Viewer.Text = "select Fruits.";
			this.Viewer.Caret.MoveDocEnd(true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns },
			});
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_when_join_is_used()
		{
			this.Viewer.Text = @"select  from Schema_First.User \r\n left outer join Schema_Second.Fruits";
			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "First Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Last Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "User", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
			});
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void AutoComplete_table_name_after_schema()
		{
			Viewer.Text = "Select * from \t Schema_Second.fr";
			Viewer.Caret.MoveDocEnd(true);

			Viewer.CodeCompletor.AutoComplete();
			Assert.AreEqual("Select * from \t Schema_Second.Fruits", Viewer.Text);
		}
		//=========================================================================================
		[Test]
		public void AutoComplete_column_name()
		{
			Viewer.Text = "Select N from \t Schema_First.Org";
			Viewer.Caret.MoveToPos(this.Viewer.Caret.Line, "Select N".Length, true);

			Viewer.CodeCompletor.AutoComplete();
			Assert.AreEqual("Select Name from \t Schema_First.Org", Viewer.Text);
		}
		//=========================================================================================
		[Test]
		public void AutoComplete_with_one_variant_after_join_and_schema()
		{
			this.Viewer.Text = "Select lemon from Schema_Second.Fruits\r\ninner join Schema_Second.fr";
			this.Viewer.Caret.MoveDocEnd(true);

			this.Viewer.CodeCompletor.AutoComplete();
			//Text should be the same as before
			Assert.AreEqual("Select lemon from Schema_Second.Fruits\r\ninner join Schema_Second.Fruits", this.Viewer.Text);
		}
		//=========================================================================================
	}
}
