using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace SA.CodeView.IntelliSense
{
	class IntellisenseForm : Form
	{
		/// <summary>Контрол-владелец.</summary>
		Control ControlOwner { get; set; }
		//==================================================================================
		/// <summary>Расположение Intellisense формы на родительском контроле.</summary>
		internal Point RelativeLocation { get; private set; }
		//==================================================================================
		private IntellisenseMessageFilter _Filter;
		/// <summary>Фильтр сообщений для отлова событий мышки во время вызова.</summary>
		private IntellisenseMessageFilter Filter
		{
			get
			{
				if (_Filter == null)
					_Filter = new IntellisenseMessageFilter(this);
				return _Filter;
			}
		}
		//=========================================================================================
		#region Form elements
		private System.ComponentModel.IContainer components = null;
		private System.Windows.Forms.ImageList imageList;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		internal IntelliSenseListView listItems;
		#endregion
		//=========================================================================================
		#region Windows Form Designer generated code
		//=========================================================================================
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
				components.Dispose();
			base.Dispose(disposing);
		}
		//=========================================================================================
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(IntellisenseForm));
			System.Windows.Forms.ListViewItem listViewItem1 = new System.Windows.Forms.ListViewItem("FROM", 2);
			System.Windows.Forms.ListViewItem listViewItem2 = new System.Windows.Forms.ListViewItem("SELECT", 1);
			System.Windows.Forms.ListViewItem listViewItem3 = new System.Windows.Forms.ListViewItem("WHERE", 0);
			System.Windows.Forms.ListViewItem listViewItem4 = new System.Windows.Forms.ListViewItem("UNION", 3);
			this.imageList = new System.Windows.Forms.ImageList(this.components);
			this.listItems = new SA.CodeView.IntelliSense.IntelliSenseListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.SuspendLayout();
			// 
			// imageList
			// 
			this.imageList.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList.ImageStream")));
			this.imageList.TransparentColor = System.Drawing.Color.Transparent;
			this.imageList.Images.SetKeyName(0, "db.bmp");
			this.imageList.Images.SetKeyName(1, "schema.bmp");
			this.imageList.Images.SetKeyName(2, "table.bmp");
			this.imageList.Images.SetKeyName(3, "column.bmp");
			// 
			// listItems
			// 
			this.listItems.Alignment = System.Windows.Forms.ListViewAlignment.Left;
			this.listItems.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this.listItems.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.listItems.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1});
			this.listItems.FullRowSelect = true;
			this.listItems.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.listItems.HideSelection = false;
			this.listItems.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem1,
            listViewItem2,
            listViewItem3,
            listViewItem4});
			this.listItems.Location = new System.Drawing.Point(0, 0);
			this.listItems.Margin = new System.Windows.Forms.Padding(2);
			this.listItems.MultiSelect = false;
			this.listItems.Name = "listItems";
			this.listItems.OwnerDraw = true;
			this.listItems.Size = new System.Drawing.Size(246, 181);
			this.listItems.SmallImageList = this.imageList;
			this.listItems.TabIndex = 6;
			this.listItems.UseCompatibleStateImageBehavior = false;
			this.listItems.View = System.Windows.Forms.View.Details;
			// 
			// columnHeader1
			// 
			this.columnHeader1.Width = 115;
			// 
			// IntellisenseForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.Silver;
			this.ClientSize = new System.Drawing.Size(246, 181);
			this.ControlBox = false;
			this.Controls.Add(this.listItems);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "IntellisenseForm";
			this.ShowIcon = false;
			this.ShowInTaskbar = false;
			this.ResumeLayout(false);

		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		private int? _ItemHeight = null;
		/// <summary>Высота одного элемента.</summary>
		private int ItemHeight
		{
			get
			{
				if (this._ItemHeight == null)
					this._ItemHeight = this.listItems.GetListViewItemHeight();

				return this._ItemHeight.Value;
			}
		}
		//==================================================================================
		#region WinAPI Constants

		// Отправляется тогда, когда курсор находится в неактивном окне, а пользователь нажимает кнопку мыши
		private const int WM_MOUSEACTIVATE = 0x0021;
		// Не активизирует окно и не сбрасывает сообщение мыши.
		private const int MA_NOACTIVATE = 0x0003;

		// Посылается окну, чей размер, позиция, или место в Z-последовательности
		// собирается измениться в результате обращения к функции SetWindowPos или другой функции управления окна.
		private const int WM_WINDOWPOSCHANGING = 0x0046;

		// Посылается, если пользователь нажимает левую кнопку мыши, в то время, когда курсор находится в рабочей области окна. 
		private const int WM_LBUTTONDOWN = 0x0201;

		#endregion
		//==================================================================================
		protected override void WndProc(ref Message m)
		{
			switch (m.Msg)
			{
				// Окно пытается активироваться
				case WM_MOUSEACTIVATE:
					// Чего мы пытаемся не допустить
					m.Result = (IntPtr)MA_NOACTIVATE;
					return;

				// Окно изменяет размер и/или позицию
				case WM_WINDOWPOSCHANGING:
					// Перехватывать и изменять рывками.
					this.ProcessResizing(m);

					// Отдавать дальше на обработку предку
					base.WndProc(ref m);
					return;

				default:
					base.WndProc(ref m);
					break;
			}
		}
		//==================================================================================
		/// <summary>Осуществляет изменение размеров окна рывками.</summary>
		private void ProcessResizing(Message m)
		{
			WINDOWPOS formPosition = (WINDOWPOS)Marshal.PtrToStructure(m.LParam, typeof(WINDOWPOS));

			int iFormHeight = formPosition.height;
			int iFormWidth = formPosition.width;
			int iFormYPos = formPosition.y;

			int iNewFormHeight = this.GetNewJerkyHeight(iFormHeight);
			int iNewFormYPos = this.GetNewJerkyYPos(iFormYPos, iFormHeight, iNewFormHeight);

			formPosition.height = iNewFormHeight;
			formPosition.y = iNewFormYPos;

			Marshal.StructureToPtr(formPosition, m.LParam, true);

			m.Result = (IntPtr)MA_NOACTIVATE;
		}
		//==================================================================================
		/// <summary>Возвращает новое значение Y-координаты окна при изменении размеров окна за верхнюю рамку.</summary>
		private int GetNewJerkyYPos(int iFormYPos, int iFormHeight, int iNewFormHeight)
		{
			int iNewFormYPos = iFormYPos;

			// Если была попытка изменить размер формы c верхней рамки
			if (iFormHeight != this.Height && iFormYPos != this.Location.Y)
			{
				// Если дельта размера не до росло до изменения размера
				if (iNewFormHeight == this.Height)
					// Держим окно на текущей позиции
					iNewFormYPos = this.Location.Y;
				else
					// Изменяем позицию окна на дельту размера
					iNewFormYPos = this.Location.Y - (iNewFormHeight - this.Height);
			}

			return iNewFormYPos;
		}
		//==================================================================================
		/// <summary>Вычисляет и устанавливает минимальные и максимальные допустимые размеры для формы.</summary>
		private void SetMinMaxSize()
		{
			// Минимальное и максимальное количество строк
			const int iMinLinesCount = 5;
			const int iMaxLinesCount = 20;
			// Отступы клиентской области формы от её рамок с двух сторон.(Применимо к вертикали и горизонтали)
			const int iClientRectMargin = 9 + 9;
			// Соотношение максимальной ширины IntelliSense к ширине разрешения экрана ровняется 75%
			const float fMaxWidthProportion = (float)(3.0 / 4);

			// Вычисление и установка максимального размера
			// 75% ширины экрана
			int iMaxWidth = (int)(SystemInformation.PrimaryMonitorSize.Width * fMaxWidthProportion);
			// Максимальное количество элементов с отступами
			int iMaxHeight = this.ItemHeight * iMaxLinesCount + iClientRectMargin;

			this.MaximumSize = new Size(iMaxWidth, iMaxHeight);

			// Вычисление и установка минимального размера
			// Ширина иконки + VScroll + отступы
			int iMinWidth = SystemInformation.VerticalScrollBarWidth + this.imageList.ImageSize.Width + iClientRectMargin;
			int iMinHeight = this.ItemHeight * iMinLinesCount + iClientRectMargin;

			this.MinimumSize = new Size(iMinWidth, iMinHeight);
		}
		//==================================================================================
		/// <summary>Возвращает новый размер окна учитывая его текущий размер и отступы.</summary>
		private int GetNewJerkyHeight(int formHeight)
		{
			// Отступы клиентской области формы от её размера
			const int iClientRectMargin = 9 + 9;

			// Вычисляем клиентскую область окна и округляем по высоте элемента
			int iClientRectHeight = formHeight - iClientRectMargin;
			iClientRectHeight = iClientRectHeight / this.ItemHeight * this.ItemHeight;

			// Вычисляем относительно клиентской области окна его размеры
			int iNewFormHeight = iClientRectHeight + iClientRectMargin;

			return iNewFormHeight;
		}
		//==================================================================================
		/// <summary>Структура содержащая информацию о окне.</summary>
		[StructLayout(LayoutKind.Sequential)]
		private struct WINDOWPOS
		{
			public IntPtr hwnd;
			public IntPtr hwndInsertAfter;
			public int x;
			public int y;
			public int width;
			public int height;
			public uint flags;
		}
		//==================================================================================
		/// <summary>Выбрать элемент на одну позицию ниже.</summary>
		public void SelectNextItem()
		{
			if (this.CheckForDeselectedItem())
				return;

			this.listItems.SelectItem(listItems.SelectedIndex + 1);
		}
		//==================================================================================
		/// <summary>Выбрать элемент на одну позицию выше.</summary>
		public void SelectPrevItem()
		{
			if (this.CheckForDeselectedItem())
				return;

			this.listItems.SelectItem(listItems.SelectedIndex - 1);
		}
		//==================================================================================
		/// <summary>Выбрать элемент на одну позицию ниже.</summary>
		public void SelectItemNextPage()
		{
			if (this.CheckForDeselectedItem())
				return;

			var visibleItemsCount = this.ClientSize.Height / this.ItemHeight;
			var index = Math.Min(listItems.SelectedIndex + visibleItemsCount, listItems.Items.Count - 1);
			this.listItems.SelectItem(index);
		}
		//==================================================================================
		/// <summary>Выбрать элемент на одну позицию выше.</summary>
		public void SelectItemPrevPage()
		{
			if (this.CheckForDeselectedItem())
				return;

			var visibleItemsCount = this.Height / this.ItemHeight;
			var index = Math.Max(listItems.SelectedIndex - visibleItemsCount, 0);
			this.listItems.SelectItem(index);
		}
		//==================================================================================
		/// <summary>Проверяет равно ли свойство Selected выбранного элемента значению False. Если да, то активирует элемент.</summary>
		private bool CheckForDeselectedItem()
		{
			int iSelectedItem = this.listItems.SelectedIndex;

			if (iSelectedItem >= 0 && iSelectedItem < this.listItems.Items.Count)
				if (this.listItems.Items[iSelectedItem].Selected == false)
				{
					this.listItems.SelectItem(listItems.SelectedIndex);
					return true;
				}

			return false;
		}
		//==================================================================================
		public IntellisenseForm(Control owner)
		{
			this.InitializeComponent();
			this.LinkHandlers();
			this.ControlOwner = owner;
			this.HideList();

			this.SetMinMaxSize();
		}
		//==================================================================================
		void LinkHandlers()
		{
			this.Resize += new System.EventHandler(this.IntellisenseForm_Resize);
			this.ResizeEnd += new System.EventHandler(this.IntellisenseForm_ResizeEnd);
		}
		//==================================================================================
		/// <summary>При ресайзе изменять ширину колонки ListView в соответствии  с размерами формы.</summary>
		private void IntellisenseForm_Resize(object sender, EventArgs e)
		{
			if (this.listItems.Columns.Count > 0)
				this.listItems.Columns[0].Width = this.listItems.Width;
		}
		//==================================================================================
		/// <summary>Возвращаем при ресайзе фокус родительской форме.</summary>
		private void IntellisenseForm_ResizeEnd(object sender, EventArgs e)
		{
			this.ControlOwner.Focus();
		}
		//==================================================================================
		/// <summary>Показать окно Intellisense в точке, включив хук мышки в координатах родительской формы.</summary>
		internal void ShowVariantsAt(Point point)
		{
			this.RelativeLocation = point;
			Point pointAtScreen = this.ControlOwner.PointToScreen(RelativeLocation);

			ShowWindowAtPoint(pointAtScreen);

			Application.AddMessageFilter(Filter);
		}
		//==================================================================================
		/// <summary>Просто показать окно у точки в экранных координатах.</summary>
		void ShowWindowAtPoint(Point pointAtScreen)
		{
			WinAPI.ShowInactiveTopmost(this, pointAtScreen);

			int selectedItem = listItems.SelectedIndex;

			listItems.SelectItem(selectedItem);
		}
		//==================================================================================
		/// <summary>Скрыть окно Intellisense и снять хук мышки.</summary>
		internal void HideList()
		{
			this.Visible = false;
			Application.RemoveMessageFilter(Filter);
			this.InvalidateListView();
		}
		//==================================================================================
		/// <summary>Перерисовать ListView.</summary>
		void InvalidateListView()
		{
			if (listItems == null)
				return;
			if (listItems.Items == null)
				return;

			int itemsCount = listItems.Items.Count;
			if (itemsCount == 0)
				return;

			listItems.RedrawItems(0, itemsCount - 1, true);

			Point oInvalidationZone = new Point(this.Width * -1, this.Height * -1);
			this.ShowWindowAtPoint(oInvalidationZone);
			this.Visible = false;
		}
		//==================================================================================
		/// <summary>При перемещении родительского окна обновляет позицию текущей формы.</summary>
		internal void UpdatePosition(Point ownerForm)
		{
			this.Location = this.ControlOwner.PointToScreen(RelativeLocation);
		}
		//==================================================================================
		/// <summary>Ищет строчку в списке, и, если находит, подсвечивает, иначе снимает выделение.</summary>
		internal void EnsureVisibleForString(string key)
		{
			if (!string.IsNullOrEmpty(key))
			{
				foreach (bool bIgnoreCase in new[] { false, true })
					for (int i = 0; i < listItems.Items.Count; i++)
						if (listItems.Items[i].Text.StartsWith(key, bIgnoreCase, null))
						{
							this.listItems.SelectItem(i);
							return;
						}
			}

			this.listItems.DeselectItem();
		}
		//==================================================================================
		/// <summary>Загружает варианты в ListView.</summary>
		internal void LoadVariants(CompletionVariantList items)
		{
			listItems.Items.Clear();

			if (items == null)
				return;

			foreach (CompletionVariant item in items)
			{
				ListViewItem lvItem = new ListViewItem(item.Text, item.ImageIndex) { ToolTipText = item.Tooltip };
				listItems.Items.Add(lvItem);
			}

			this.listItems.SelectItem(0);
		}
		//==================================================================================
	}
}
