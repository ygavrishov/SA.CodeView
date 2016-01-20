using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.ParsingOnElements;
using SA.CodeView.Parsing;

namespace SA.CodeView.Languages
{
	class MySqlSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public MySqlSyntaxSettings()
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
			this.AddStyle(styles, new TextStyle(S_STRINGS, Color.Red));
			this.AddStyle(styles, new TextStyle(S_MULTI_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_SINGLE_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_IDENTIFIER, Color.Black));
			this.AddStyle(styles, new TextStyle(S_NUMBERS, Color.Teal));
			this.AddStyle(styles, new TextStyle(S_KEYWORDS_1, Color.Blue));
			this.AddStyle(styles, new TextStyle(S_SYS_FUNCTION, Color.DarkBlue));

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
			oSpec.AddLiteral("poundkey", '#');
			oSpec.AddLiteral("operators", '=', '>', '<', ';', ',', '.', '+', ')', '(', '|', '&');
			oSpec.AddLiteral("n", 'N', 'n');
			oSpec.AddLiteral("singleQuote", '\'');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("caretReturn", '\n');
			oSpec.AddLiteral("tilda", '`');

			oSpec.AddTokenDeclaration("id", "(n|l){l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("operator", "(operators|minus)");	// |asterisk
			oSpec.AddBoundedToken("stringConst", "singleQuote", "singleQuote", "singleQuote");
			oSpec.AddBoundedToken("stringConst", "n singleQuote", "singleQuote", "singleQuote");
			oSpec.AddBoundedToken("stringConst", "doubleQuote", "doubleQuote", "doubleQuote");
			oSpec.AddBoundedToken("comment1", "slash asterisk", "asterisk slash", null);
			oSpec.AddBoundedToken("comment2", "minus minus", "caretReturn", null);
			oSpec.AddBoundedToken("comment3", "poundkey", "caretReturn", null);
			oSpec.AddBoundedToken("quotedId", "tilda", "tilda", "tilda");

			return oSpec;
		}
		//=========================================================================================
		protected override void FillKeywordGroups(Dictionary<string, TextStyle> dictionary)
		{
			base.FillKeywordGroups(dictionary);

			//Ключевые слова первого эшелона
			TextStyle oStyle = this.GetStyleByName(S_KEYWORDS_1);
			this.LoadKeywordsToGroup(dictionary, oStyle, @"
add
after
algorithm
all
alter
and
as
asc
auto_increment
before
begin
between
binary
both
by
change
character
charset
check
client
collate
column
columns
comment
commit
constraint
contains
create
cross
data
database
databases
declare
default
definer
delayed
delete
delimiter
desc
describe
deterministic
distinct
do
drop
each
enclosed
end
engine
escaped
event
execute
exists
explain
field
fields
file
flush
for
foreign
from
function
grant
group
having
identified
if
ignore
index
infile
innodb
insert
into
join
key
keys
kill
leading
left
like
limit
lines
load
local
lock
low_priority
modify
myisam
natural
new
not
null
on
optimize
option
optionally
or
order
out
outer
outfile
primary
procedure
process
read
references
regexp
reload
rename
repeat
replace
replication
returns
revoke
rlike
routine
row
security
select
set
show
shutdown
slave
soname
sql
status
straight_join
super
table
tables
tablespace
teminated
temporary
to
trailing
trigger
unique
unlock
unsigned
update
use
user
using
values
variables
view
where
while
with
write
xor
zerofill
bigint bit blob char date datetime decimal double doubleprecision enum float float4 float8 int int1 int2 int3 int4 int8 integer long longblob longtext mediumblob mediumint mediumtext middleint numeric real smallint text time timestamp tinyint tinytext tinyblob varbinary varchar varying
");

			//ключевые слова - системные функции
			oStyle = this.GetStyleByName(S_SYS_FUNCTION);
			this.LoadKeywordsToGroup(dictionary, oStyle,
				"abs acos adddate ascii asin atan atan2 avg bin bit_and bit_count bit_or ceiling char_lengh character_length concat conv cos cot count curdate curtime current_time current_timestamp date_add date_format date_sub dayname dayofmonth dayofweek dayofyear degrees elt encrypt exp find_in_set floor format from_days from_unixtime get_lock greatest hex hour ifnull instr isnull interval last_insert_id lcase lower least length locate log log10 lpad ltrim max mid min minute mod month monthname now oct octet_length password period_add period_diff pi position pow quarter radians rand release_lock reverse right round rpad rtrim second sec_to_time session_user sign sin soundex space sqrt strcmp substring substring_index sysdate system_user std sum tan time_format time_to_sec to_days trim truncate ucase unix_timestamp version week weekday year");
		}
		//=========================================================================================
	}
}
