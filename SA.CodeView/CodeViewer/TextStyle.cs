using System;
using System.Drawing;

namespace SA.CodeView
{
	public class TextStyle
	{
		public Color ForeColor;
		public readonly string Name;
		//=========================================================================================
		public TextStyle(string name, Color color, bool bold)
		{
			this.Name = name;
			this.ForeColor = color;
		}
		//=========================================================================================
		public TextStyle(string name, Color color)
			: this(name, color, false) { }
		//=========================================================================================
		public override string ToString()
		{
			return this.Name;
		}
		//=========================================================================================
	}
}
