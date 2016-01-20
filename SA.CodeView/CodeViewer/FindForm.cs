using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace SA.CodeView
{
	public class FindForm : Form
	{
		private Label labelFind;
		private ComboBox comboFind;
		private GroupBox gbSearch;
		private CheckBox checkMatchWholeWord;
		private CheckBox checkMatchCase;
		private Button buttonFindNext;
		private Button buttonClose;
		//=========================================================================================
		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.labelFind = new System.Windows.Forms.Label();
			this.comboFind = new System.Windows.Forms.ComboBox();
			this.gbSearch = new System.Windows.Forms.GroupBox();
			this.checkMatchWholeWord = new System.Windows.Forms.CheckBox();
			this.checkMatchCase = new System.Windows.Forms.CheckBox();
			this.buttonFindNext = new System.Windows.Forms.Button();
			this.buttonClose = new System.Windows.Forms.Button();
			this.gbSearch.SuspendLayout();
			this.SuspendLayout();
			// 
			// labelFind
			// 
			this.labelFind.AutoSize = true;
			this.labelFind.Location = new System.Drawing.Point(12, 18);
			this.labelFind.Name = "labelFind";
			this.labelFind.Size = new System.Drawing.Size(56, 13);
			this.labelFind.TabIndex = 0;
			this.labelFind.Text = "Find what:";
			// 
			// comboFind
			// 
			this.comboFind.FormattingEnabled = true;
			this.comboFind.Location = new System.Drawing.Point(74, 15);
			this.comboFind.Name = "comboFind";
			this.comboFind.Size = new System.Drawing.Size(256, 21);
			this.comboFind.TabIndex = 1;
			// 
			// gbSearch
			// 
			this.gbSearch.Controls.Add(this.checkMatchWholeWord);
			this.gbSearch.Controls.Add(this.checkMatchCase);
			this.gbSearch.Location = new System.Drawing.Point(15, 51);
			this.gbSearch.Name = "gbSearch";
			this.gbSearch.Size = new System.Drawing.Size(315, 63);
			this.gbSearch.TabIndex = 2;
			this.gbSearch.TabStop = false;
			this.gbSearch.Text = "Search";
			// 
			// checkMatchWholeWord
			// 
			this.checkMatchWholeWord.AutoSize = true;
			this.checkMatchWholeWord.Location = new System.Drawing.Point(6, 42);
			this.checkMatchWholeWord.Name = "checkMatchWholeWord";
			this.checkMatchWholeWord.Size = new System.Drawing.Size(113, 17);
			this.checkMatchWholeWord.TabIndex = 1;
			this.checkMatchWholeWord.Text = "Match whole word";
			this.checkMatchWholeWord.UseVisualStyleBackColor = true;
			// 
			// checkMatchCase
			// 
			this.checkMatchCase.AutoSize = true;
			this.checkMatchCase.Location = new System.Drawing.Point(6, 19);
			this.checkMatchCase.Name = "checkMatchCase";
			this.checkMatchCase.Size = new System.Drawing.Size(82, 17);
			this.checkMatchCase.TabIndex = 0;
			this.checkMatchCase.Text = "Match case";
			this.checkMatchCase.UseVisualStyleBackColor = true;
			// 
			// buttonFindNext
			// 
			this.buttonFindNext.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.buttonFindNext.Location = new System.Drawing.Point(360, 13);
			this.buttonFindNext.Name = "buttonFindNext";
			this.buttonFindNext.Size = new System.Drawing.Size(75, 23);
			this.buttonFindNext.TabIndex = 3;
			this.buttonFindNext.Text = "Find Next";
			this.buttonFindNext.UseVisualStyleBackColor = true;
			// 
			// buttonClose
			// 
			this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.buttonClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.buttonClose.Location = new System.Drawing.Point(360, 89);
			this.buttonClose.Name = "buttonClose";
			this.buttonClose.Size = new System.Drawing.Size(75, 23);
			this.buttonClose.TabIndex = 4;
			this.buttonClose.Text = "Close";
			this.buttonClose.UseVisualStyleBackColor = true;
			// 
			// FindForm
			// 
			this.AcceptButton = this.buttonFindNext;
			this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
			this.CancelButton = this.buttonClose;
			this.ClientSize = new System.Drawing.Size(460, 125);
			this.Controls.Add(this.buttonClose);
			this.Controls.Add(this.buttonFindNext);
			this.Controls.Add(this.gbSearch);
			this.Controls.Add(this.comboFind);
			this.Controls.Add(this.labelFind);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "FindForm";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Find";
			this.gbSearch.ResumeLayout(false);
			this.gbSearch.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion
		//=========================================================================================
		TextFinder Finder;
		List<string> ListSearch;
		//=========================================================================================
		public FindForm()
		{
			InitializeComponent();
			LinkHandlers();
		}
		//=========================================================================================
		private void LinkHandlers()
		{
			this.buttonFindNext.Click += new EventHandler(buttonFindNext_Click);
			this.buttonClose.Click += new EventHandler(buttonClose_Click);
			this.KeyDown += new KeyEventHandler(FindForm_KeyDown);
			this.FormClosing += new FormClosingEventHandler(FindForm_FormClosing);
		}
		//=========================================================================================
		public void Init(TextFinder finder, List<string> listSearch)
		{
			this.Finder = finder;
			this.ListSearch = listSearch;
			
			if (this.ListSearch == null || this.ListSearch.Count == 0)
				return;

			this.comboFind.Items.AddRange(listSearch.ToArray());
			this.comboFind.SelectedIndex = 0;
		}
		//=========================================================================================
		void buttonFindNext_Click(object sender, EventArgs e)
		{
			if (!this.PrepareSearch())
				return;

			this.Finder.FindNext(this.comboFind.Text, this.checkMatchCase.Checked, this.checkMatchWholeWord.Checked);
		}
		//=========================================================================================
		void buttonClose_Click(object sender, EventArgs e)
		{
			this.Close();
		}
		//=========================================================================================
		void FindForm_KeyDown(object sender, KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Escape)
				this.Close();
		}
		//=========================================================================================
		void FindForm_FormClosing(object sender, FormClosingEventArgs e)
		{
			if (this.ListSearch == null || this.comboFind.Items.Count == 0)
				return;

			this.ListSearch.Clear();
			foreach (string sItem in this.comboFind.Items)
				this.ListSearch.Add(sItem);
		}
		//=========================================================================================
		bool PrepareSearch()
		{
			if (this.Finder == null)
				return false;

			if (string.IsNullOrEmpty(comboFind.Text))
				return false;

			//Is there specified text in combobox items
			int iSelectedIndex = -1;
			for (int i = 0; i < this.comboFind.Items.Count; i++)
				if (string.Compare((string)this.comboFind.Items[i], this.comboFind.Text, false) == 0)
				{
					iSelectedIndex = i;
					break;
				}

			if (iSelectedIndex == -1)
				//add specified text to the list
				this.comboFind.Items.Insert(0, this.comboFind.Text);
			else if (iSelectedIndex > 0)
			{
				//make the text first in the list
				string sText = this.comboFind.Text;
				this.comboFind.Items.RemoveAt(iSelectedIndex);
				this.comboFind.Items.Insert(0, sText);
				this.comboFind.SelectedIndex = 0;
			}

			return true;
		}
		//=========================================================================================
	}
}
