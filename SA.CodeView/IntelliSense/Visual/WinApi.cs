using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace SA.CodeView.IntelliSense
{
	public class WinAPI
	{
		/// <summary>Отправляет оконное сообщение указанному окну со специфическими параметрами</summary>
		[DllImport("user32.dll", CharSet = CharSet.Auto)]
		static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, int wParam, int lParam);
		[DllImport("User32.dll")]
		public static extern int SendMessage(IntPtr hWnd, int uMsg, IntPtr wParam, IntPtr lParam);
		//=========================================================================================
		[DllImport("kernel32.dll", CharSet = CharSet.Auto)]
		public static extern uint RegisterApplicationRestart(string pszCommandline, int dwFlags);
		//=========================================================================================
		private const int SW_SHOWNOACTIVATE = 4;
		private const int HWND_TOPMOST = -1;
		private const uint SWP_NOACTIVATE = 0x0010;

		[DllImport("user32.dll", EntryPoint = "SetWindowPos")]
		static extern bool SetWindowPos(
			 IntPtr hWnd,           // window handle
			 IntPtr hWndInsertAfter,    // placement-order handle
			 int X,          // horizontal position
			 int Y,          // vertical position
			 int cx,         // width
			 int cy,         // height
			 uint uFlags);       // window positioning flags

		[DllImport("user32.dll")]
		static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
		//=========================================================================================
		public static void ShowInactiveTopmost(Form frm, int x, int y)
		{
			SetWindowPos(frm.Handle, (IntPtr)HWND_TOPMOST,
			x, y, frm.Width, frm.Height,
			SWP_NOACTIVATE);
			
			ShowWindow(frm.Handle, SW_SHOWNOACTIVATE);
		}

		public static void ShowInactiveTopmost(Form frm, Point pt)
		{
			ShowInactiveTopmost(frm, pt.X, pt.Y);
		}
		//==========================================================================================
		/// <summary>Подгрузка WinAPI функций отвечающих за получение и установку стиля
		/// окна для 32/64 версий</summary>
		[DllImport("user32.dll", EntryPoint = "GetWindowLong", CharSet = CharSet.Auto)]
		public static extern IntPtr GetWindowLong32(IntPtr hWnd, int nIndex);

		[DllImport("user32.dll", EntryPoint = "GetWindowLongPtr", CharSet = CharSet.Auto)]
		public static extern IntPtr GetWindowLongPtr64(IntPtr hWnd, int nIndex);

		[DllImport("user32.dll", EntryPoint = "SetWindowLong", CharSet = CharSet.Auto)]
		public static extern IntPtr SetWindowLongPtr32(IntPtr hWnd, int nIndex, int dwNewLong);

		[DllImport("user32.dll", EntryPoint = "SetWindowLongPtr", CharSet = CharSet.Auto)]
		public static extern IntPtr SetWindowLongPtr64(IntPtr hWnd, int nIndex, int dwNewLong);
		//==========================================================================================
		/// <summary>Возвращает различную информацию об указанном окне учитывая разрядность ОС</summary>
		public static int GetWindowLong(IntPtr hWnd, int nIndex)
		{
			if (IntPtr.Size == 4)
				return (int)GetWindowLong32(hWnd, nIndex);
			else
				return (int)(long)GetWindowLongPtr64(hWnd, nIndex);
		}
		//==========================================================================================
		/// <summary>Устанавливает различную информацию указанному окну учитывая разрядность ОС</summary>
		public static int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong)
		{
			if (IntPtr.Size == 4)
				return (int)SetWindowLongPtr32(hWnd, nIndex, dwNewLong);
			else
				return (int)(long)SetWindowLongPtr64(hWnd, nIndex, dwNewLong);
		}
		//==========================================================================================
		/// <summary>Возвращает WORD как нижнюю, правую часть DWORD</summary>
		private static int GetX_LParam(IntPtr iNumber)
		{
			return iNumber.ToInt32() & 0x0000FFFF;
		}
		//==========================================================================================
		/// <summary>Возвращает WORD как верхнюю, левую часть DWORD</summary>
		private static int GetY_LParam(IntPtr iNumber)
		{
			return iNumber.ToInt32() >> 16;
		}
		//==========================================================================================
		/// <summary>Возвращает Point как координаты мыши полученные из lParam</summary>
		public static Point GetPointFromLParam(IntPtr lParam)
		{
			return new Point(GetX_LParam(lParam), GetY_LParam(lParam));
		}
		//==========================================================================================
		/// <summary>Возвращает величину вращения колеса мыши
		public static int GetWheelDelta_WParam(IntPtr wParam) {
			return (wParam.ToInt32() >> 16) / 120;
		}
		//==========================================================================================
		/// <summary>Возвращает текущее активное окно</summary>
		[DllImport("user32.dll")]
		public static extern IntPtr GetForegroundWindow();
	}
}