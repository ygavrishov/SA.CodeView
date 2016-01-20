using System.Drawing;
using Moq;
using NUnit.Framework;
using SA.CodeView;

namespace Tests.CodeViewing
{
	[TestFixture]
	public class RendererTests
	{
		CodeViewer Viewer;
		Graphics MyGraphics;
		//=========================================================================================
		public RendererTests()
		{
			this.Viewer = new CodeViewer();
			this.Viewer.Language = PredefinedLanguage.MsSql;
			this.Viewer.Size = new Size(400, 400);

			Bitmap oBitmap = new Bitmap(1, 1);
			this.MyGraphics = Graphics.FromImage(oBitmap);
		}
		//=========================================================================================
		[Test]
		public void Draw_token_with_selection_in_the_middle()
		{
			///Arrange
			this.Viewer.Text = "select";
			this.Viewer.Caret.MoveToPos(0, 2, true);
			this.Viewer.Caret.MoveToPos(0, 5, false);
			var oRenderer = new Mock<DocumentViewRenderer>(this.Viewer);

			///Act
			oRenderer.Object.DrawLinesWithSelection(new Point(), this.MyGraphics);

			///Assert
			oRenderer.Verify(x => x.DrawText(
				this.MyGraphics,
				"lec",
				2,
				It.IsAny<Point>(),
				It.IsAny<Color>()));

			oRenderer.Verify(x => x.DrawText(
				this.MyGraphics,
				"se",
				0,
				It.IsAny<Point>(),
				It.IsAny<Color>()));

			oRenderer.Verify(x => x.DrawText(
				this.MyGraphics,
				"t",
				5,
				It.IsAny<Point>(),
				It.IsAny<Color>()));
		}
		//=========================================================================================
		[Test]
		public void Draw_token_when_selected_caret_return_and_start_of_line()
		{
			///Arrange
			this.Viewer.Text = "ab\r\ncde";
			this.Viewer.Caret.MoveToPos(0, 2, true);
			this.Viewer.Caret.MoveDocEnd(false);

			var oRenderer = new Mock<DocumentViewRenderer>(this.Viewer);

			///Act
			oRenderer.Object.DrawLinesWithSelection(new Point(), this.MyGraphics);

			///Assert
			//Check that 'cde' text was rendered at 0 position
			oRenderer.Verify(x => x.DrawText(
				this.MyGraphics,
				"cde",
				0,
				It.IsAny<Point>(),
				It.IsAny<Color>()));

			//There were 2 invocations of drawing
			oRenderer.Verify(x => x.DrawText(
				this.MyGraphics,
				It.IsAny<string>(),
				It.IsAny<int>(),
				It.IsAny<Point>(),
				It.IsAny<Color>()), Times.Exactly(2));
		}
		//=========================================================================================
	}
}
