
using System;
using System.IO;
using System.Collections;
using System.Text;

namespace SA.CodeView.Parsing.TokenDefParsing {

public class Token
{
    public int kind;    // token kind
    public int pos;     // token position in the source text (starting at 0)
    public int col;     // token column (starting at 1)
    public int line;    // token line (starting at 1)
    public string val;  // token value
    public string FullValue;	//not truncated token value (with brackets and quotes)
    public Token next;  // ML 2005-03-11 Tokens are kept in linked list
}

//-----------------------------------------------------------------------------------
// Buffer
//-----------------------------------------------------------------------------------
public class Buffer
{
    // This Buffer supports the following cases:
    // 1) seekable stream (file)
    //    a) whole stream in buffer
    //    b) part of stream in buffer
    // 2) non seekable stream (network, console)

    public const int EOF = char.MaxValue + 1;
    const int MIN_BUFFER_LENGTH = 1024; // 1KB
    const int MAX_BUFFER_LENGTH = MIN_BUFFER_LENGTH * 64; // 64KB
    byte[] buf;         // input buffer
    int bufStart;       // position of first byte in buffer relative to input stream
    int bufLen;         // length of buffer
    int fileLen;        // length of input stream (may change if the stream is no file)
    int bufPos;         // current position in buffer
    Stream stream;      // input stream (seekable)
    bool isUserStream;  // was the stream opened by the user?

    public Buffer(Stream s, bool isUserStream)
    {
        stream = s; this.isUserStream = isUserStream;

        if (stream.CanSeek)
        {
            fileLen = (int)stream.Length;
            bufLen = Math.Min(fileLen, MAX_BUFFER_LENGTH);
            bufStart = Int32.MaxValue; // nothing in the buffer so far
        }
        else
        {
            fileLen = bufLen = bufStart = 0;
        }

        buf = new byte[(bufLen > 0) ? bufLen : MIN_BUFFER_LENGTH];
        if (fileLen > 0) Pos = 0; // setup buffer to position 0 (start)
        else bufPos = 0; // index 0 is already after the file, thus Pos = 0 is invalid
        if (bufLen == fileLen && stream.CanSeek) Close();
    }

    protected Buffer(Buffer b)
    { // called in UTF8Buffer constructor
        buf = b.buf;
        bufStart = b.bufStart;
        bufLen = b.bufLen;
        fileLen = b.fileLen;
        bufPos = b.bufPos;
        stream = b.stream;
        // keep destructor from closing the stream
        b.stream = null;
        isUserStream = b.isUserStream;
    }

    ~Buffer() { Close(); }

    protected void Close()
    {
        if (!isUserStream && stream != null)
        {
            stream.Close();
            stream = null;
        }
    }

    public virtual int Read()
    {
        if (bufPos < bufLen)
        {
            return buf[bufPos++];
        }
        else if (Pos < fileLen)
        {
            Pos = Pos; // shift buffer start to Pos
            return buf[bufPos++];
        }
        else if (stream != null && !stream.CanSeek && ReadNextStreamChunk() > 0)
        {
            return buf[bufPos++];
        }
        else
        {
            return EOF;
        }
    }

    public int Peek()
    {
        int curPos = Pos;
        int ch = Read();
        Pos = curPos;
        return ch;
    }

    public string GetString(int beg, int end)
    {
		int len = (end-beg)/2;

        char[] buf = new char[len];
        int oldPos = Pos;
        Pos = beg;
        for (int i = 0; i < len; i++) buf[i] = (char)Read();
        Pos = oldPos;
        return new String(buf);
    }

