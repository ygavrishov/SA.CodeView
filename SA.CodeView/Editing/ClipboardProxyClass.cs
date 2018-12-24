using System.Windows.Forms;

namespace SA.CodeView.Editing
{
	public interface IClipboard
	{
		bool ContainsText();
		string GetText();
		void SetText(string text);
	}

	/// <summary>Allow access to clipboard.</summary>
	class ClipboardProxyClass : IClipboard
	{
		public static readonly ClipboardProxyClass Self = new ClipboardProxyClass();
		//=========================================================================================
		public bool ContainsText()
		{
			return Clipboard.ContainsText();
		}
		//=========================================================================================
		public string GetText()
		{
			return Clipboard.GetText();
		}
		//=========================================================================================
		public void SetText(string text)
		{
			Clipboard.SetText(text);
		}
		//=========================================================================================
	}
}
