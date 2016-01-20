using System.Drawing;
using System.Windows.Forms;

namespace SA.CodeView.IntelliSense
{
	class IntellisenseMessageFilter : IMessageFilter
	{
		#region WinAPI Constants

		private const int WM_MOUSEWHEEL = 0x020A;

		private const int WM_LBUTTONDOWN = 0x0201;

		#endregion
		//============================================================================================
		/// <summary>Хранит объект формы</summary>
		private readonly IntellisenseForm IntelForm;
		//============================================================================================
		public IntellisenseMessageFilter(IntellisenseForm form)
		{
			this.IntelForm = form;
		}
		//============================================================================================
		/// <summary>Интерфейсный метод обработки сообщений</summary>
		public bool PreFilterMessage(ref Message m)
		{
			if (m.Msg == WM_LBUTTONDOWN)
			{
				return ProcessLButtonDown(m);
			}

			if (m.Msg == WM_MOUSEWHEEL)
			{
				return ProcessMouseWheel(m);
			}

			return false;
		}
		//============================================================================================
		/// <summary>Обрабатывает сообщения вращения колесика мышки</summary>
		private bool ProcessMouseWheel(Message m)
		{
			int wheelDelta = WinAPI.GetWheelDelta_WParam(m.WParam);

			Point point = WinAPI.GetPointFromLParam(m.LParam);

			this.IntelForm.listItems.ScrollListView(wheelDelta);

			return true;
		}
		//============================================================================================
		/// <summary>Обрабатывает нажатия левой кнопки мыши</summary>
		private bool ProcessLButtonDown(Message m)
		{
			Point point = WinAPI.GetPointFromLParam(m.LParam);

			bool isIntelFormHandle		= m.HWnd != this.IntelForm.Handle;
			bool isIntelListViewHandle	= m.HWnd != this.IntelForm.listItems.Handle;

			if (isIntelFormHandle && isIntelListViewHandle)
				this.IntelForm.HideList();

			return false;
		}
		//============================================================================================
	}
}
