using System;
using System.Collections.Generic;

namespace SA.CodeView.Parsing
{
	/// <summary>Определяет конечный автомат для работы парсера.</summary>
	class ParserSpecification
	{
		public readonly List<StateParserState> States;
		/// <summary>Стартовое состояние любого разбора.</summary>
		public readonly StateParserState StartState;
		/// <summary>Конечное состояние любого разбора.</summary>
		public readonly StateParserState EndState;
		public readonly StateParserState FailState;
		//=========================================================================================
		public ParserSpecification()
		{
			this.States = new List<StateParserState>();
			this.StartState = new StateParserState("<start>");
			this.EndState = new StateParserState("<end>");
			this.FailState = new StateParserState("<fail>");
			this.States.Add(this.StartState);
			this.States.Add(this.EndState);
			this.States.Add(this.FailState);

			this.StartState.SetDefaultLink(this.FailState);
			this.FailState.SetDefaultLink(this.EndState);
		}
		//=========================================================================================
		/// <summary>Добавить правило разбора.</summary>
		internal void AddRule(string name, string definition)
		{
			var oScanner = new SA.CodeView.Parsing.RuleDefParsing.Scanner(definition, string.Empty);
			var oParser = new SA.CodeView.Parsing.RuleDefParsing.Parser(oScanner);

			int iStartStatesCount = this.States.Count;

			oParser.Spec = this;
			oParser.Parse();

			///Для всех состояний, у которых не определено ни одного перехода, определяем его на EndState.
			for (int iState = iStartStatesCount; iState < this.States.Count; iState++)
			{
				var oState = this.States[iState];
				if (oState.Entries.Count == 0 && oState.ElseState == null)
					oState.SetDefaultLink(this.EndState);
				oState.ResultTokenName = name;
			}

			if (oParser.Errors.Count != 0)
				throw new ArgumentException(oParser.Errors[0].Msg);
		}
		//=========================================================================================
	}
}
