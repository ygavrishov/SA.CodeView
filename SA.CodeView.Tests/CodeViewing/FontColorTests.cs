using System.Drawing;
using NUnit.Framework;
using SA.CodeView;
using SA.CodeView.Languages;

namespace Tests.CodeViewing
{
	[TestFixture]
	public class FontColorTests
	{
		const string Script = @"
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view1] (id)
as select 1
GO";
		//=========================================================================================
		[Test]
		public void Getting_style_by_name()
		{
			CodeViewer oViewer = new CodeViewer();
			oViewer.Language = PredefinedLanguage.MsSql;
			oViewer.Text = Script;

			SyntaxSettings oSettings = oViewer.SyntaxSettings;

			TextStyle oStyle = oSettings.GetStyleByName(SyntaxSettings.S_KEYWORDS_1);
			Assert.AreEqual(oStyle.ForeColor, Color.Blue);
		}
		//=========================================================================================
		[Test]
		public void Change_font()
		{
			CodeViewer oViewer = new CodeViewer();
			oViewer.Language = PredefinedLanguage.MsSql;
			oViewer.Text = Script;

			Assert.AreEqual(oViewer.Font.Name, "Consolas");
			oViewer.Body.Font = new Font("Arial", 12);
			Assert.AreEqual(oViewer.Font.Name, "Arial");
		}
		//=========================================================================================
	}
}
