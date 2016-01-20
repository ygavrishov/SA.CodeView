using System.Collections.Generic;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.IntelliSense;
using Tests.IntelliSense.BLL;

namespace Tests.IntelliSense
{
	[TestFixture]
	public class CodeCompletorTestsExtra
	{
		readonly CodeViewer Viewer;
		//=========================================================================================
		public CodeCompletorTestsExtra()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;

			var oTestProvider = new TestDbInfoProvider();
			var oSugBuilder = new EditQueryRegExBuilder(Viewer, oTestProvider);
			oSugBuilder.DefaultSchema = "Schema_Second";

			this.Viewer.UseSuggestionRules(oSugBuilder);
		}
		//=========================================================================================
		private List<CompletionVariant> Get_Expected_Variants_For_Situation_1()
		{
			return new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "First Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Last Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "fstUser", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
			});
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_space()
		{
			Viewer.Text = "select  from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select ".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = this.Get_Expected_Variants_For_Situation_1();
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_comma()
		{
			Viewer.Text = "select Name, from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select Name,".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = this.Get_Expected_Variants_For_Situation_1();
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_bracket()
		{
			Viewer.Text = "select cast( from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select cast(".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			var expectedVariants = this.Get_Expected_Variants_For_Situation_1();
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_third_dot()
		{
			Viewer.Text = "select Schema_Second.Fruits.Apple. from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select Schema_Second.Fruits.Apple.".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNull(variants);
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_first_dot_with_schema()
		{
			Viewer.Text = "select Schema_Second. from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select Schema_Second.".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table });
			expectedVariants.Add(new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_first_dot_with_alias()
		{
			Viewer.Text = "select fstUser. from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select fstUser.".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "First Name", ImageIndex = (int)DataBaseLevel.Columns });
			expectedVariants.Add(new CompletionVariant() { Text = "Last Name", ImageIndex = (int)DataBaseLevel.Columns });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_after_second_dot()
		{
			Viewer.Text = "select Schema_Second.Fruits. from Schema_First.User as fstUser";
			Viewer.Caret.MoveToPos(0, "select Schema_Second.Fruits.".Length, true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns });
			expectedVariants.Add(new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_schemas_after_space()
		{
			Viewer.Text = "from ";
			Viewer.Caret.MoveDocEnd(true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table });
			expectedVariants.Add(new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_schemas_after_comma()
		{
			Viewer.Text = "from Schema_First.User, ";
			Viewer.Caret.MoveDocEnd(true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema });
			expectedVariants.Add(new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table });
			expectedVariants.Add(new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_tables_after_dot()
		{
			Viewer.Text = "from Schema_Second.";
			Viewer.Caret.MoveDocEnd(true);

			var variants = Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table });
			expectedVariants.Add(new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_tables_after_dot_with_brackets()
		{
			bool bMSSQLTested, bMySQLTested, bOracleTested, bAccessTested;
			bMSSQLTested = bMySQLTested = bOracleTested = bAccessTested = false;

			for (int i = 0; i < 4; i++)
			{
				if (!bMSSQLTested)
					this.Viewer.Text = "from [Schema Third].";
				else if (!bMySQLTested)
				{
					this.Viewer.Language = PredefinedLanguage.MySql;
					this.Viewer.Text = "from ~Schema Third~.";
				}
				else if (!bOracleTested)
				{
					this.Viewer.Language = PredefinedLanguage.Oracle;
					this.Viewer.Text = "from 'Schema Third'.";
				}
				else if (!bAccessTested)
				{
					this.Viewer.Language = PredefinedLanguage.Access;
					this.Viewer.Text = "from 'Schema Third'.";
				}

				Viewer.Caret.MoveDocEnd(true);

				var variants = Viewer.CodeCompletor.Builder.GetVariants();
				Assert.IsNotNull(variants);

				List<CompletionVariant> expectedVariants = new List<CompletionVariant>();
				expectedVariants.Add(new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table });
				expectedVariants.Add(new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table });

				Assert.That(variants, Is.EquivalentTo(expectedVariants));
			}
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_with_sys_words()
		{
			this.Viewer.Text = "select  from Schema_Second.Fruits WHERE 1 = 1";
			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table},
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table},
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
			});
			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_columns_with_alias()
		{
			this.Viewer.Text = "select FROODZ. from Schema_Second.Fruits as FROODZ";
			this.Viewer.Caret.MoveToPos(0, "select FROODZ.".Length, true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			var expectedVariants = new List<CompletionVariant>();
			expectedVariants.Add(new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns });
			expectedVariants.Add(new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns });

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_tables_if_default_table_was_placed_first()
		{
			this.Viewer.Text = "from Fruits, Schema_First.";
			this.Viewer.Caret.MoveDocEnd(true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);
		}
		//=========================================================================================
		[Test]
		public void Get_variants_for_tables_when_there_are_default_table_and_2_sources_with_aliases()
		{
			this.Viewer.Text = "select  from Fruits, Schema_First.User as test";
			this.Viewer.Caret.MoveToPos(0, "select ".Length, true);

			var variants = this.Viewer.CodeCompletor.Builder.GetVariants();
			Assert.IsNotNull(variants);

			var expectedVariants = new List<CompletionVariant>(new[]
			{
				new CompletionVariant() { Text = "Apple", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Lemon", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "First Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Last Name", ImageIndex = (int)DataBaseLevel.Columns },
				new CompletionVariant() { Text = "Fruits", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "test", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Vitamins", ImageIndex = (int)DataBaseLevel.Table },
				new CompletionVariant() { Text = "Schema_First", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema_Second", ImageIndex = (int)DataBaseLevel.Schema },
				new CompletionVariant() { Text = "Schema Third", ImageIndex = (int)DataBaseLevel.Schema },
			});

			Assert.That(variants, Is.EquivalentTo(expectedVariants));
		}
		//=========================================================================================
	}
}
