using System.Collections.Generic;
using System.Collections;
using System;

namespace SA.CodeView.IntelliSense
{
	//#############################################################################################
	public enum DataBaseLevel
	{
		Schema = 1,
		Table = 2,
		Columns = 3
	}
	//#############################################################################################
	/// <summary>Элемент списка вариантов для автоподстановки.</summary>
	public class CompletionVariant : IComparable<CompletionVariant>
	{
		public int ImageIndex;
		public string Tooltip;
		public string Text;
		//=========================================================================================
		public override string ToString()
		{
			string sText = string.Format("{0} ({1})", this.Text, this.ImageIndex);
			if (!string.IsNullOrEmpty(this.Tooltip))
				sText += string.Format(" ({0})", this.Tooltip);
			return sText;
		}
		//=========================================================================================
		public int CompareTo(CompletionVariant other)
		{
			int iResult = this.ImageIndex.CompareTo(other.ImageIndex);
			if (iResult != 0)
				return iResult;
			return this.Text.CompareTo(other.Text);
		}
		//=========================================================================================
		public override int GetHashCode()
		{
			return this.Text.GetHashCode() + this.ImageIndex;
		}
		//=========================================================================================
		public override bool Equals(object obj)
		{
			if (obj == null)
				return false;
			return this.GetHashCode().Equals(obj.GetHashCode());
		}
		//=========================================================================================
	}
	//#############################################################################################
	public class CompletionVariantList : IEnumerable<CompletionVariant>
	{
		readonly List<CompletionVariant> Items;
		//=========================================================================================
		public static CompletionVariantList Combine(CompletionVariantList list, List<string> names, DataBaseLevel type)
		{
			if (names == null || names.Count == 0)
				return list;
			if (list == null)
				list = new CompletionVariantList();
			list.AddRange(names, type);
			return list;
		}
		//=========================================================================================
		public static CompletionVariantList Combine(CompletionVariantList list, string name, DataBaseLevel type)
		{
			if (string.IsNullOrEmpty(name))
				return list;
			if (list == null)
				list = new CompletionVariantList();
			list.Add(name, type);
			return list;
		}
		//=========================================================================================
		public int Count { get { return this.Items.Count; } }
		//=========================================================================================
		public CompletionVariant this[int index]
		{
			get { return this.Items[index]; }
		}
		//=========================================================================================
		CompletionVariantList()
		{
			this.Items = new List<CompletionVariant>();
		}
		//=========================================================================================
		public IEnumerator<CompletionVariant> GetEnumerator()
		{
			return this.Items.GetEnumerator();
		}
		//=========================================================================================
		IEnumerator IEnumerable.GetEnumerator()
		{
			return this.Items.GetEnumerator();
		}
		//=========================================================================================
		public void Add(string name, DataBaseLevel type)
		{
			CompletionVariant item = new CompletionVariant() { Text = name, ImageIndex = (int)type };
			this.Add(item);
		}
		//=========================================================================================
		private void Add(CompletionVariant item)
		{
			foreach (var oItem in this.Items)
				if (item.CompareTo(oItem) == 0)
					return;
			this.Items.Add(item);
		}
		//=========================================================================================
		public void AddRange(List<string> names, DataBaseLevel type)
		{
			if (names == null)
				return;
			foreach (string sName in names)
				this.Add(sName, type);
		}
		//=========================================================================================
		public void AddRange(CompletionVariantList variants)
		{
			foreach (var oItem in variants)
				this.Add(oItem.Text, (DataBaseLevel)oItem.ImageIndex);
		}
		//=========================================================================================
		public override string ToString()
		{
			return string.Format("Count = {0}", this.Items.Count);
		}
		//=========================================================================================
	}
	//#############################################################################################
}
