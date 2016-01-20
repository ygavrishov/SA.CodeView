using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using SA.CodeView;
using SA.CodeView.IntelliSense;
using Tests.IntelliSense.BLL;

namespace Tests.TestForms
{
	class StartForm : Form
	{
		readonly CodeViewer[] Viewers;
		//=========================================================================================
		#region Form controls
		private readonly System.ComponentModel.IContainer components = null;
		private CodeViewer codeViewer2;
		private System.Windows.Forms.CheckBox checkLineNumbers;
		private System.Windows.Forms.CheckBox checkMargin;
		private CodeViewer codeViewer1;
		private TextBox textTabSize;
		private Button buttonApplyTabSize;
		private Button buttonChangeBackColor;
		private System.Windows.Forms.SplitContainer splitContainer1;
		#endregion
		//=========================================================================================
		#region Windows Form Designer generated code
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
				components.Dispose();
			base.Dispose(disposing);
		}
		private void InitializeComponent()
		{
			this.checkLineNumbers = new System.Windows.Forms.CheckBox();
			this.checkMargin = new System.Windows.Forms.CheckBox();
			this.splitContainer1 = new System.Windows.Forms.SplitContainer();
			this.codeViewer1 = new SA.CodeView.CodeViewer();
			this.codeViewer2 = new SA.CodeView.CodeViewer();
			this.textTabSize = new System.Windows.Forms.TextBox();
			this.buttonApplyTabSize = new System.Windows.Forms.Button();
			this.buttonChangeBackColor = new System.Windows.Forms.Button();
			this.splitContainer1.Panel1.SuspendLayout();
			this.splitContainer1.Panel2.SuspendLayout();
			this.splitContainer1.SuspendLayout();
			this.SuspendLayout();
			// 
			// checkLineNumbers
			// 
			this.checkLineNumbers.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.checkLineNumbers.AutoSize = true;
			this.checkLineNumbers.Location = new System.Drawing.Point(731, 12);
			this.checkLineNumbers.Name = "checkLineNumbers";
			this.checkLineNumbers.Size = new System.Drawing.Size(119, 17);
			this.checkLineNumbers.TabIndex = 4;
			this.checkLineNumbers.Text = "Show Line Numbers";
			this.checkLineNumbers.UseVisualStyleBackColor = true;
			// 
			// checkMargin
			// 
			this.checkMargin.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.checkMargin.AutoSize = true;
			this.checkMargin.Location = new System.Drawing.Point(731, 35);
			this.checkMargin.Name = "checkMargin";
			this.checkMargin.Size = new System.Drawing.Size(109, 17);
			this.checkMargin.TabIndex = 5;
			this.checkMargin.Text = "Show Left Margin";
			this.checkMargin.UseVisualStyleBackColor = true;
			// 
			// splitContainer1
			// 
			this.splitContainer1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.splitContainer1.Location = new System.Drawing.Point(12, 12);
			this.splitContainer1.Name = "splitContainer1";
			// 
			// splitContainer1.Panel1
			// 
			this.splitContainer1.Panel1.Controls.Add(this.codeViewer1);
			// 
			// splitContainer1.Panel2
			// 
			this.splitContainer1.Panel2.Controls.Add(this.codeViewer2);
			this.splitContainer1.Size = new System.Drawing.Size(703, 457);
			this.splitContainer1.SplitterDistance = 351;
			this.splitContainer1.SplitterWidth = 5;
			this.splitContainer1.TabIndex = 0;
			// 
			// codeViewer1
			// 
			this.codeViewer1.BackColor = System.Drawing.SystemColors.Control;
			this.codeViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.codeViewer1.Language = SA.CodeView.PredefinedLanguage.MsSql;
			this.codeViewer1.Location = new System.Drawing.Point(0, 0);
			this.codeViewer1.Margin = new System.Windows.Forms.Padding(4);
			this.codeViewer1.Name = "codeViewer1";
			this.codeViewer1.Padding = new System.Windows.Forms.Padding(1);
			this.codeViewer1.ReadOnly = false;
			this.codeViewer1.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.codeViewer1.ShowLineNumbers = true;
			this.codeViewer1.Size = new System.Drawing.Size(351, 457);
			this.codeViewer1.TabIndex = 6;
			// 
			// codeViewer2
			// 
			this.codeViewer2.BackColor = System.Drawing.SystemColors.Window;
			this.codeViewer2.Dock = System.Windows.Forms.DockStyle.Fill;
			this.codeViewer2.Language = SA.CodeView.PredefinedLanguage.MsSql;
			this.codeViewer2.Location = new System.Drawing.Point(0, 0);
			this.codeViewer2.Margin = new System.Windows.Forms.Padding(4);
			this.codeViewer2.Name = "codeViewer2";
			this.codeViewer2.Padding = new System.Windows.Forms.Padding(1);
			this.codeViewer2.ReadOnly = false;
			this.codeViewer2.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.codeViewer2.ShowLineNumbers = true;
			this.codeViewer2.Size = new System.Drawing.Size(347, 457);
			this.codeViewer2.TabIndex = 0;
			// 
			// textTabSize
			// 
			this.textTabSize.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.textTabSize.Location = new System.Drawing.Point(731, 58);
			this.textTabSize.Name = "textTabSize";
			this.textTabSize.Size = new System.Drawing.Size(45, 21);
			this.textTabSize.TabIndex = 10;
			this.textTabSize.Text = "4";
			// 
			// buttonApplyTabSize
			// 
			this.buttonApplyTabSize.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.buttonApplyTabSize.Location = new System.Drawing.Point(782, 56);
			this.buttonApplyTabSize.Name = "buttonApplyTabSize";
			this.buttonApplyTabSize.Size = new System.Drawing.Size(87, 23);
			this.buttonApplyTabSize.TabIndex = 11;
			this.buttonApplyTabSize.Text = "Apply Tab Size";
			this.buttonApplyTabSize.UseVisualStyleBackColor = true;
			this.buttonApplyTabSize.Click += new System.EventHandler(this.buttonApplyTabSize_Click);
			// 
			// buttonChangeBackColor
			// 
			this.buttonChangeBackColor.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.buttonChangeBackColor.Location = new System.Drawing.Point(731, 85);
			this.buttonChangeBackColor.Name = "buttonChangeBackColor";
			this.buttonChangeBackColor.Size = new System.Drawing.Size(140, 23);
			this.buttonChangeBackColor.TabIndex = 13;
			this.buttonChangeBackColor.Text = "Change Back Color";
			this.buttonChangeBackColor.UseVisualStyleBackColor = true;
			this.buttonChangeBackColor.Click += new System.EventHandler(this.buttonChangeBackColor_Click);
			// 
			// StartForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
			this.ClientSize = new System.Drawing.Size(881, 518);
			this.Controls.Add(this.buttonChangeBackColor);
			this.Controls.Add(this.buttonApplyTabSize);
			this.Controls.Add(this.textTabSize);
			this.Controls.Add(this.splitContainer1);
			this.Controls.Add(this.checkMargin);
			this.Controls.Add(this.checkLineNumbers);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			this.Name = "StartForm";
			this.ShowIcon = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "CodeViewer Demo";
			this.splitContainer1.Panel1.ResumeLayout(false);
			this.splitContainer1.Panel2.ResumeLayout(false);
			this.splitContainer1.ResumeLayout(false);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion
		//=========================================================================================
		public StartForm()
		{
			this.InitializeComponent();
			this.Viewers = new CodeViewer[] { this.codeViewer1, this.codeViewer2 };
			this.checkLineNumbers.CheckedChanged += new System.EventHandler(checkLineNumbers_CheckedChanged);
			this.checkMargin.CheckedChanged += new System.EventHandler(checkMargin_CheckedChanged);

			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.ScrollBars = ScrollBars.Both;
				oViewer.VerticalScroll.ValueChanged += new System.EventHandler(VerticalScroll_ValueChanged);
			}
			this.checkLineNumbers.Checked = true;
			this.Test_Small_MsSql();

			SuggestionBuilder oSugBuilder = new EditQueryRegExBuilder(codeViewer1, new TestDbInfoProvider());
			((EditQueryRegExBuilder)oSugBuilder).DefaultSchema = "Schema_Second";

			codeViewer1.UseSuggestionRules(oSugBuilder);
		}
		//=========================================================================================
		void VerticalScroll_ValueChanged(object sender, EventArgs e)
		{
			ScrollBar oScrollBar = (ScrollBar)sender, oScrollBar2;
			if (oScrollBar == this.Viewers[0].VerticalScroll)
				oScrollBar2 = this.Viewers[1].VerticalScroll;
			else
				oScrollBar2 = this.Viewers[0].VerticalScroll;
			oScrollBar2.Value = oScrollBar.Value;
		}
		//=========================================================================================
		void checkLineNumbers_CheckedChanged(object sender, EventArgs e)
		{
			foreach (CodeViewer oViewer in this.Viewers)
				oViewer.ShowLineNumbers = ((CheckBox)sender).Checked;
		}
		//=========================================================================================
		void checkMargin_CheckedChanged(object sender, EventArgs e)
		{
			foreach (CodeViewer oViewer in this.Viewers)
				oViewer.ShowMargin = ((CheckBox)sender).Checked;
		}
		//=========================================================================================
		void Test_MySql()
		{
			#region Text
			const string sText = @"delimiter $$

CREATE TABLE `adv_media_X` (
  `adv_id` bigint(20) unsigned NOT NULL auto_increment,
  `adv_url` varchar(255) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `descr` text NOT NULL,
  `duration` tinyint(3) unsigned NOT NULL default '0',
  `media` enum('jpg','swf','flv') NOT NULL default 'flv',
  `views` bigint(20) NOT NULL default '0',
  `clicks` bigint(20) NOT NULL default '0',
  `addtime` int(10) NOT NULL default '0',
  `status` enum('1','0') NOT NULL default '0',
  PRIMARY KEY  (`adv_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8$$
";
			#endregion
			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.Language = PredefinedLanguage.MySql;
				oViewer.Text = sText;
				oViewer.ReadOnly = false;
				oViewer.AcceptsTab = true;
			}
		}
		//=========================================================================================
		void Test_Small_MsSql()
		{
			string sText = "Create table [T 1](--xxxxxxx\r\n x int,\r\n y1  int\r\n)";
			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.Text = sText;
				oViewer.ReadOnly = false;
				oViewer.AcceptsTab = true;
			}
		}
		//=========================================================================================
		void Test_Xml()
		{
			string sPath = Path.GetDirectoryName(Application.ExecutablePath) + "\\..\\..\\SampleData\\";
			sPath = Path.Combine(sPath, "SampleXml.xml");
			string sText;
			using (StreamReader oReader = new StreamReader(sPath))
				sText = oReader.ReadToEnd();
			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.Language = PredefinedLanguage.Xml;
				oViewer.Text = sText;
			}
		}
		//=========================================================================================
		void Test_1Mb_MsSql()
		{
			string sPath = Path.GetDirectoryName(Application.ExecutablePath) + "\\..\\..\\SampleData\\";
			sPath = Path.Combine(sPath, "MsSql_1Mb.sql");
			string sText;
			using (StreamReader oReader = new StreamReader(sPath))
				sText = oReader.ReadToEnd();
			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.Language = PredefinedLanguage.MsSql;
				oViewer.Text = sText;
			}
		}
		//=========================================================================================
		void ActivateSpans()
		{
			foreach (CodeViewer oViewer in this.Viewers)
			{
				oViewer.Spans.Add(Brushes.LightGreen, 4, 0, 7);
				oViewer.Spans.Add(Brushes.LightGreen, 0, 12, 2);
				oViewer.Spans.Add(Brushes.LightGreen, 0, 2, 2);
				oViewer.Spans.Add(Brushes.LightGreen, 10, 6, 7);
				oViewer.Document[4].BackBrush = Brushes.Lavender;
			}
		}
		//=========================================================================================
		private void buttonApplyTabSize_Click(object sender, EventArgs e)
		{
			int iTabSize;
			if (!int.TryParse(this.textTabSize.Text, out iTabSize))
				return;
			foreach (var oViewer in this.Viewers)
				oViewer.TabSize = iTabSize;
		}
		//=========================================================================================
		private void buttonChangeBackColor_Click(object sender, EventArgs e)
		{
			Random rand = new Random();
			this.codeViewer1.BackColor = Color.FromArgb(rand.Next(255), rand.Next(255), rand.Next(255));
		}
		//=========================================================================================
	}
}
