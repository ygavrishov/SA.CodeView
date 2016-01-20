using System;

namespace SA.CodeView
{
	//#############################################################################################
	enum CaretLocationType
	{
		WordStart,
		WordCenter,
		WordEnd,
		BetweenWords,
	}
	//#############################################################################################
	struct CaretLocation
	{
		public CaretLocationType Location;
		public int TokenIndex;
		//=========================================================================================
		public CaretLocation(int tokenIndex, CaretLocationType type)
		{
			this.TokenIndex = tokenIndex;
			this.Location = type;
		}
		//=========================================================================================
		public override string ToString()
		{
			return string.Format("{0}, {1}", this.TokenIndex, this.Location);
		}
		//=========================================================================================
	}
}
