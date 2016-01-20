using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;

namespace SA.CodeView.IntelliSense
{
	public class IntelliSenseListView : ListView
	{
		#region WinAPI constants

		const int GWL_STYLE = -16; // Retrieves the window styles used in GetWindowLong()

		private const int WS_HSCROLL = 0x00100000; // The window has a horizontal scroll bar.
		private const int WM_NCCALCSIZE = 0x83; // Sent when the size and position of a window's client area must be calculated

		private const int WM_MOUSEACTIVATE = 0x0021; // Отправляется когда курсор находится в неактивном окне, а пользователь нажимает кнопку мыши
		private const int MA_NOACTIVATE = 0x0003; // Не активизирует окно и не сбрасывает сообщение мыши.

		private const int WM_LBUTTONDOWN = 0x0201;
		private const int WM_LBUTTONDBLCLK = 0x0203;
		private const int WM_RBUTTONDOWN = 0x0204;
		private const int WM_MBUTTONDOWN = 0x0207;
		private const int WM_MBUTTONDBLCLK = 0x0209;
		private const int WM_RBUTTONDBLCLK = 0x0206;


		// The WM_VSCROLL message is sent to a window when a scroll event occurs in the window's standard vertical scroll bar.
		private const int WM_VSCROLL = 0x115;
		private const int SB_LINEUP = 0; // Scrolls one line up.
		private const int SB_LINEDOWN = 1; // Scrolls one line down.

		#endregion
		//============================================================================================
		public event EventHandler ApplyVariantEvent;
		//============================================================================================
		public IntelliSenseListView()
		{
			// Использование Двойной Буферизации для предотврщания мигания ListView при выборе элементов
			base.SetStyle(ControlStyles.OptimizedDoubleBuffer, true);
		}
		//============================================================================================
		/// <summary>Хранит индекс выбранного элемента</summary>
		[DefaultValue(-1)]
		public int SelectedIndex { get; private set; }
		//============================================================================================
		protected override void WndProc(ref Message m)
		{
			switch (m.Msg)
			{
				// Попытка просчитать размер и позицию окна
				case WM_NCCALCSIZE:
					HideHScroll();
					base.WndProc(ref m);
					break;

				// Выбираем элемент, не передавая фокус
				case WM_LBUTTONDOWN:
					this.SelectItemOnLButtonDown(m);
					break;

				// Выбираем элемент и подставляем его
				case WM_LBUTTONDBLCLK:
					this.SelectItemOnLButtonDown(m);

					if (this.ApplyVariantEvent != null)
						this.ApplyVariantEvent(this, EventArgs.Empty);
					break;

				// Отлавливаем сообщения, не передавая фокус
				case WM_RBUTTONDOWN:
				case WM_MBUTTONDOWN:
				case WM_MBUTTONDBLCLK:
				case WM_RBUTTONDBLCLK:
					break;

				// Попытка активировать окно прерывается
				case WM_MOUSEACTIVATE:
					m.Result = (IntPtr)MA_NOACTIVATE;
					break;

				default:
					base.WndProc(ref m);
					break;
			}
		}

		private void SelectItemOnLButtonDown(Message m)
		{
			Point point = WinAPI.GetPointFromLParam(m.LParam);

			ListViewItem item = this.GetItemAt(point.X, point.Y);
			if (item != null)
				this.SelectItem(item);
		}
		//============================================================================================
		/// <summary>Скрывает горизонтальный скрол через стили окна при его инициализации</summary>
		void HideHScroll()
		{
			int style = (int)WinAPI.GetWindowLong(this.Handle, GWL_STYLE);
			if ((style & WS_HSCROLL) == WS_HSCROLL)
				WinAPI.SetWindowLong(this.Handle, GWL_STYLE, style & ~WS_HSCROLL);
		}
		//============================================================================================
		/// <summary>Выбрать элемент</summary>
		public void SelectItem(ListViewItem item)
		{
			this.SelectItem(item.Index);
		}

