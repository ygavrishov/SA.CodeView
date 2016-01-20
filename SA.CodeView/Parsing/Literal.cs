using System;

namespace SA.CodeView.Parsing
{
	/// <summary>Определяет класс символа во входном потоке.</summary>
	class Literal
	{
		/// <summary>Имя литерала.</summary>
		public readonly string Name;
		/// <summary>Маска типов символа, которые будут являться данным литералом.</summary>
		public readonly CharType CharTypes;
		/// <summary>Если символ является одним из перечисленных, то это наш литерал.</summary>
		public readonly char[] Chars;
		//=========================================================================================
		private CharType GetCharType(char c)
		{
			if (char.IsLetter(c))
				return CharType.Letters;
			if (char.IsDigit(c))
				return CharType.Numbers;
			return CharType.Unknown;
		}
		//=========================================================================================
		public Literal(string name, CharType charTypes, params char[] chars)
		{
			this.Name = name;
			this.Chars = chars;
			this.CharTypes = charTypes;
		}
		//=========================================================================================
		public Literal(string name, params char[] chars)
		{
			this.Name = name;
			this.Chars = chars;
		}
		//=========================================================================================
		/// <summary>Является ли указанный символ нашим литералам.</summary>
		internal bool IsValid(char c)
		{
			if (this.CharTypes != 0)
			{
				if ((this.CharTypes & CharType.AnyNonSpaces) != 0)
					return !char.IsWhiteSpace(c);
				CharType charType = this.GetCharType(c);
				if ((this.CharTypes & charType) != 0)
					return true;
			}
			for (int i = 0; i < this.Chars.Length; i++)
			{
				if (c == this.Chars[i])
					return true;
			}
			return false;
		}
		//=========================================================================================
		public override string ToString()
		{
			return this.Name;
		}
		//=========================================================================================
	}
}
