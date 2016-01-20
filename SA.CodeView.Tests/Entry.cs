using System;
using System.Windows.Forms;
using Tests.TestForms;

namespace Tests
{
	class Entry
	{
		//=========================================================================================
		[STAThread]
		public static void Main()
		{
			Application.EnableVisualStyles();
			Application.Run(new StartForm());
		}
		//=========================================================================================
	}
}
