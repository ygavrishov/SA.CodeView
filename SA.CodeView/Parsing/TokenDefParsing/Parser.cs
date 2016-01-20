
using System;
using System.Collections;
using System.Collections.Generic;

namespace SA.CodeView.Parsing.TokenDefParsing {



partial class Parser
{
    	public const int _EOF = 0;
	public const int _ident = 1;
	public const int maxT = 9;

    const bool T = true;
    const bool x = false;
    const int minErrDist = 2;

    public Scanner scanner;
    public ErrorCollection Errors;

    public Token t;    // last recognized token
    public Token la;   // lookahead token
    int errDist = minErrDist;



    public Parser(Scanner scanner)
    {
        this.scanner = scanner;
		this.Errors = new ErrorCollection(scanner.FileName);
    }

    void SynErr(int n)
    {
        if (errDist >= minErrDist)
			this.Errors.SynErr(la.line, la.col, n);
        errDist = 0;
    }

    public void SemErr(string msg)
    {
        if (errDist >= minErrDist)
			this.Errors.SemErr(t.line, t.col, msg);
        errDist = 0;
    }
    
    void Get()
    {
        for (; ; )
        {
            t = la;
            la = scanner.Scan();
            if (la.kind <= maxT) { ++errDist; break; }

            la = t;
        }
    }

    void Expect(int n)
    {
        if (la.kind == n) Get(); else { SynErr(n); }
    }

