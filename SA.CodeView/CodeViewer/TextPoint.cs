using System;
using System.Collections.Generic;

namespace SA.CodeView
{
	/// <summary>Position in a document</summary>
	public struct TextPoint : IComparable
	{
		public int Line;
		/// <summary>Position in line.</summary>
		public int Col;
		/// <summary>Char number in line (may be differ from Col when there are tabs).</summary>
		public int Char;
		//=========================================================================================
		public TextPoint(int line, int col, int chr)
		{
			this.Line = line;
			this.Col = col;
			this.Char = chr;
		}
		//=========================================================================================
		public void SetPos(int line, int col, int chr)
		{
			this.Line = line;
			this.Col = col;
			this.Char = chr;
		}
		//=========================================================================================
		public override string ToString()
		{
			return string.Format("Ln:{0}, col:{1}, ch:{2}", this.Line, this.Col, this.Char);
		}
		//=========================================================================================
		#region Comparison operators
		//=========================================================================================
		public int CompareTo(object obj)
		{
			TextPoint oObj = (TextPoint)obj;
			int iRes = this.Line.CompareTo(oObj.Line);
			if (iRes != 0)
				return iRes;
			return this.Col.CompareTo(oObj.Col);
		}
		//=========================================================================================
		public static bool operator >(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) > 0;
		}
		//=========================================================================================
		public static bool operator <(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) < 0;
		}
		//=========================================================================================
		public static bool operator >=(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) >= 0;
		}
		//=========================================================================================
		public static bool operator <=(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) <= 0;
		}
        //=========================================================================================
        public static bool operator ==(TextPoint first, TextPoint second)
        {
            return first.CompareTo(second) == 0;
        }
        //=========================================================================================
        public static bool operator !=(TextPoint first, TextPoint second)
        {
            return first.CompareTo(second) != 0;
        }
		//=========================================================================================
		public static TextPoint Min(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) <= 0 ? first : second;
		}
		//=========================================================================================
		public static TextPoint Max(TextPoint first, TextPoint second)
		{
			return first.CompareTo(second) >= 0 ? first : second;
		}
		//=========================================================================================
		#endregion
		//=========================================================================================
		public override int GetHashCode()
		{
			return base.GetHashCode();
		}
		//=========================================================================================
		public override bool Equals(object obj)
		{
			TextPoint second = (TextPoint)obj;
			return
				this.Line == second.Line &&
				this.Char == second.Char;
		}
		//=========================================================================================
	}
}
