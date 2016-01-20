using System;
using System.Windows.Forms;
using System.Collections.Generic;
using SA.CodeView.Parsing;

namespace SA.CodeView.IntelliSense
{
	/// <summary>Supply suggestion list for typed text.</summary>
    public abstract class SuggestionBuilder
    {
        protected readonly CodeViewer Viewer;
        public ImageList Images { get; set; }
        //=========================================================================================
        public SuggestionBuilder(CodeViewer viewer)
        {
            this.Viewer = viewer;
        }
        //=========================================================================================
        /// <summary>Supply variants of auto completion.</summary>
        public abstract CompletionVariantList GetVariants();
        //=========================================================================================
        /// <summary>Is the token list contain specified token</summary>
        protected bool CheckTokenId(int iTokenId)
        {
            bool notCorrect = iTokenId < 0 || iTokenId >= this.Viewer.Tokens.Count;

            return !notCorrect;
        }
		//=========================================================================================
	}
}
