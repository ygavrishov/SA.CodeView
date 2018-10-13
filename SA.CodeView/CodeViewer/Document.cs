using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.Utils;

namespace SA.CodeView
{
	public class Document : IEnumerable
	{
		readonly List<DocumentLine> Lines;
		//=========================================================================================
		public int Count
		{
			get
			{
				if (this.Lines == null)
					return 0;

				return this.Lines.Count;
			}
		}
		//=========================================================================================
		public Document()
		{
			this.Lines = new List<DocumentLine>();
			this.Lines.Add(new DocumentLine(""));
		}
		//=========================================================================================
		internal void SetText(string text)
		{
			this.Lines.Clear();
			foreach (string sLine in TextSplitter.GetLinesFromText(text))
				this.Lines.Add(new DocumentLine(sLine));
		}
		//=========================================================================================
		public DocumentLine this[int index]
		{
			get { return this.Lines[index]; }
		}
		//=========================================================================================
		internal void Insert(int index, string text)
		{
			this.Lines.Insert(index, new DocumentLine(text));
		}
		//=========================================================================================
		internal void RemoveAt(int index)
		{
			this.Lines.RemoveAt(index);
		}
		//=========================================================================================
		internal void RemoveRange(int index, int count)
		{
			this.Lines.RemoveRange(index, count);
		}
		//=========================================================================================
		internal void InsertRange(int index, List<string> lines)
		{
			foreach (string sLine in lines)
				this.Lines.Insert(index++, new DocumentLine(sLine));
		}
		//=========================================================================================
		public IEnumerator GetEnumerator()
		{
			return this.Lines.GetEnumerator();
		}
		//=========================================================================================
		internal string GetText(TextPoint start, TextPoint end)
		{
			if (start > end)
			{
				TextPoint temp = start;
				start = end;
				end = temp;
			}
			if (start.Line == end.Line)
				return this.Lines[start.Line].Text.Substring(start.Char, end.Char - start.Char);
			else
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();

				string sLine = this.Lines[start.Line].Text;
				sb.AppendLine(sLine.Substring(start.Char, sLine.Length - start.Char));

				for (int i = start.Line + 1; i < end.Line; i++)
					sb.AppendLine(this.Lines[i].Text);

				sb.AppendLine(this.Lines[end.Line].Text.Substring(0, end.Char));

				return sb.ToString();
			}
		}
		//=========================================================================================
	}
	//#############################################################################################
	/// <summary>Specifies extra properties for text line in document.</summary>
	public class DocumentLine : IDisposable
	{
		public string Text;
		public Brush BackBrush;
		//=========================================================================================
		int _ImageIndex;
		public int ImageIndex
		{
			get { return _ImageIndex; }
			set { this._ImageIndex = value; }
		}
		//=========================================================================================
		internal DocumentLine(string text)
		{
			this.Text = text;
			this._ImageIndex = -1;
		}
		//=========================================================================================
		public void Dispose()
		{
			if (this.BackBrush == null)
				return;

			this.BackBrush.Dispose();
		}
		//=========================================================================================
	}
}
