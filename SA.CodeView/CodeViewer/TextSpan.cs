using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;

namespace SA.CodeView
{
	/// <summary>Allow to add decoration to some part of text line.</summary>
	public class TextSpan : IComparable<TextSpan>
	{
		public readonly TextPoint Start;
		public readonly TextPoint End;
		public readonly Brush Brush;
		public readonly Pen Pen;
		//=========================================================================================
		public TextSpan(Brush background, Pen border, TextPoint start, TextPoint end)
		{
			this.Start = start;
			this.End = end;
			this.Brush = background;
			this.Pen = border;
		}
		//=========================================================================================
		public int CompareTo(TextSpan other)
		{
			return this.Start.CompareTo(other.Start);
		}
		//=========================================================================================
	}
	//#############################################################################################
	public class TextSpanCollection : IEnumerable
	{
		readonly List<TextSpan> List;
		readonly CodeViewer Viewer;
		//=========================================================================================
		internal TextSpanCollection(CodeViewer viewer)
		{
			this.List = new List<TextSpan>();
			this.Viewer = viewer;
		}
		//=========================================================================================
		public void Add(TextSpan span)
		{
			this.List.Add(span);
			this.List.Sort();
			this.Viewer.Body.Invalidate(false);
		}
		//=========================================================================================
		public void Add(Brush brush, int lineStart, int chrStart, int lineEnd, int chrEnd)
		{
			this.Add(brush, null, lineStart, chrStart, lineEnd, chrEnd);
		}
		//=========================================================================================
		public void Add(Brush brush, Pen pen, int lineStart, int chrStart, int lineEnd, int chrEnd)
		{
			if (lineStart >= this.Viewer.Document.Count || lineEnd >= this.Viewer.Document.Count)
				return;
			int iColStart = this.Viewer.Caret.GetColumn(this.Viewer.Document[lineStart].Text, chrStart);
			int iColEnd = this.Viewer.Caret.GetColumn(this.Viewer.Document[lineEnd].Text, chrEnd);
			TextPoint pStart = new TextPoint(lineStart, iColStart, chrStart);
			TextPoint pEnd = new TextPoint(lineEnd, iColEnd, chrEnd);
			if (lineEnd == lineStart)
			{
				TextSpan oSpan = new TextSpan(brush, pen, pStart, pEnd);
				this.Add(oSpan);
			}
			else
			{
				TextPoint p1, p2;
				string sLine = this.Viewer.Document[lineStart].Text;
				p2 = new TextPoint(lineStart, TextCaret.GetLastCol(sLine, this.Viewer._TabSize), sLine.Length);
				TextSpan oSpan = new TextSpan(brush, pen, pStart, p2);
				this.Add(oSpan);
				for (int iLine = lineStart + 1; iLine < lineEnd; iLine++)
				{
					sLine = this.Viewer.Document[iLine].Text;
					p1 = new TextPoint(iLine, 0, 0);
					p2 = new TextPoint(iLine, TextCaret.GetLastCol(sLine, this.Viewer._TabSize), sLine.Length);
					oSpan = new TextSpan(brush, pen, p1, p2);
					this.Add(oSpan);
				}
				p1 = new TextPoint(lineEnd, 0, 0);
				oSpan = new TextSpan(brush, pen, p1, pEnd);
				this.Add(oSpan);
			}
		}
		//=========================================================================================
		public void Add(Brush brush, int lineStart, int chrStart, int length)
		{
			int iLine = lineStart, iChar = chrStart;
			while (length > 0 && iLine < this.Viewer.Document.Count)
			{
				string sLine = this.Viewer.Document[iLine].Text;
				if (iChar + length < sLine.Length)
				{
					iChar += length;
					length = 0;
				}
				else
				{
					length -= sLine.Length - iChar;
					iChar = 0;
					iLine++;
				}
			}
			if (length > 0)
			{
				iLine = this.Viewer.Document.Count - 1;
				iChar = this.Viewer.Document[iLine].Text.Length;
			}

			this.Add(brush, null, lineStart, chrStart, iLine, iChar);
		}
		//=========================================================================================
		public void AddRange(IEnumerable<TextSpan> spans)
		{
			this.List.AddRange(spans);
			this.List.Sort();
			this.Viewer.Body.Invalidate(false);
		}
		//=========================================================================================
		public void Clear()
		{
			this.List.Clear();
			this.Viewer.Body.Invalidate(false);
		}
		//=========================================================================================
		public TextSpan this[int index]
		{
			get { return this.List[index]; }
		}
		//=========================================================================================
		public int Count { get { return this.List.Count; } }
		//=========================================================================================
		public IEnumerator GetEnumerator()
		{
			return this.List.GetEnumerator();
		}
		//=========================================================================================
	}
}