    public int Pos
    {
        get { return bufPos + bufStart; }
        set
        {
            if (value >= fileLen && stream != null && !stream.CanSeek)
            {
                // Wanted position is after buffer and the stream
                // is not seek-able e.g. network or console,
                // thus we have to read the stream manually till
                // the wanted position is in sight.
                while (value >= fileLen && ReadNextStreamChunk() > 0) ;
            }

            if (value < 0 || value > fileLen)
            {
                throw new AnalyzingException("Buffer out of bounds access, position: " + value);
            }

            if (value >= bufStart && value < bufStart + bufLen)
            { // already in buffer
                bufPos = value - bufStart;
            }
            else if (stream != null)
            { // must be swapped in
                stream.Seek(value, SeekOrigin.Begin);
                bufLen = stream.Read(buf, 0, buf.Length);
                bufStart = value; bufPos = 0;
            }
            else
            {
                // set the position to the end of the file, Pos will return fileLen.
                bufPos = fileLen - bufStart;
            }
        }
    }

    // Read the next chunk of bytes from the stream, increases the buffer
    // if needed and updates the fields fileLen and bufLen.
    // Returns the number of bytes read.
    private int ReadNextStreamChunk()
    {
        int free = buf.Length - bufLen;
        if (free == 0)
        {
            // in the case of a growing input stream
            // we can neither seek in the stream, nor can we
            // foresee the maximum length, thus we must adapt
            // the buffer size on demand.
            byte[] newBuf = new byte[bufLen * 2];
            Array.Copy(buf, newBuf, bufLen);
            buf = newBuf;
            free = bufLen;
        }
        int read = stream.Read(buf, bufLen, free);
        if (read > 0)
        {
            fileLen = bufLen = (bufLen + read);
            return read;
        }
        // end of stream reached
        return 0;
    }
}

//-----------------------------------------------------------------------------------
// UTF8Buffer
//-----------------------------------------------------------------------------------
public class UTF8Buffer : Buffer
{
    public UTF8Buffer(Buffer b) : base(b) {}

    public override int Read()
    {
        int ch;
        do
        {
            ch = base.Read();
            // until we find a uft8 start (0xxxxxxx or 11xxxxxx)
        } while ((ch >= 128) && ((ch & 0xC0) != 0xC0) && (ch != EOF));
        if (ch < 128 || ch == EOF)
        {
            // nothing to do, first 127 chars are the same in ascii and utf8
            // 0xxxxxxx or end of file character
        }
        else if ((ch & 0xF0) == 0xF0)
        {
            // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
            int c1 = ch & 0x07; ch = base.Read();
            int c2 = ch & 0x3F; ch = base.Read();
            int c3 = ch & 0x3F; ch = base.Read();
            int c4 = ch & 0x3F;
            ch = (((((c1 << 6) | c2) << 6) | c3) << 6) | c4;
        }
        else if ((ch & 0xE0) == 0xE0)
        {
            // 1110xxxx 10xxxxxx 10xxxxxx
            int c1 = ch & 0x0F; ch = base.Read();
            int c2 = ch & 0x3F; ch = base.Read();
            int c3 = ch & 0x3F;
            ch = (((c1 << 6) | c2) << 6) | c3;
        }
        else if ((ch & 0xC0) == 0xC0)
        {
            // 110xxxxx 10xxxxxx
            int c1 = ch & 0x1F; ch = base.Read();
            int c2 = ch & 0x3F;
            ch = (c1 << 6) | c2;
        }
        return ch;
    }
}
//-----------------------------------------------------------------------------------
// UTF16beBuffer
//-----------------------------------------------------------------------------------
public class UTF16beBuffer : Buffer
{
    public UTF16beBuffer(Buffer b) : base(b) {}

    public override int Read()
    {
        Int32 ch,b1,b2;
		/// Ïðèìåð: 'ò' = 04 42
        b1 = (Int32)base.Read();	// Ïðèìåð: b1 = 04
		if(b1 == Buffer.EOF)
			return Buffer.EOF;
        b2 = (Int32)base.Read();	// Ïðèìåð: b2 = 42
        ch=(b1<<8)|b2;				// Ïðèìåð: ch = 04 42
        return ch;
    }
}
//-----------------------------------------------------------------------------------
// Scanner
//-----------------------------------------------------------------------------------
public class Scanner
{
    const char EOL = '\n';
    const int eofSym = 0; /* pdt */
	const int maxT = 9;
	const int noSym = 9;
	char valCh;       // current input character (for token.val)

