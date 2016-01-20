using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.ParsingOnElements;
using SA.CodeView.Parsing;

namespace SA.CodeView.Languages
{
	class OracleSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public const string S_VARIABLES = "Variables";
		public const string S_SERVER_VARIABLES = "Server Variables";
		public const string S_SYSTYPES = "Systypes";
		//=========================================================================================
		public OracleSyntaxSettings()
		{
			this.Operators = new char[] { '=', '+', '-', '/', '*', '%', '>', '<', '&', '|', '^', '~', '(', ')', '[', ']', ',' };
		}
		//=========================================================================================
		protected override List<BaseElement> CreateElements()
		{
			var elements = new List<BaseElement>();
			return elements;
		}
		//=========================================================================================
		protected override Dictionary<string, TextStyle> CreateTextStyles()
		{
			var styles = base.CreateTextStyles();
			this.AddStyle(styles, new TextStyle(S_OPERATORS, Color.Red));
			this.AddStyle(styles, new TextStyle(S_STRINGS, Color.SteelBlue));
			this.AddStyle(styles, new TextStyle(S_MULTI_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_SINGLE_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_IDENTIFIER, Color.Black));
			this.AddStyle(styles, new TextStyle(S_NUMBERS, Color.Teal));
			this.AddStyle(styles, new TextStyle(S_VARIABLES, Color.Magenta));
			this.AddStyle(styles, new TextStyle(S_SERVER_VARIABLES, Color.DarkMagenta));
			this.AddStyle(styles, new TextStyle(S_KEYWORDS_1, Color.Blue, true));
			this.AddStyle(styles, new TextStyle(S_SYSTYPES, Color.DarkBlue, true));
			return styles;
		}
		//=========================================================================================
		internal override ScannerSpecification CreateScannerSpecification()
		{
			var oSpec = new ScannerSpecification();
			oSpec.AddLiteral("l", CharType.Letters, '_', '@');
			oSpec.AddLiteral("d", CharType.Numbers);
			oSpec.AddLiteral("minus", '-');
			oSpec.AddLiteral("asterisk", '*');
			oSpec.AddLiteral("slash", '/');
			oSpec.AddLiteral("operators", '=', '>', '<', ';', ',', '.', '+', ')', '(', '|', '&');
			oSpec.AddLiteral("singleQuote", '\'');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("caretReturn", '\n');

			oSpec.AddTokenDeclaration("id", "l{l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("operator", "(operators|minus)");	// |asterisk
			oSpec.AddBoundedToken("stringConst", "singleQuote", "singleQuote", "singleQuote");
			oSpec.AddBoundedToken("comment1", "slash asterisk", "asterisk slash", null);
			oSpec.AddBoundedToken("comment2", "minus minus", "caretReturn", null);
			oSpec.AddBoundedToken("quotedId", "doubleQuote", "doubleQuote", null);

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
ACCESS
ADD
ADMIN
AFTER
ALL
ALLOCATE
ALTER
ANALYZE
AND
ANY
ARCHIVE
ARCHIVELOG
AS
ASC
AUDIT

BACKUP
BECOME
BEFORE
BETWEEN
BLOCK
BUFFER_POOL
BY

CACHE
CANCEL
CASCADE
CHANGE
CHARACTER
CHECK
CHECKPOINT
CLUSTER
COBOL
COLUMN
COMMENT
COMMIT
COMPILE
COMPRESS
CONNECT
CONSTRAINT
CONSTRAINTS
CONTENTS
CONTINUE
CONTROLFILE
CREATE

CURRENT
CURRVAL
CYCLE

DATAFILE
DEC
DECIMAL
DEFAULT
DELETE
DESC
DISABLE
DISMOUNT
DISTINCT
DOUBLE
DROP

EACH
ELSE
ENABLE
ERRORS
ESCAPE
EVENTS
EXCEPT
EXCEPTIONS
EXCLUSIVE
EXEC
EXECUTE
EXISTS
EXPLAIN
EXTENT
EXTERNALLY

FILE
FLUSH
FOR
FORCE
FOREIGN
FORTRAN
FOUND
FREELIST
FREELISTS
FROM
FUNCTION

GO
GRANT
GROUP
GROUPS

HAVING

IDENTIFIED
IMMEDIATE
IN
INCLUDING
INCREMENT
INDEX
INITIAL
INITRANS
INSERT
INSTANCE
INT
INTERSECT
INTO
IS
KEEP
KEY
LANGUAGE
LAYER
LEVEL
LIKE
LINK
LISTS
LOCAL
LOCK
LOGGING
LOGFILE

MANAGE
MANUAL
MAXDATAFILES
MAXEXTENTS
MAXINSTANCES
MAXLOGFILES
MAXLOGHISTORY
MAXLOGMEMBERS
MAXTRANS
MAXVALUE
MINEXTENTS
MINUS
MINVALUE
MLSLABEL
MODE
MODIFY
MODULE
MOUNT

NEXT
NEXTVAL
NOARCHIVELOG
NOAUDIT
NOCACHE
NOCOMPRESS
NOCYCLE
NOLOGGING
NOMAXVALUE
NOMINVALUE
NONE
NOORDER
NORESETLOGS
NORMAL
NOSORT
NOT
NOTFOUND
NOWAIT
NULL
NUMERIC

OF
OFF
OFFLINE
ON
ONLINE
ONLY
OPTIMAL
OPTION
OR
ORDER
OWN

PARALLEL
PCTFREE
PCTINCREASE
PCTUSED
PLAN
PLI
PRECISION
PRIMARY
PRIOR
PRIVILEGES
PROFILE
PROCEDURE
PUBLIC

QUOTA

READ
RECOVER
RECYCLE
REFERENCES
REFERENCING
RENAME
REPLACE
RESETLOGS
RESOURCE
RESTRICTED
RETURN
REUSE
REVOKE
ROLE
ROLES
ROW
ROWID
ROWLABEL
ROWNUM
ROWS

SCN
SECTION
SEGMENT
SELECT
SEQUENCE
SESSION
SET
SHARE
SHARED
SIZE
SNAPSHOT
SOME
SORT
SQLBUF
SQLERROR
SQLSTATE
START
STATEMENT_ID
STATISTICS
STOP
STORAGE
SUCCESSFUL
SWITCH
SYNONYM
SYSDATE
SYSTEM

TABLE
TABLESPACE
TEMPORARY
THEN
THREAD
TIME
TO
TRACING
TRANSACTION
TRIGGER
TRIGGERS
TRUNCATE

UNDER
UNION
UNIQUE
UNLIMITED
UNTIL
UPDATE

VALIDATE
VALUES
VIEW

WHENEVER
WHERE
WITH
ZONE

ABORT ACCEPT ARRAY ARRAYLEN ASSERT ASSIGN AT AUTHORIZATION  BASE_TABLE BEGIN BODY  CASE CHAR_BASE CLOSE CLUSTERS COLAUTH COLUMNS CONSTANT CRASH CURSOR  DATABASE DATA_BASE DBA DEBUGOFF DEBUGON DECLARE DEFINITION DELAY DELTA DIGITS DISPOSE DO  ELSIF END ENTRY EXCEPTION EXCEPTION_INIT EXIT  FALSE FETCH FORM GENERIC GOTO  IF INDEXES INDICATOR INTERFACE  LIMITED LOOP  NATURAL NATURALN NEW NUMBER_BASE  OLD OPEN OUT  PACKAGE PARTITION POSITIVE POSITIVEN PRAGMA PRIVATE RAISE RANGE RECORD REF RELEASE REMR RESTRICT_REFERENCES REVERSE ROLLBACK ROWTYPE RUN  SAVEPOINT SCHEMA SEPARATE SEPERATE SPACE SQL SQLCODE SQLERRM STATEMENT SUBTYPE  TABAUTH TABLES TASK TERMINATE TRUE TYPE  USE  VIEWS  WHEN WHILE WORK WRITE  XOR
");

			///ключевые слова - типы данных
			oStyle = this.GetStyleByName(S_SYSTYPES);
			this.LoadKeywordsToGroup(dictionary, oStyle, @"
BFILE
BFILE_TABLE
BINARY_DOUBLE
BINARY_FLOAT
BINARY_INTEGER
BLOB
BLOB_TABLE
BOOLEAN
BYTE
CHAR
CHARRARR
CLOB
CLOB_TABLE
DATE
DATE_TABLE
DBLINK_ARRAY
DESC_REC
DESC_TAB
FILE_TYPE
FLOAT
INDEX_TABLE_TYPE
INTEGER
LONG
MAXWAIT
NAME_ARRAY
NATIVE
NCHAR
NCLOB
NVARCHAR
NVARCHAR2
NUMBER
NUMBER_ARRAY
NUMBER_TABLE
PLS_INTEGER
RAW
REAL
REG_REPAPI_SNAPSHOT
REG_UNKNOWN
REG_V7_SNAPSHOT
REG_V8_SNAPSHOT
RNDS
RNPS
SDO_GEOMETRY
SMALLINT
TIMESTAMP
UNCL_ARRAY
V6
V7
VARCHAR
VARCHAR2
VARCHAR2S
VARCHAR2_TABLE
WNDS
WNPS"
				);

			///ключевые слова - системные функции
			oStyle = this.GetStyleByName(S_SYS_FUNCTION);
			this.LoadKeywordsToGroup(dictionary, oStyle,
				"ABS ACOS ADD_MONTHS ASCII ASIN ATAN ATAN2 AVG BFILENAME CEIL CHARTOROWID CHR CONCAT CONVERT COS COSH COUNT CURRENT_DATE DECODE DEREF DUMP  EMPTY_BLOB EMPTY_CLOB EXP  FLOOR  GREATEST  HEXTORAW  INITCAP INSTR INSTRB  LAST_DAY LEAST LENGTH LENGTHB LN LOG LOWER LPAD LTRIM  MAKE_REF MAX MIN MOD MONTH MONTHS_BETWEEN NEW_TIME NEXT_DAY NLS_CHARSET_DECL_LEN NLS_CHARSET_ID NLS_CHARSET_NAME NLS_INITCAP NLS_LOWER NLS_SORT NLS_UPPER NVL  POWER  RAWTOHEX REFTOHEX ROUND ROWIDTOCHAR RPAD RTRIM  SIGN SIN SINH SOUNDEX SQRT STDDEV SUBSTR SUBSTRB SUM SYSTIMESTAMP TAN TANH TO_CHAR TO_DATE TO_LABEL TO_MULTI_BYTE TO_NUMBER TO_SINGLE_BYTE TRANSLATE TRUNC  UID UPPER USER USERENV USING  VARIANCE VSIZE YEAR");
		}
		//=========================================================================================
		internal override TextStyle GetStyleFor(Token token, string styleName)
		{
			if (token.TokenTypeName == "id")
			{
				if (token.Text.Length > 2)
				{
					if (token.Text[0] == '@')
					{
						if (token.Text[1] == '@')
							return this.TextStyles[S_SERVER_VARIABLES];
						else
							return this.TextStyles[S_VARIABLES];
					}
				}
			}
			return base.GetStyleFor(token, styleName);
		}
		//=========================================================================================
	}
}
