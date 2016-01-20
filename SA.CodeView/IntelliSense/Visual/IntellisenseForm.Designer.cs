namespace SA.CodeView.IntelliSense
{
	partial class IntellisenseForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(IntellisenseForm));
			System.Windows.Forms.ListViewItem listViewItem1 = new System.Windows.Forms.ListViewItem("FROM", 2);
			System.Windows.Forms.ListViewItem listViewItem2 = new System.Windows.Forms.ListViewItem("SELECT", 1);
			System.Windows.Forms.ListViewItem listViewItem3 = new System.Windows.Forms.ListViewItem("WHERE", 0);
			System.Windows.Forms.ListViewItem listViewItem4 = new System.Windows.Forms.ListViewItem("UNION", 3);
			this.imageList = new System.Windows.Forms.ImageList(this.components);
			this.listItems = new SA.CodeView.IntelliSense.IntelliSenseListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.SuspendLayout();
			// 
			// imageList
			// 
			this.imageList.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList.ImageStream")));
			this.imageList.TransparentColor = System.Drawing.Color.Transparent;
			this.imageList.Images.SetKeyName(0, "db.bmp");
			this.imageList.Images.SetKeyName(1, "schema.bmp");
			this.imageList.Images.SetKeyName(2, "table.bmp");
			this.imageList.Images.SetKeyName(3, "column.bmp");
			// 
			// listItems
			// 
			this.listItems.Alignment = System.Windows.Forms.ListViewAlignment.Left;
			this.listItems.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this.listItems.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.listItems.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1});
			this.listItems.FullRowSelect = true;
			this.listItems.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.listItems.HideSelection = false;
			this.listItems.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem1,
            listViewItem2,
            listViewItem3,
            listViewItem4});
			this.listItems.Location = new System.Drawing.Point(0, 0);
			this.listItems.Margin = new System.Windows.Forms.Padding(2);
			this.listItems.MultiSelect = false;
			this.listItems.Name = "listItems";
			this.listItems.OwnerDraw = true;
			this.listItems.Size = new System.Drawing.Size(246, 181);
			this.listItems.SmallImageList = this.imageList;
			this.listItems.TabIndex = 6;
			this.listItems.UseCompatibleStateImageBehavior = false;
			this.listItems.View = System.Windows.Forms.View.Details;
			// 
			// columnHeader1
			// 
			this.columnHeader1.Width = 115;
			// 
			// IntellisenseForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.Silver;
			this.ClientSize = new System.Drawing.Size(246, 181);
			this.ControlBox = false;
			this.Controls.Add(this.listItems);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "IntellisenseForm";
			this.ShowIcon = false;
			this.ShowInTaskbar = false;
			this.Resize += new System.EventHandler(this.IntellisenseForm_Resize);
			this.ResizeEnd += new System.EventHandler(this.IntellisenseForm_ResizeEnd);
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.ImageList imageList;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		internal IntelliSenseListView listItems;

	}
}