    public Buffer buffer; // scanner buffer
    //>>>>>[mb]>>>>>>>
	public string FileName;	//file name which contain the text
    //<<<<<[mb]<<<<<<<
	
	//>>>>>[mb]>>>>>>>
    //made for method RollBack()
    public int ch_back;
    public int pos_back;
    public int col_back;
    public int line_back;
    public Token t_back;
    //<<<<<[mb]<<<<<<<	
	
    Token t;          // current token
    int ch;           // current input character
    int pos;          // byte position of current character
    int col;          // column number of current character
    int line;         // line number of current character
    int oldEols;      // EOLs that appeared in a comment;
    Hashtable start;  // maps first token character to start state

    Token tokens;     // list of tokens already peeked (first token is a dummy)
    Token pt;         // current peek token

    char[] tval = new char[128]; // text of current token
    int tlen;         // length of current token
   
    public Scanner(string fileName)
    {
        try
        {
            Stream stream = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.Read);
			MemoryStream ms = new MemoryStream();
			int ch = stream.ReadByte();
			/// Îïðåäåëèì  -  ÿâëÿåòñÿ ëè êîäèðîâêîé Unicode(Utf-16,Utf-32,Utf-8)
			if(ch==0xFE || ch==0xFF || ch==0x00 || ch==0xEF )
			{	
				/// Ïåðâûé áàéò ñîîòâåòñòâóåò îäíîé èç êîäèðîâîê Unicode
				/// Òåïåðü ïðîâåðèì âñþ ìåòêó
				int ch1 = stream.ReadByte();
				int ch2 = stream.ReadByte();
				int ch3 = stream.ReadByte();
				if ((ch!= 0xEF || ch1!= 0xBB || ch2 != 0xBF) &&
					(ch!= 0xFE || ch1!= 0xFF ) &&
					(ch!= 0xFF || ch1!= 0xFE ) &&
					(ch!= 0x00 || ch1!= 0x00 || ch2!= 0xFE || ch3!= 0xFF )&&
					(ch!= 0xFF || ch1!= 0xFE || ch2!= 0x00 || ch3!= 0x00 ))
				{
					throw new AnalyzingException(String.Format("Illegal byte order mark"));
				}
				Int32 ib,ibtemp;
				stream.Seek(0, SeekOrigin.Begin);
				/// StreamReader ïðåîáðàçóåò âñå êîäèðîâêè ê ôîðìàòó Unicode 16le
				using( StreamReader reader = new StreamReader(stream, true))
				{
					/// 0xFF - çíà÷èò, ÷òî íåîáõîäèìî ñîçäàòü UTF16beBuffer
					ms.WriteByte(0xFF);
					while (!reader.EndOfStream)
					{
						/// Ïîëó÷àåì ñèìâîë â ôîðìàòå Unicode 16be
						/// Ïðèìåð: 'ò' = 00 00 04 42 (4 áàéòà ò.ê. ib òèïà int) 
						ib = (char)reader.Read();
						/// Ïîëó÷èì ñòàðøèé áàéò ñèìâîëà
						ibtemp = ib>>8;							// Ïðèìåð: ibtemp = 00 00 00 04
						
						ms.WriteByte((byte)ibtemp);
						/// Ïîëó÷èì ìëàäøèé áàéò ñèìâîëà
						ibtemp = ib&0x000000ff;					// Ïðèìåð: ibtemp = 00 00 00 42
						ms.WriteByte((byte)ibtemp);
					}
				}
			}
			/// Èíà÷å áóäåì ñ÷èòàòü, ÷òî ýòî òåêóùàÿ îäíîáàéòîâàÿ êîäèðîâêà 
			/// è ïåðåêîäèðóåì å¸ â Unicode 16be
			else	
			{
				int iStreamLen = (int)stream.Length;
				/// Ðàçìåð ïîòîêà â ôîðìàòå Unicode â äâà ðàçà áîëüøå, ÷åì â òåêóøåé îäíîáàéòîâîé êîäèðîâêå
				byte[] BytesOld = new byte[iStreamLen];
				byte[] BytesEncoded = new byte[iStreamLen*2];
				
				stream.Seek(0, SeekOrigin.Begin);
				stream.Read(BytesOld, 0, iStreamLen);
				BytesEncoded = Encoding.Convert(Encoding.Default, Encoding.BigEndianUnicode, BytesOld);
				/// Ïðèìåð: 'ò' = 04 42
				ms.WriteByte(0xFF);
				for(int i=0;i<iStreamLen*2;i++)
					ms.WriteByte(BytesEncoded[i]);
			}

			if(ms.Length > 0)
				buffer = new Buffer(ms, false);
			else
				buffer = new Buffer(stream, false);
            Init();
			//>>>>>[mb]>>>>>>>
            this.FileName = fileName;
			//<<<<<[mb]<<<<<<<
        }
        catch (IOException)
        {
            throw new AnalyzingException("File '" + fileName + "' does not exist.");
        }
    }

