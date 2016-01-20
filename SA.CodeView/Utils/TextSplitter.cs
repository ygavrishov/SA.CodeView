using System;
using System.Collections.Generic;

namespace SA.CodeView.Utils
{
    /// <summary>Разбивает текст на нужные фрагменты.</summary>
    static class TextSplitter
    {
        //=========================================================================================
        /// <summary>Разбиваем переданный текст на слова, разделенные пробелами, табами и переводами строк.</summary>
        internal static IEnumerable<string> GetWordsFromText(string text)
        {
            if (string.IsNullOrEmpty(text))
                yield break;
            int iPos = 0, iStart = char.IsWhiteSpace(text, 0) ? -1 : 0;
            while (iPos < text.Length)
            {
                if (iStart < 0)
                {
                    if (!char.IsWhiteSpace(text, iPos))
                    {
                        iStart = iPos;
                        continue;
                    }
                }
                else
                {
                    if (char.IsWhiteSpace(text, iPos))
                    {
                        yield return text.Substring(iStart, iPos - iStart);
                        iStart = -1;
                        continue;
                    }
                }
                iPos++;
            }
            if (iStart >= 0 && iStart < iPos)
                yield return text.Substring(iStart, iPos - iStart);
        }
        //=========================================================================================
        /// <summary>Разбить текст на строки.</summary>
        internal static List<string> SplitTextToLines(string text)
        {
            List<string> lines = new List<string>();

            int i1 = 0, i2 = 0;
            while (i2 < text.Length)
            {
                char c = text[i2];
                if (c == '\r' || c == '\n')
                {
                    string sLine = text.Substring(i1, i2 - i1);
                    lines.Add(sLine);
                    i1 = i2 + 1;
                    if (c == '\r' && i1 < text.Length && text[i1] == '\n')
                        i1++;
                    i2 = i1;
                }
                else
                    i2++;
            }
            if (i1 < text.Length)
            {
                string sLine = text.Substring(i1);
                lines.Add(sLine);
            }
            else if (i2 == i1)
                lines.Add(string.Empty);
            return lines;
        }
        //=========================================================================================
        /// <summary>Разбить текст на строки.</summary>
        internal static IEnumerable<string> GetLinesFromText(string text)
        {
            int i1 = 0, i2 = 0;
            while (i2 < text.Length)
            {
                char c = text[i2];
                if (c == '\r' || c == '\n')
                {
                    int iLen = i2 - i1;
                    if (i1 >= 0 && iLen >= 0 && i1 + iLen < text.Length)
                    {
                        string sLine;
                        try
                        {
                            sLine = text.Substring(i1, iLen);
                        }
                        catch (Exception ex)
                        {
                            ex.Data.Add("RawText", text);
                            ex.Data.Add("start", i1);
                            ex.Data.Add("len", iLen);
                            throw;
                        }
                        yield return sLine;
                    }
                    i1 = i2 + 1;
                    if (c == '\r' && i1 < text.Length && text[i1] == '\n')
                        i1++;
                    i2 = i1;
                }
                else
                    i2++;
            }
            if (i1 < text.Length)
            {
                string sLine = text.Substring(i1);
                yield return sLine;
            }
            else if (i2 == i1)
                yield return string.Empty;
        }
        //=========================================================================================
    }
}
