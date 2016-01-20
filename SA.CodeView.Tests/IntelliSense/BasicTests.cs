using System;
using NUnit.Framework;
using SA.CodeView;
using NUnit.Framework.SyntaxHelpers;
using SA.CodeView.IntelliSense;
using System.Windows.Forms;
using System.Drawing;
using System.Collections.Generic;

namespace Tests.IntelliSense
{
	[TestFixture]
	public class BasicTests
	{
		//=========================================================================================
		/// <summary>Инициализация.</summary>
		[SetUp]
		public void Init() { }
		//=========================================================================================
		/// <summary>Линковка.</summary>
		[Test]
		public void Linking()
		{
			CodeViewer oViewer = new CodeViewer();
			Assert.IsNull(oViewer.CodeCompletor);
			
			oViewer.ReadOnly = false;
			Assert.IsNull(oViewer.CodeCompletor);

			TestDbInfoProvider oTestProvider = new TestDbInfoProvider();
			var oSuggestionBuilder = new EditQueryRegExBuilder(oViewer, oTestProvider);

			oViewer.UseSuggestionRules(oSuggestionBuilder);

			Assert.IsNotNull(oViewer.CodeCompletor);
			Assert.IsNotNull(oViewer.CodeCompletor.Builder);
			Assert.AreEqual(oSuggestionBuilder, oViewer.CodeCompletor.Builder);
		}
	}
}