    public Scanner(string sScript, string sFileName)
    {
        if (string.IsNullOrEmpty(sScript))
            throw new AnalyzingException("Script is empty");

        Encoding asd = Encoding.BigEndianUnicode;
        byte[] Bytes = asd.GetBytes(sScript);

        MemoryStream ms = new MemoryStream();
        ms.WriteByte(0xFF);
        ms.Write(Bytes,0,Bytes.Length);
        buffer = new Buffer(ms, true);
        //>>>>>[mb]>>>>>>>
        this.FileName = sFileName;
        //<<<<<[mb]<<<<<<<
        Init();
    }

	////Ñòàðûé êîíñòðóêòîð. Íå ïðåîáðàçóåò äàííûå â Unicode!!!
    //public Scanner(Stream s)
    //{
    //    buffer = new Buffer(s, true);
    //    Init();
    //}

    void Init()
    {
        pos = -1; line = 1; col = 0;
        oldEols = 0;
        NextCh();
        if (ch == 0xEF)
        { // check optional byte order mark for UTF-8
            NextCh(); int ch1 = ch;
            NextCh(); int ch2 = ch;
            if (ch1 != 0xBB || ch2 != 0xBF)
            {
                throw new AnalyzingException(String.Format("Illegal byte order mark: EF {0,2:X} {1,2:X}", ch1, ch2));
            }
            buffer = new UTF8Buffer(buffer); col = 0;
            NextCh();
        }
        // 0xFF îçíà÷àåò, ÷òî òåêñò áûë ïåðåêîäèðîâàí â Unicode 16be
        else if(ch == 0xFF)
        {
			buffer = new UTF16beBuffer(buffer); col = 0;
            NextCh();
        }
        start = new Hashtable(128);
		for (int i = 95; i <= 95; ++i) start[i] = 1;
		for (int i = 97; i <= 122; ++i) start[i] = 1;
		start[124] = 2; 
		start[40] = 3; 
		start[41] = 4; 
		start[91] = 5; 
		start[93] = 6; 
		start[123] = 7; 
		start[125] = 8; 
		start[Buffer.EOF] = -1;

        pt = tokens = new Token();  // first token is a dummy
    }

    void NextCh()
    {
        if (oldEols > 0) { ch = EOL; oldEols--; }
        else
        {
            pos = buffer.Pos;
            ch = buffer.Read(); col++;
            // replace isolated '\r' by '\n' in order to make
            // eol handling uniform across Windows, Unix and Mac
            if (ch == '\r' && buffer.Peek() != '\n') ch = EOL;
            if (ch == EOL) { line++; col = 0; }
        }
		valCh = (char) ch;
		if (ch != Buffer.EOF)
			ch = char.ToLower((char) ch);

    }

    void AddCh()
    {
        if (tlen >= tval.Length)
        {
            char[] newBuf = new char[2 * tval.Length];
            Array.Copy(tval, 0, newBuf, 0, tval.Length);
            tval = newBuf;
        }
			tval[tlen++] = valCh;
        NextCh();
    }




