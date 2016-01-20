using System;
using System.Collections.Generic;
using System.Text;
using SA.CodeView.ParsingOnElements;
using System.Drawing;
using SA.CodeView.Parsing;

namespace SA.CodeView.Languages
{
	class VisualBasicSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public VisualBasicSyntaxSettings()
		{
			this.Operators = new char[] { '=', '+', '-', '/', '*', '%', '>', '<', '&', '|', '^', '~', '(', ')', '[', ']', ',' };
		}
		//=========================================================================================
		protected override List<SA.CodeView.ParsingOnElements.BaseElement> CreateElements()
		{
			var elements = new List<BaseElement>();
			return elements;
		}
		//=========================================================================================
		protected override Dictionary<string, TextStyle> CreateTextStyles()
		{
			var styles = base.CreateTextStyles();
			this.AddStyle(styles, new TextStyle(S_OPERATORS, Color.Black));
			this.AddStyle(styles, new TextStyle(S_STRINGS, Color.Maroon));
			this.AddStyle(styles, new TextStyle(S_MULTI_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_SINGLE_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_IDENTIFIER, Color.Black));
			this.AddStyle(styles, new TextStyle(S_NUMBERS, Color.Black));
			this.AddStyle(styles, new TextStyle(S_KEYWORDS_1, Color.Blue, true));
			return styles;
		}
		//=========================================================================================
		internal override ScannerSpecification CreateScannerSpecification()
		{
			var oSpec = new ScannerSpecification();
			oSpec.AddLiteral("l", CharType.Letters, '_');
			oSpec.AddLiteral("d", CharType.Numbers);
			oSpec.AddLiteral("minus", '-');
			oSpec.AddLiteral("asterisk", '*');
			oSpec.AddLiteral("slash", '/');
			oSpec.AddLiteral("backSlash", '\\');
			oSpec.AddLiteral("operators", '=', '>', '<', ';', ',', '.', '+', ')', '(', '|', '&');
			oSpec.AddLiteral("singleQuote", '\'');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("caretReturn", '\n');

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("operator", "(operators|minus)");
			oSpec.AddBoundedToken("charConst", "singleQuote", "singleQuote", "backSlash");
			oSpec.AddBoundedToken("comment1", "slash asterisk", "asterisk slash", null);
			oSpec.AddBoundedToken("comment2", "slash slash", "caretReturn", null);
			oSpec.AddBoundedToken("stringConst", "doubleQuote", "doubleQuote", "backSlash");

			return oSpec;
		}
		//=========================================================================================
		protected override void FillKeywordGroups(Dictionary<string, TextStyle> dictionary)
		{
			base.FillKeywordGroups(dictionary);
			TextStyle oStyle;

			///Ключевые слова первого эшелона
			oStyle = this.GetStyleByName(S_KEYWORDS_1);
			this.LoadKeywordsToGroup(dictionary, oStyle, @"
AddHandler 	
AddressOf 	
Alias 	
And 

AndAlso 	
As 	
Boolean 	
ByRef 

Byte 	
ByVal 	
Call 	
Case 

Catch 	
CBool 	
CByte 	
CChar 

CDate 	
CDec 	
CDbl 	
Char 

CInt 	
Class 	
CLng 	
CObj 

Const 	
Continue 	
CSByte 	
CShort 

CSng 	
CStr 	
CType 	
CUInt 

CULng 	
CUShort 	
Date 	
Decimal 

Declare 	
Default 	
Delegate 	
Dim 

DirectCast 	
Do 	
Double 	
Each 

Else 	
ElseIf 	
End 	
EndIf 

Enum 	
Erase 	
Error 	
Event 

Exit 	
False 	
Finally 	
For 

Friend 	
Function 	
Get 	
GetType 

GetXMLNamespace 	
Global 	
GoSub 	
GoTo 

Handles 	
If
Implements 

Imports
In 	
Inherits 

Integer 	
Interface 	
Is 	
IsNot 

Let 	
Lib 	
Like 	
Long 

Loop 	
Me 	
Mod 	
Module 

MustInherit 	
MustOverride 	
MyBase 	
MyClass 

Namespace 	
Narrowing 	
New 	
Next 

Not 	
Nothing 	
NotInheritable 	
NotOverridable 

Object 	
Of 	
On 	
Operator 

Option 	
Optional 	
Or 	
OrElse 

Overloads 	
Overridable 	
Overrides 	
ParamArray 

Partial 	
Private 	
Property 	
Protected 

Public 	
RaiseEvent 	
ReadOnly 	
ReDim 

REM 	
RemoveHandler 	
Resume 	
Return 

SByte 	
Select 	
Set 	
Shadows 

Shared 	
Short 	
Single 	
Static 

Step 	
Stop 	
String 	
Structure 

Sub 	
SyncLock 	
Then 	
Throw 

To 	
True 	
Try 	
TryCast 

TypeOf 	
Variant 	
Wend 	
UInteger 

ULong 	
UShort 	
Using 	
When 

While 	
Widening 	
With 	
WithEvents 

WriteOnly 	
Xor 	
#Const 	
#Else 

#ElseIf 	
#End 	
#If
");
		}
		//=========================================================================================
		internal override TextStyle GetStyleFor(Token token, string styleName)
		{
			if (token.TokenTypeName == "charConst")
				return this.TextStyles[S_STRINGS];

			return base.GetStyleFor(token, styleName);
		}
		//=========================================================================================
	}
}