		/// <summary>Выбрать элемент</summary>
		public void SelectItem(int itemIndex)
		{
			if (Items.Count <= itemIndex || itemIndex < 0)
				return;

			// Снимаем атрибуты выделения если надо
			if (SelectedIndex >= 0 && SelectedIndex < Items.Count)
			{
				Items[SelectedIndex].Selected = false;
				Items[SelectedIndex].Focused = false;
			}

			// Ставим
			this.SelectedIndex = itemIndex;
			
			Items[SelectedIndex].Selected = true;
			Items[SelectedIndex].Focused = true;

			// Демонстрируем
			EnsureVisible(itemIndex);
		}
		//============================================================================================
		/// <summary>Снимает выделение с элемента, оставляя лишь фокусную рамку</summary>
		public void DeselectItem()
		{
			if (SelectedIndex >= 0 && SelectedIndex < Items.Count)
				Items[SelectedIndex].Selected = false;
		}
		//============================================================================================
		/// <summary>Пролистать ListView на заданную величину</summary>
		public void ScrollListView(int wheelDelta)
		{
			int direction = wheelDelta > 0 ? SB_LINEUP : SB_LINEDOWN;
			int linesCount = Math.Abs(wheelDelta);

			for (int i = 0; i < linesCount; i++)
				WinAPI.SendMessage(this.Handle, (int)WM_VSCROLL, (IntPtr)direction, IntPtr.Zero);
		}
		//============================================================================================
		/// <summary>Возвращает высоту одного элемента ListView</summary>
		public int GetListViewItemHeight()
		{
			// Если список пуст добавляем пустой элемент для замера высоты
			if (this.Items.Count == 0)
				this.Items.Add(String.Empty);

			int itemHeight = this.Items[0].Bounds.Height;

			if (this.Items.Count == 1)
				this.Items[0].Remove();

			return itemHeight;
		}
		//============================================================================================
		/// <summary>Отрисовывает элементы как OwnerDraw.</summary>
		protected override void OnDrawItem(DrawListViewItemEventArgs e)
		{
			ListViewItem item = e.Item;
			Rectangle itemBound = e.Bounds;
			Graphics graphics = e.Graphics;
			Image icon = item.ImageList.Images[item.ImageIndex];

			// Меняем рамку выделения и фокуса вынося за иконку
			itemBound.Width -= icon.Width;
			itemBound.X += icon.Width;

			// Прорисовка выделения
			Brush itemBackgroundBrush;
			if (item.Selected)
				itemBackgroundBrush = SystemBrushes.Highlight;
			else
				itemBackgroundBrush = SystemBrushes.Window;

			graphics.FillRectangle(itemBackgroundBrush, itemBound);

			// Прорисовка фокуса
			if (item.Focused)
				ControlPaint.DrawFocusRectangle(graphics, itemBound);

			// Отрисовываем иконку
			Point iconLocation = this.FindBestIconPosition(icon, item.Bounds);
			graphics.DrawImage(icon, iconLocation);

			// Отрисовка текста
			Point textLocation = this.FindBestTextPosition(item.Font, iconLocation, icon.Size, e.Item.Bounds);
			Brush textBrush;
			if (item.Selected)
				textBrush = SystemBrushes.HighlightText;
			else
				textBrush = SystemBrushes.WindowText;
			graphics.DrawString(item.Text, item.Font, textBrush, textLocation);
		}
		//============================================================================================
		/// <summary>Находит оптимальную позицию для текста</summary>
		private Point FindBestTextPosition(Font font, Point iconLocation, Size iconSize, Rectangle bounds)
		{
			// Левый отступ
			const int iLeftMargin = 0;

			Point textLocation = new Point(bounds.X, bounds.Y);
			textLocation.X += iconLocation.X + iconSize.Width + iLeftMargin;
			textLocation.Y += (bounds.Height - (int)font.GetHeight()) / 2;

			return textLocation;
		}
		//============================================================================================
		/// <summary>Находит оптимальную позицию для иконки</summary>
		private Point FindBestIconPosition(Image icon, Rectangle bounds)
		{
			// Левый отступ
			const int iLeftMargin = 0;

			Point iconLocation = new Point(bounds.X, bounds.Y);
			iconLocation.X += iLeftMargin;
			iconLocation.Y += (bounds.Height - icon.Height) / 2;

			return iconLocation;
		}
		//============================================================================================
	}
}
