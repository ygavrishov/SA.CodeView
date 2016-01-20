using System;
using System.Collections.Generic;

namespace SA.CodeView.Parsing
{
	class StateScannerState
	{
		public readonly string Name;
		internal Dictionary<Literal, StateScannerState> Entries;
		internal StateScannerState ElseState;
		internal string ResultTokenName;
		/// <summary>Длина начального ограничителя.</summary>
		internal int StartLimiterLength;
		/// <summary>Длина конечного ограничителя.</summary>
		internal int EndLimiterLength;
		//=========================================================================================
		public StateScannerState(string name)
		{
			this.Entries = new Dictionary<Literal, StateScannerState>();
			this.Name = name;
		}
		//=========================================================================================
		public StateScannerState GetNextState(char nextChar)
		{
			///Сначала проверяем те переходы, для которых указаны конкретные символы
			int iCount = 0;
			foreach (var oEntry in this.Entries)
				if (oEntry.Key.CharTypes == 0)
				{
					if (oEntry.Key.IsValid(nextChar))
						return oEntry.Value;
					iCount++;
				}

			///Если еще остались переходы, то проверяем оставшиеся переходы - для которых указаны типы символов
			if (iCount < this.Entries.Count)
			{
				foreach (var oEntry in this.Entries)
					if (oEntry.Key.CharTypes != 0)
					{
						if (oEntry.Key.IsValid(nextChar))
							return oEntry.Value;
					}
			}

			return this.ElseState;
		}
		//=========================================================================================
		public StateScannerState GetNextState(Literal literal)
		{
			foreach (var oEntry in this.Entries)
			{
				if (string.Compare(oEntry.Key.Name, literal.Name, true) == 0)
					return oEntry.Value;
			}
			return this.ElseState;
		}
		//=========================================================================================
		internal void AddLink(Literal literal, StateScannerState state)
		{
			this.Entries.Add(literal, state);
		}
		//=========================================================================================
		/// <summary>Переход по умолчанию, который выполняется, если не срабатывают условия других переходов.</summary>
		internal void SetDefaultLink(StateScannerState state)
		{
			this.ElseState = state;
		}
		//=========================================================================================
		public override string ToString()
		{
			return this.Name;
		}
		//=========================================================================================
		/// <summary>Получить текстовое описание ожидаемых литералов.</summary>
		internal string GetExpectationToString()
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder("Expected ");
			if (this.Entries.Count == 0)
			{
				if (this.ElseState != null)
					sb.Append(this.ElseState.Name);
				else
					throw new NullReferenceException("Links for " + this.Name);
			}
			bool bFirst = true;
			foreach (var oKey in this.Entries.Keys)
			{
				if (bFirst)
					bFirst = false;
				else
					sb.Append(" or ");
				sb.Append(oKey.Name);
			}
			return sb.ToString();
		}
		//=========================================================================================
	}
}
