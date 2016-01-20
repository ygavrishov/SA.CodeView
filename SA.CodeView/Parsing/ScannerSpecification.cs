using System;
using System.Collections.Generic;

namespace SA.CodeView.Parsing
{

	/// <summary>Описывает, как и на какие токены сканер должен разбивать входной поток.</summary>
	class ScannerSpecification
	{
		/// <summary>Описания всех токенов.</summary>
		public readonly List<Literal> Literals;
		//=========================================================================================
		/// <summary>Список всех состояний в графе разбора.</summary>
		public readonly List<StateScannerState> States;
		/// <summary>Стартовое состояние любого разбора.</summary>
		public readonly StateScannerState StartState;
		/// <summary>Конечное состояние любого разбора.</summary>
		public readonly StateScannerState EndState;
		public readonly StateScannerState FailState;
		//=========================================================================================
		public ScannerSpecification()
		{
			this.Literals = new List<Literal>();
			this.States = new List<StateScannerState>();
			this.StartState = new StateScannerState("<start>");
			this.EndState = new StateScannerState("<end>");
			this.FailState = new StateScannerState("<fail>");
			this.States.Add(this.StartState);
			this.States.Add(this.EndState);
			this.States.Add(this.FailState);

			this.StartState.SetDefaultLink(this.FailState);
			this.FailState.SetDefaultLink(this.EndState);
		}
		//=========================================================================================
		public void AddTokenDeclaration(string name, string declaration)
		{
			var oScanner = new SA.CodeView.Parsing.TokenDefParsing.Scanner(declaration, string.Empty);
			var oParser = new SA.CodeView.Parsing.TokenDefParsing.Parser(oScanner);

			int iStartStatesCount = this.States.Count;

			oParser.Spec = this;
			oParser.Parse();

			///Для всех состояний, у которых не определено ни одного перехода, определяем его на EndState.
			for (int iState = iStartStatesCount; iState < this.States.Count; iState++)
			{
				var oState = this.States[iState];
				if (oState.ElseState == null)
				{
					if (oState.Entries.Count == 0)
						oState.SetDefaultLink(this.EndState);
					//else
					//    oState.SetDefaultLink(this.FailState);
				}
				oState.ResultTokenName = name;
			}

			if (oParser.Errors.Count != 0)
				throw new ArgumentException(oParser.Errors[0].Msg);
		}
		//=========================================================================================
		internal void AddBoundedToken(string name, string start, string end, string escape)
		{
			this.AddBoundedToken(name, start, end, escape, 0, 0);
		}
		//=========================================================================================
		internal void AddBoundedToken(string name, string start, string end, string escape, int startlen, int endlen)
		{
			///Находим начальные и конечные литералы
			Literal[] startLiterals = GetLiteralsFromString(start);
			Literal[] endLiterals = GetLiteralsFromString(end);

			///Состояние, в котором будут приняты все символы между ограничителями
			StateScannerState oReccurentState;
			///Создаем состояния для обработки входных ограничителей
			{
				StateScannerState oCurrentState = this.StartState;
				for (int i = 0; i < startLiterals.Length; i++)
				{
					string sStateName = string.Format("<{0}_start_{1}>", name, i);
					var oNewState = this.CreateOrGetState(oCurrentState, startLiterals[i], sStateName, name);
					if (oNewState.ElseState == null)
						oNewState.SetDefaultLink(this.FailState);
					oCurrentState = oNewState;
				}
				oReccurentState = oCurrentState;
			}

			///Будем находиться в этом состоянии, пока не придет конечный ограничитель
			oReccurentState.SetDefaultLink(oReccurentState);

			///Выходное состояние
			StateScannerState oEndState;
			///Создаем состояния для обработки выходных ограничителей
			{
				///Состояние, на которое нужно перейти в случае, если прерывается цепочка конечных ограничителей,
				///но вместе с тем поступил первый ограничитель из этой цепочки.
				StateScannerState oFirstEndState = null;
				///Номер такого состояния
				int iFirstEndState = 0;
				for (int i = 1; i < endLiterals.Length; i++)
				{
					if (endLiterals[i] == endLiterals[0])
						iFirstEndState = i;
					else
						break;
				}
				StateScannerState oCurrentState = oReccurentState;
				for (int i = 0; i < endLiterals.Length; i++)
				{
					string sStateName = string.Format("<{0}_end_{1}>", name, i);
					var oNewState = this.CreateOrGetState(oCurrentState, endLiterals[i], sStateName, name);
					if (i == iFirstEndState)
						if (string.IsNullOrEmpty(escape))
							oFirstEndState = oNewState;
					if (oFirstEndState != null)
						oNewState.AddLink(endLiterals[0], oFirstEndState);
					oNewState.SetDefaultLink(oReccurentState);
					oCurrentState = oNewState;
				}
				oEndState = oCurrentState;
			}
			oEndState.SetDefaultLink(this.EndState);
			oEndState.StartLimiterLength = startlen;
			oEndState.EndLimiterLength = endlen;

			var oEscapeLiteral = this.GetLiteralByName(escape);
			if (oEscapeLiteral != null)
			{
				StateScannerState oNextState = oReccurentState.GetNextState(oEscapeLiteral);
				if (oNextState == null || oNextState == oReccurentState.ElseState)
				{
					string sStateName = string.Format("<{0}_escape>", name);
					var oNewState = this.CreateOrGetState(oReccurentState, oEscapeLiteral, sStateName, name);
					oNewState.SetDefaultLink(oReccurentState);
				}
				else
				{
					oNextState.AddLink(startLiterals[0], oReccurentState);
				}
			}
		}
		//=========================================================================================
		/// <summary>Создать новое состояние или взять уже существующее, в которое мы переходим из указанного при получении на входе указанного символа.</summary>
		StateScannerState CreateOrGetState(StateScannerState from, Literal incoming, string stateName, string tokenName)
		{
			StateScannerState oState;
			if (from.Entries.TryGetValue(incoming, out oState))
			{
				if (oState == this.EndState)
				{
					string sMsg = string.Format("Ambiguous link {0}->{1}: {2} or {3}.",
						from.Name, incoming.Name, from.ResultTokenName, tokenName);
					throw new ArgumentException(sMsg);
				}
				return oState;
			}

			StateScannerState oNewState = new StateScannerState(stateName);
			from.AddLink(incoming, oNewState);
			this.States.Add(oNewState);
			oNewState.ResultTokenName = tokenName;
			return oNewState;
		}
		//=========================================================================================
		Literal[] GetLiteralsFromString(string definition)
		{
			string[] textLiterals = definition.Split();
			Literal[] literals = new Literal[textLiterals.Length];
			for (int i = 0; i < textLiterals.Length; i++)
			{
				var oLiteral = this.GetLiteralByName(textLiterals[i]);
				if (oLiteral == null)
					throw new NullReferenceException(textLiterals[i]);
				literals[i] = oLiteral;
			}
			return literals;
		}
		//=========================================================================================
		#region AddCharDefinitions
		public void AddLiteral(string name, CharType charTypes, params char[] chars)
		{
			this.Literals.Add(new Literal(name, charTypes, chars));
		}
		//=========================================================================================
		public void AddLiteral(string name, params char[] chars)
		{
			this.Literals.Add(new Literal(name, chars));
		}
		#endregion
		//=========================================================================================
		/// <summary>Найти описание литерала по его имени.</summary>
		internal Literal GetLiteralByName(string name)
		{
			if (name != null)
			{
				name = name.Trim();
				foreach (var oItem in this.Literals)
					if (string.Compare(oItem.Name, name, true) == 0)
						return oItem;
			}
			return null;
		}
		//=========================================================================================
		internal string PrintGraph()
		{
			var sb = new System.Text.StringBuilder();
			foreach (var oState in this.States)
			{
				sb.AppendFormat("{0}:\r\n", oState.Name);
				foreach (var oEntry in oState.Entries)
				{
					string sLiteral = oEntry.Key.Name.PadLeft(10);
					sb.AppendFormat("{0}\t->\t{1}\r\n", sLiteral, oEntry.Value.Name);
				}
				string sDefaultState;
				if (oState.ElseState == null)
					sDefaultState = string.Empty;
				else
					sDefaultState = oState.ElseState.Name;
				string sDefaultLink = string.Empty.PadRight(10);
				sb.AppendFormat("{0}\t->\t{1}\r\n", sDefaultLink, sDefaultState);
			}
			return sb.ToString();
		}
		//=========================================================================================
	}
}