    void CheckLiteral()
    {
		switch (t.val.ToLower()) {
			default: break;
		}
    }
    
    //>>>>>>>[mb]>>>>>>>>>>>>>>
    //return to previous scanner state
    public void RollBack()
    {
        this.ch = this.ch_back;
        this.pos = this.pos_back;
        this.buffer.Pos = this.pos_back;
        this.col = this.col_back;
        this.line = this.line_back;
        this.t = this.tokens = this.t_back;
        if (tokens != null)
            tokens.next = null;
    }
    //<<<<<<<[mb]<<<<<<<<<<<<<<

    Token NextToken()
    {
        //>>>>>>>[mb]>>>>>>>>>>>>>>
        //save parameters needed for roling back
        this.ch_back = this.ch;
        this.pos_back = this.pos;
        this.col_back = this.col;
        this.line_back = this.line;
        this.t_back = this.t;
        //<<<<<<<[mb]<<<<<<<<<<<<<<
        
	while (ch == ' ' ||
			ch >= 9 && ch <= 10 || ch == 13
	) NextCh();

	t = new Token();
	t.pos = pos; t.col = col; t.line = line; 
	int state;
	if (start.ContainsKey(ch)) { state = (int) start[ch]; }
	else { state = 0;	}
	tlen = 0;

    if (ch == 'n' || ch == 'N')
    {
        AddCh();
        if (ch == '\'')
        {
        apostrophN:
            this.AddCh();
            while (ch != '\'' && ch != '\0' && ch != Buffer.EOF)
                this.AddCh();
            this.AddCh();
            if (ch == '\'')
            {
                goto apostrophN;
            }
            t.kind = 3;
            t.val = new String(tval, 1, tlen-1);
            t.FullValue = "N" + new String(tval, 1, tlen - 1);
            return t;
        }
    }
    else if (ch == '\'')
    {
    apostroph:
        this.AddCh();
        while (ch != '\'' && ch != '\0' && ch != Buffer.EOF)
            this.AddCh();
        this.AddCh();
        if (ch == '\'' && ch != '\0')
        {
            goto apostroph;
        }
        t.kind = 2;
        t.val = new String(tval, 0, tlen);
        return t;
    }
    else
        AddCh();
	
	switch (state) {
		case -1: { t.kind = eofSym; break; } // NextCh already done
		case 0: { t.kind = noSym; break; }   // NextCh already done
			case 1:
				if (ch >= '0' && ch <= '9' || ch == '_' || char.IsLetter((char)ch)) {AddCh(); goto case 1;}
				else {t.kind = 1; break;}
			case 2:
				{t.kind = 2; break;}
			case 3:
				{t.kind = 3; break;}
			case 4:
				{t.kind = 4; break;}
			case 5:
				{t.kind = 5; break;}
			case 6:
				{t.kind = 6; break;}
			case 7:
				{t.kind = 7; break;}
			case 8:
				{t.kind = 8; break;}

	}
	t.val = new String(tval, 0, tlen);
	return t;
}

    // get the next token (possibly a token already seen during peeking)
    public Token Scan()
    {
        if ( t!= null && t.val == "\0" && tokens.next == null)
			return t;
        if (tokens.next == null)
        {
			Token token = this.NextToken();
			if (token.FullValue == null)
				token.FullValue = token.val;
            return token;
        }
        else
        {
            pt = tokens = tokens.next;
            return tokens;
        }
    }

    // peek for the next token, ignore pragmas
    public Token Peek()
    {
        if (pt.next == null)
        {
            do
            {
                pt = pt.next = NextToken();
                if (pt.FullValue == null)
                    pt.FullValue = pt.val;
            } while (pt.kind > maxT); // skip pragmas
        }
        else
        {
            do
            {
                pt = pt.next;
            } while (pt.kind > maxT);
        }
        return pt;
    }

    // make sure that peeking starts at the current scan position
    public void ResetPeek() { pt = tokens; }
} // end Scanner

}