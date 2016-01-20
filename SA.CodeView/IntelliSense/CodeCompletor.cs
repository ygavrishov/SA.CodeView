using System;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using SA.CodeView.Parsing;

namespace SA.CodeView.IntelliSense
{
	/// <summary>Позволяет автоматически завершать набранный текст.</summary>
	class CodeCompletor
	{
		CodeViewer Viewer;
		IntellisenseForm _FormWithList;
		private TextPoint TokenStart;
		public SuggestionBuilder Builder;
		//=========================================================================================
		/// <summary>Объект формы Intellisense</summary>
		IntellisenseForm FormWithList
		{
			get
			{
				if (this._FormWithList == null)
				{
					this._FormWithList = new IntellisenseForm(this.Viewer);
					this._FormWithList.listItems.ApplyVariantEvent += (sender, e) => this.ApplyCurrentVariant();
				}
				return _FormWithList;
			}
		}
		//=========================================================================================
		/// <summary>Отображен ли список вариантов.</summary>
		internal virtual bool IsVariantsVisible
		{
			get { return this.FormWithList.Visible; }
		}
		//=========================================================================================
		/// <summary>Связывает класс с CodeViewer'ом устанавливая требуемые связи.</summary>
		public void LinkWithViewer(CodeViewer viewer)
		{
			this.Viewer = viewer;
			this.Viewer.CodeCompletor = this;

			if (this.Viewer.ParentForm != null)
			{
				this.Viewer.ParentForm.Move += new EventHandler(ParentForm_Move);
				this.Viewer.ParentForm.Deactivate += new EventHandler(ParentForm_Deactivate);
			}
		}
		//=========================================================================================
		/// <summary>Выполняет действия для требуемых клавиш. Возвращает true если клавиша поглащена.</summary>
		public bool ProcessKey(KeyEventArgs e)
		{
			switch (e.KeyCode)
			{
				case Keys.Up:
					if (this.IsVariantsVisible)
					{
						this.FormWithList.SelectPrevItem();
						return true;
					}
					return false;
				case Keys.Down:
					if (this.IsVariantsVisible)
					{
						this.FormWithList.SelectNextItem();
						return true;
					}
					return false;
				case Keys.Right:
				case Keys.Left:
				case Keys.End:
				case Keys.Home:
				case Keys.PageDown:
					if (this.IsVariantsVisible)
					{
						this.FormWithList.SelectItemNextPage();
						return true;
					}
					return false;
				case Keys.PageUp:
					if (this.IsVariantsVisible)
					{
						this.FormWithList.SelectItemPrevPage();
						return true;
					}
					return false;
				case Keys.Escape:
					this.HideVariants();
					return true;
				case Keys.Enter:
					if (this.IsVariantsVisible)
					{
						this.ApplyCurrentVariant();
						return true;
					}
					break;
				default:
					break;
			}
			return false;
		}
		//=========================================================================================
		/// <summary>Проверяет стоит ли пропустить нажатие клавиши.</summary>
		public bool PreProcessChar(char c)
		{
			switch (c)
			{
				case ' ':
					if (this.IsVariantsVisible)
					{
						this.ApplyCurrentVariant();
						return false;
					}
					else if (Control.ModifierKeys == Keys.Control)
					{
						this.AutoComplete();
						return true;
					}
					break;
				case '\t':
					if (this.IsVariantsVisible)
					{
						this.ApplyCurrentVariant();
						return true;
					}
					break;
				default:
					if (Char.IsPunctuation(c))
						if (this.IsVariantsVisible)
							this.ApplyCurrentVariant();
					if (!char.IsLetterOrDigit(c) && c != '_' &&
						!char.IsControl(c) &&
						this.IsVariantsVisible
						)
					{
						this.ApplyCurrentVariant();
						this.HideVariants();
					}
					return false;
			}
			return false;
		}
		//=========================================================================================
		/// <summary>Отображает список всех вариантов.</summary>
		void ShowVariants(TextPoint tokenStart, Point point, CompletionVariantList items)
		{
			if (items == null || items.Count == 0)
			{
				if (this.IsVariantsVisible)
					this.HideVariants();
				return;
			}

			this.TokenStart = tokenStart;

			this.FormWithList.LoadVariants(items);
			this.ShowVariants(point);
		}
		//=========================================================================================
		/// <summary>Скрывает список вариантов подстановки.</summary>
		internal virtual void HideVariants()
		{
			this.FormWithList.HideList();
		}
		//=========================================================================================
		internal virtual void ShowVariants(Point point)
		{
			this.FormWithList.ShowVariantsAt(point);
		}
		//=========================================================================================
		/// <summary>Получает и отображает список всех вариантов.</summary>
		public void PostProcessChar(char c)
		{
			if (IsNeedToShowVariants(c))
			{
				TextPoint point;
				Point pointAtCodeViewer;
				this.DetermineBestWindowPosition(out point, out pointAtCodeViewer);

				var items = this.Builder.GetVariants();

				this.ShowVariants(point, pointAtCodeViewer, items);
			}
			// Если отображается, подсветить нужную строку.
			if (!this.IsVariantsVisible)
				return;

			int iTokenIndex = this.Viewer.Caret.TokenIndex;

			if (iTokenIndex < 0 || iTokenIndex >= this.Viewer.Tokens.Count)
				return;
			string sVariant;
			if (this.Viewer.Caret.RegardingToken == CaretLocationType.BetweenWords)
				sVariant = string.Empty;
			else
				sVariant = this.Viewer.Tokens[iTokenIndex].Text;
			this.SelectAppopriateVariant(sVariant);

			// Проверить не ушла ли каретка дальше точки начала.
			if (this.Viewer.Caret.Point < this.TokenStart)
				this.HideVariants();
		}
		//=========================================================================================
		/// <summary>Подставляет вариант, скрывает окно и обновляет Viewer.</summary>
		void ApplyCurrentVariant()
		{
			int iVariant = this.FormWithList.listItems.SelectedIndex;
			this.ApplyVariant(iVariant);
			this.HideVariants();
			this.Viewer.Body.Invalidate(false);
		}
		//=========================================================================================
		/// <summary>EventHandler при деактивации родительской формы CodeViewer'а.</summary>
		void ParentForm_Deactivate(object sender, EventArgs e)
		{
			Form parentForm = (Form)sender;

			if (parentForm.WindowState == FormWindowState.Minimized)
				HideVariants();

			IntPtr hWndActiveWindow = WinAPI.GetForegroundWindow();

			bool isIntellisenseFormActive = hWndActiveWindow != this.FormWithList.Handle;
			bool isParentFormActive = hWndActiveWindow != this.Viewer.ParentForm.Handle;

			if (isIntellisenseFormActive && isParentFormActive)
				HideVariants();
		}
		//=========================================================================================
		/// <summary>EventHandler для перемещения родительской формы CodeViewer'а.</summary>
		void ParentForm_Move(object sender, EventArgs e)
		{
			Form parentForm = (Form)sender;
			FormWithList.UpdatePosition(parentForm.Location);
		}
		//=========================================================================================
		/// <summary>Подставляет указанный вариант в редактор.</summary>
		void ApplyVariant(int variantNumber)
		{
			if (Viewer == null)
				return;

			int itemsCount = this.FormWithList.listItems.Items.Count;
			if (variantNumber < 0 || variantNumber >= itemsCount)
				return;

			if (!this.FormWithList.listItems.Items[variantNumber].Selected)
				return;

			string choose = this.FormWithList.listItems.Items[variantNumber].Text;
			int iTokenIndex = this.Viewer.Caret.TokenIndex;
			Token oToken;
			switch (this.Viewer.Caret.RegardingToken)
			{
				case CaretLocationType.WordCenter:
				case CaretLocationType.WordEnd:
					oToken = this.Viewer.Tokens[iTokenIndex];
					break;
				default:
					oToken = null;
					break;
			}

			this.PasteInsteadOfCurrentToken(oToken, choose);
		}
		//=========================================================================================
		/// <summary>Подставляет указанную строку в редактор заместо текущего токена.</summary>
		void PasteInsteadOfCurrentToken(Token token, string choose)
		{
			//Пользователь ввел начало слова
			if (token != null && token.Text != "." && token.Text != ",")
			{
				int iCurrentLineId = this.Viewer.Caret.Line;
				string sCurrentLine = this.Viewer.Document[iCurrentLineId].Text;
				string sNewLine = String.Empty;

				StringBuilder builder = new StringBuilder();

				builder.Append(sCurrentLine, 0, token.Start.Char);
				builder.Append(choose);
				int sourceIndex = token.End.Char;
				int count = sCurrentLine.Length - sourceIndex;
				builder.Append(sCurrentLine, token.End.Char, count);

				this.Viewer.Document[iCurrentLineId].Text = builder.ToString();

				int iNewCaretCol = token.End.Col - token.Text.Length + choose.Length;

				this.Viewer.Caret.MoveToPos(iCurrentLineId, iNewCaretCol, true);

				this.Viewer.InitTokens(this.Viewer.Text);
				this.Viewer.Invalidate();
				return;
			}

			//Если текст ещё не подставлен и стоят пробелы не являющиеся токенами
			this.Viewer.PasteText(choose);
			this.Viewer.Invalidate();
		}
		//=========================================================================================
		/// <summary>Пытается автоматически завершить введёную строку, иначе показать варианты</summary>
		public void AutoComplete()
		{
			TextPoint tokenStart;
			Point pointAtCodeViewer;
			this.DetermineBestWindowPosition(out tokenStart, out pointAtCodeViewer);

			int iTokenIndex = this.Viewer.Caret.TokenIndex;
			if (iTokenIndex < 0)
				return;
			Token oToken = this.Viewer.Tokens[iTokenIndex];

			var items = this.Builder.GetVariants();

			if (items == null)
				return;

			int? itemIndex = null;
			if (oToken != null)
				itemIndex = this.FindAloneItemByKey(items, oToken.Text);

			if (itemIndex != null)
			{
				this.PasteInsteadOfCurrentToken(oToken, items[itemIndex.Value].Text);
				return;
			}
			this.ShowVariants(tokenStart, pointAtCodeViewer, items);
		}
		//=========================================================================================
		/// <summary>Ищет единственный элемент по заданной строке. Если их 0 или больше 1, возвращает null.</summary>
		int? FindAloneItemByKey(CompletionVariantList items, string key)
		{
			// Количество элементов с вхождением заданной строки
			int iFoundCount = 0;
			// Индекс последнего совпавшего элемента
			int iItemId = 0;

			for (int i = 0; i < items.Count; i++)
				if (items[i].Text.StartsWith(key, true, null))
				{
					iFoundCount++;
					iItemId = i;
				}

			if (iFoundCount != 1)
				return null;

			return iItemId;
		}
		//=========================================================================================
		/// <summary>Определеет позицию окна на экране.</summary>
		void DetermineBestWindowPosition(out TextPoint tokenStart, out Point pointAtCodeViewer)
		{
			int iTokenIndex = this.Viewer.Caret.TokenIndex;
			if (iTokenIndex >= 0 && this.Viewer.Caret.RegardingToken != CaretLocationType.BetweenWords)
			{
				Token oToken = this.Viewer.Tokens[iTokenIndex];

				if (oToken.TokenTypeName == "id")
					tokenStart = oToken.Start;
				else
					tokenStart = oToken.End;
				pointAtCodeViewer = this.Viewer.Body.GetXYByTextPoint(tokenStart);
				pointAtCodeViewer.Y += this.Viewer.CharHeight;
			}
			else
			{
				pointAtCodeViewer = this.Viewer.GetCaretLocation();
				pointAtCodeViewer.Y += this.Viewer.CharHeight;
				tokenStart = this.Viewer.Caret.Point;
			}
		}
		//=========================================================================================
		/// <summary>Подсвечивает строку с заданной строкой если имеется.</summary>
		void SelectAppopriateVariant(string key)
		{
			this.FormWithList.EnsureVisibleForString(key);
		}
		//=========================================================================================
		/// <summary>Нужно ли показывать список вариантов.</summary>
		bool IsNeedToShowVariants(char c)
		{
			// Если ввод не пробел или точка или запятая - не нужно
			if (c != ' ' && c != '.' && c != ',')
				return false;

			string sCurrentLine = this.Viewer.Document[this.Viewer.Caret.Line].Text;
			int iChar = this.Viewer.Caret.Char;
			int iLine = this.Viewer.Caret.Line;

			// Если мы в начале строки - не нужно
			if (iChar == 0)
				return false;

			//Если мы не в начале строки
			if (iChar <= sCurrentLine.Length)
			{
				char cPrev = sCurrentLine[iChar - 1];
				if (cPrev == ' ' ||
					cPrev == '.' ||
					cPrev == ',')// Если предыдущий символ Space или Dot или Common
					return true;
			}

			return false;
		}
		//=========================================================================================
	}
}