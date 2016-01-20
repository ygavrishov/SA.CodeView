using System;
using System.Collections.Generic;

namespace SA.CodeView.Parsing
{
	internal class StateParserState
	{
		public readonly string Name;
		internal Dictionary<string, StateParserState> Entries;
		internal StateParserState ElseState;
		internal string ResultTokenName;
		internal string StyleName;
		string _ExpectationString;
		//=========================================================================================
		public StateParserState(string name)
		{
			this.Entries = new Dictionary<string, StateParserState>();
			this.Name = name;
		}
		//=========================================================================================
		public StateParserState GetNextState(Token token)
		{
			foreach (var oEntry in this.Entries)
			{
				if (string.Compare(oEntry.Key, token.TokenTypeName, true) == 0)
					return oEntry.Value;
			}
			return this.ElseState;
		}
		//=========================================================================================
		internal void AddLink(string tokenType, StateParserState state)
		{
			this.Entries.Add(tokenType, state);
		}
		//=========================================================================================
		/// <summary>Переход по умолчанию, который выполняется, если не срабатывают условия других переходов.</summary>
		internal void SetDefaultLink(StateParserState state)
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
			if (_ExpectationString == null)
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder("Expected ");
				if (this.Entries.Count == 0)
				{
					if (this.ElseState != null)
						sb.AppendFormat("'{0}'", this.ElseState.Name);
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
					sb.AppendFormat("'{0}'", oKey);
				}
				this._ExpectationString = sb.ToString();
			}
			return this._ExpectationString;
		}
		//=========================================================================================
	}
}
