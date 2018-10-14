using System.Windows.Forms;

namespace SA.CodeView.Editing
{
	/// <summary>Allow access to clipboard.</summary>
	public class ClipboardProxyClass
	{
		public static readonly ClipboardProxyClass Self = new ClipboardProxyClass();
		//=========================================================================================
		public virtual bool ContainsText()
		{
			return Clipboard.ContainsText();
		}
		//=========================================================================================
		public virtual string GetText()
		{
			return Clipboard.GetText();
		}
		//=========================================================================================
		public virtual void SetText(string text)
		{
			Clipboard.SetText(text);
		}
		//=========================================================================================
	}
}