    bool StartOf(int s)
    {
        return set[s, la.kind];
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
    void ExpectWeak(int n, int follow)
    {
        if (la.kind == n) Get();
        else
        {
            SynErr(n);
            while (!StartOf(follow)) Get();
        }
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
    bool WeakSeparator(int n, int syFol, int repFol)
    {
        int kind = la.kind;
        if (kind == n) { Get(); return true; }
        else if (StartOf(repFol)) { return false; }
        else
        {
            SynErr(n);
            while (!(set[syFol, kind] || set[repFol, kind] || set[0, kind]))
            {
                Get();
                kind = la.kind;
            }
            return StartOf(syFol);
        }
    }


	void TokenDeclarations() {
		List<StateScannerState> oNewStates;
		List<StateScannerState> listStartStates = new List<StateScannerState>{this.Spec.StartState};
		List<StateScannerState> listEndStates = new List<StateScannerState>{this.Spec.EndState};
		
		Expression(out oNewStates, listStartStates, listEndStates);
		if (oNewStates != null)
		foreach (var oState in oNewStates)
			oState.SetDefaultLink(this.Spec.EndState);
		
	}

	void Expression(out List<StateScannerState> newStates, List<StateScannerState> startStates, List<StateScannerState> endStates ) {
		Alternative(out newStates, startStates, endStates);
		while (la.kind == 2) {
			List<StateScannerState> newAltStates;
			
			Get();
			Alternative(out newAltStates, startStates, endStates);
			if (newStates == null || newStates.Count == 0)
			newStates = newAltStates;
			else if (newAltStates != null && newAltStates.Count > 0)
				newStates.AddRange(newAltStates);
			
		}
	}

	void Alternative(out List<StateScannerState> newStates, List<StateScannerState> startStates, List<StateScannerState> endStates ) {
		Symbol(out newStates, startStates, endStates);
		while (StartOf(1)) {
			Symbol(out newStates, newStates, endStates);
		}
	}

	void Symbol(out List<StateScannerState> newStates, List<StateScannerState> startStates, List<StateScannerState> endStates ) {
		newStates = null;
		
		if (la.kind == 1) {
			Get();
			var oTokenSpec = this.Spec.GetLiteralByName(t.val);
			if (oTokenSpec == null)
			{
				this.SemErr(t.val);
				return;
			}
			
					StateScannerState oNextState = null;
					foreach (var oStartState in startStates)
					{
						if (oStartState.Entries.TryGetValue(oTokenSpec, out oNextState))
							break;
					}
					if (oNextState == null)
					{
						string sStateName = "<" + (this.Spec.States.Count - 2).ToString() + ">";
						oNextState = new StateScannerState(sStateName);
						this.Spec.States.Add(oNextState);
					}
					foreach (var oStartState in startStates)
						if (!oStartState.Entries.ContainsKey(oTokenSpec))
						{
							oStartState.AddLink(oTokenSpec, oNextState);
							oStartState.SetDefaultLink(this.Spec.FailState);
						}
					newStates = new List<StateScannerState> { oNextState };
				
		} else if (la.kind == 3) {
			Get();
			Expression(out newStates, startStates, endStates);
			Expect(4);
		} else if (la.kind == 5) {
			Get();
			Expression(out newStates, startStates, endStates);
			Expect(6);
			if (newStates != null)
			newStates.AddRange(startStates);
			
		} else if (la.kind == 7) {
			Get();
			Expression(out newStates, startStates, endStates);
			Expect(8);
			if (newStates != null && startStates != null)
			{
				///startStates в данном случае - это элементы перед началом необязательная части, которая может повторяться многократно.
				///Надо организовать цикл повторяющейся части, а для этого нам нужен переход на ее начало.
				///Значит для всех конечных состояний (newStates) мы делаем переходы по таким же условиям, что и для startStates.
				foreach (var oStartState in startStates)
					foreach (var oEntry in oStartState.Entries)
						foreach (var oNewState in newStates)
							if (!oNewState.Entries.ContainsKey(oEntry.Key))
								oNewState.AddLink(oEntry.Key, oEntry.Value);
				///Поскольку мы имеем дело с необязательно конструкцией, которая может быть, а может и не быть,
				///то входные состояния дальше мы будем обрабатывать так же как и выходные.
						newStates.AddRange(startStates);
					}
				
		} else SynErr(10);
	}



    void _Parse()
    {
        la = new Token();
        la.val = "";
        Get();
		TokenDeclarations();


//>>>>>[mb]>>>>>>>
//ïðèøëîñü óáðàòü, òàê êàê áûëè ïðîáëåìû ñ CREATE TRIGGER, ðåøèëè îáðàáàòûâàòü 
//ïî îäíîé êîíñòðóêöèè èç ïðàâèë, âíåøíèé êëàññ 
//(òåêóùåå èìÿ - SqlAccessories.ScriptAnalyze.Create.Analyzer, ìåòîä - FillDataBase())
//÷òîáû ïàðñåð íå ðóãàëñÿ íà íàëè÷èå êàêèõ-òî ñëîâ âìåñòî êîíöà ôàéëà
//        Expect(0);
//<<<<<<<<<<<<<<<<
        scanner.RollBack();
    }

    bool[,] set = {
		{T,x,x,x, x,x,x,x, x,x,x},
		{x,T,x,T, x,T,x,T, x,x,x}

};
} // end Parser


/// <summary>êëàññ îïèñûâàþùèé îøèáêó</summary>
public class ErrorDescription
{
    /// <summary>òèï îøèáêè</summary>
    public enum ErrorType
    {
        /// <summary>ñèíòàêñè÷åñêàÿ</summary>
        Syntax,
        /// <summary>ñåìàíòè÷åñêàÿ</summary>
        Semantic,
        /// <summary>ïðåäóïðåæäåíèå</summary>
        Warning,
    }
    /// <summary>èìÿ ôàéëà, â êîòîðîì îáíàðóæåíà îøèáêà</summary>
    public string File;
    /// <summary>ñîîáùåíèå îá îøèáêå</summary>
    public string Msg;
    /// <summary>òèï îøèáêè</summary>
    public ErrorType Type;
    ///<summary>òèï îøèáêè â âèäå ñòðîêè</summary>
    public string StringType
    {
		get
		{
			switch(Type)
			{
				case ErrorType.Syntax:
					return "Syntax";
				case ErrorType.Semantic:
					return "Semantic";
				case ErrorType.Warning:
					return "Warning";
				default:
					return "Indefinite error type.";
			}
		}
    }
    /// <summary>ñòðîêà, â êîòîðîé îøèáêà</summary>
    public int Row;
    /// <summary>ñèìâîë îò íà÷àëà ñòðîêè</summary>
    public int Col;
    //=======================================================================================================
    public ErrorDescription()
    {
    }
    //=======================================================================================================
    public ErrorDescription(string file, string msg, ErrorType type, int row, int col)
    {
        File = file;
        Msg = msg;
        Type = type;
        Row = row;
        Col = col;
    }
}


public class ErrorCollection : IEnumerable
{
    public static string errMsgFormat = "Line {0}, col {1}: {2}"; // 0=line, 1=column, 2=text
    List<ErrorDescription> Errors = new List<ErrorDescription>();
	public int NoWarningCount = 0;						//number of errors, not include warnings
	public int WarningCount = 0;						//number of warnings
    string _file;
	
	public int Count
	{
		get
		{
			if (this.Errors == null)
				return 0;
			else
				return this.Errors.Count;
		}
	}
	public IEnumerator GetEnumerator()
	{
		return this.Errors.GetEnumerator();
	}
	public ErrorDescription this[int index]
	{
		get	{	return this.Errors[index];	}
	}
	
    public ErrorCollection(string file)
    {
        _file = file;
    }

    public void SynErr(int line, int col, int n)
    {
        string s;
        switch (n)
        {
			case 0: s = "EOF expected"; break;
			case 1: s = "ident expected"; break;
			case 2: s = "\"|\" expected"; break;
			case 3: s = "\"(\" expected"; break;
			case 4: s = "\")\" expected"; break;
			case 5: s = "\"[\" expected"; break;
			case 6: s = "\"]\" expected"; break;
			case 7: s = "\"{\" expected"; break;
			case 8: s = "\"}\" expected"; break;
			case 9: s = "??? expected"; break;
			case 10: s = "invalid Symbol"; break;

            default: s = "error " + n; break;
        }

        this.Errors.Add(new ErrorDescription(
            _file,
            string.Format(errMsgFormat, line, col, s),
            ErrorDescription.ErrorType.Syntax,
            line,
            col));

        NoWarningCount++;
    }

    public void SemErr(int line, int col, string s)
    {
        this.Errors.Add(new ErrorDescription(
            _file,
            string.Format(errMsgFormat, line, col, s),
            ErrorDescription.ErrorType.Semantic,
            line,
            col));
        NoWarningCount++;
    }
}

public class AnalyzingException : Exception
{
    public AnalyzingException(string m) : base(m) { }
}
}