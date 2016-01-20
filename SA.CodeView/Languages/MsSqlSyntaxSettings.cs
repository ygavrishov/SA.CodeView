using System.Collections.Generic;
using System.Drawing;
using SA.CodeView.ParsingOnElements;
using SA.CodeView.Parsing;

namespace SA.CodeView.Languages
{
	class MsSqlSyntaxSettings : SyntaxSettings
	{
		//=========================================================================================
		public MsSqlSyntaxSettings()
		{
			this.Operators = new char[] { '=', '+', '-', '/', '*', '%', '>', '<', '&', '|', '^', '~', '(', ')', '[', ']', ',' };
		}
		//=========================================================================================
		protected override List<BaseElement> CreateElements()
		{
			var elements = new List<BaseElement>();
			//Идентификаторы в квадратных скобках
			var oStyle = this.GetStyleByName(S_IDENTIFIER);
			BoundedElement oGroupId = new BoundedElement(oStyle, "[", "]");
			elements.Add(oGroupId);

			//Однострочные комментарии
			oStyle = this.GetStyleByName(S_SINGLE_COMMENT);
			BoundedElement oGroupComment = new BoundedElement(oStyle, "--", "");
			elements.Add(oGroupComment);

			//Многострочные комментарии
			oStyle = this.GetStyleByName(S_MULTI_COMMENT);
			BoundedElement oGroupComment2 = new BoundedElement(oStyle, "/*", "*/");
			elements.Add(oGroupComment2);

			//Unicode'овые строковые константы
			TextStyle oStringTextStyle = this.GetStyleByName(S_STRINGS);
			BoundedElement oGroupString = new BoundedElement(oStringTextStyle, "N'", "'");
			elements.Add(oGroupString);

			//Строковые константы
			BoundedElement oGroupString2 = new BoundedElement(oStringTextStyle, "'", "'");
			elements.Add(oGroupString2);

			//Ключевые слова первого эшелона
			oStyle = this.GetStyleByName(S_KEYWORDS_1);
			FixedListElement oGroupKw1 = new FixedListElement(oStyle);
			oGroupKw1.Keywords.AddRange(new string[]
			{
				"SELECT", "CREATE", "PARTITION", "FUNCTION", "AS", "RANGE", "FOR", "VALUES", "GO",
				"SCHEME", "TO", "COLLATE", "ALTER", "NEXT", "USED", "SPLIT", "MERGE",
				"TABLE", "WITH", "ALLOW_PAGE_LOCKS", "ALLOW_ROW_LOCKS", "ON", "PRIMARY", "KEY", "CLUSTERED",
				"CHECK", "NOCHECK", "ADD", "DEFAULT", "SWITCH", "DROP", "CONSTRAINT",
				"UNIQUE", "NONCLUSTERED", "INDEX", "IF", "WHERE", "FROM",
				"BEGIN", "COMMIT", "TRANSACTION", "USE" , "SPATIAL", "COLUMNSTORE" ,
				"CONTAINS", "MEMORY_OPTIMIZED_DATA", "HASH", "BUCKET_COUNT", "MEMORY_OPTIMIZED", "DURABILITY",
				"SNAPSHOT", "NATIVE_COMPILATION", "ATOMIC"
			});
			elements.Add(oGroupKw1);

			//Дополнительные ключевые слова
			oStyle = this.GetStyleByName(S_KEYWORDS_2);
			FixedListElement oGroupKw2 = new FixedListElement(oStyle);
			oGroupKw2.Keywords.AddRange(new string[]
			{
				"RIGHT", "LEFT", "NULL", "NOT", "OR", "AND", "IS", "EXISTS"
			});
			elements.Add(oGroupKw2);

			//Дополнительные ключевые слова
			oStyle = this.GetStyleByName(S_SYS_FUNCTION);
			FixedListElement oGroupSysFuncs = new FixedListElement(oStyle);
			oGroupSysFuncs.Keywords.AddRange(new string[]
			{
				"GETDATE", "MONTH", "YEAR", "DAY", "DATEDIFF", "DATEADD", "LEN",
				"OBJECT_ID"
			});
			elements.Add(oGroupSysFuncs);
			return elements;
		}
		//=========================================================================================
		protected override Dictionary<string, TextStyle> CreateTextStyles()
		{
			var styles = base.CreateTextStyles();
			this.AddStyle(styles, new TextStyle(S_OPERATORS, Color.Teal));
			this.AddStyle(styles, new TextStyle(S_STRINGS, Color.Red));
			this.AddStyle(styles, new TextStyle(S_MULTI_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_SINGLE_COMMENT, Color.Green));
			this.AddStyle(styles, new TextStyle(S_IDENTIFIER, Color.Black));
			this.AddStyle(styles, new TextStyle(S_NUMBERS, Color.Black));
			this.AddStyle(styles, new TextStyle(S_KEYWORDS_1, Color.Blue));
			this.AddStyle(styles, new TextStyle(S_KEYWORDS_2, Color.Gray));
			this.AddStyle(styles, new TextStyle(S_SYS_FUNCTION, Color.Magenta));
			this.AddStyle(styles, new TextStyle(S_SYS_TABLES, Color.Green));
			this.AddStyle(styles, new TextStyle(S_SYS_PROC, Color.Maroon));
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
			oSpec.AddLiteral("n", 'N', 'n');
			oSpec.AddLiteral("singleQuote", '\'');
			oSpec.AddLiteral("doubleQuote", '"');
			oSpec.AddLiteral("caretReturn", '\n');
			oSpec.AddLiteral("sqBr1", '[');
			oSpec.AddLiteral("sqBr2", ']');

			oSpec.AddTokenDeclaration("id", "(n|l){l|d}");
			oSpec.AddTokenDeclaration("number", "d{d}");
			oSpec.AddTokenDeclaration("operator", "(operators|minus)");	// |asterisk
			oSpec.AddBoundedToken("stringConst", "singleQuote", "singleQuote", "singleQuote");
			oSpec.AddBoundedToken("stringConst", "n singleQuote", "singleQuote", "singleQuote");
			oSpec.AddBoundedToken("comment1", "slash asterisk", "asterisk slash", null);
			oSpec.AddBoundedToken("comment2", "minus minus", "caretReturn", null);
			oSpec.AddBoundedToken("quotedId", "sqBr1", "sqBr2", "sqBr2");
			oSpec.AddBoundedToken("quotedId2", "doubleQuote", "doubleQuote", null);

			return oSpec;
		}
		//=========================================================================================
		protected override void FillKeywordGroups(Dictionary<string, TextStyle> dictionary)
		{
			base.FillKeywordGroups(dictionary);

			//Ключевые слова первого эшелона
			TextStyle oStyle = this.GetStyleByName(S_KEYWORDS_1);
			this.LoadKeywordsToGroup(dictionary, oStyle, @"
action activation add address after aggregate alter
ansi_nulls application arithabort
as asc assembly authorization backup begin bigint binary binding bit break broker_instance
browse bulk by caller cascade case sequence start increment minvalue maxvalue cache cycle stoplist language catalog catch certificate char character check checkpoint
close clustered codepage collate search property list collection column commit committed compute
constraint contains containstable continue contract control conversation create
current current_date current_time cursor database date
datetime datetime2 dbcc deallocate dec decimal declare default definition delete deny desc
description disable disk distinct distributed double drop dummy dump else empty enable end
errlvl errorfile escape event except exec execute exit external fetch file filegroup filegrowth filename fillfactor first firstrow
float floppy for foreign formatfile forward_only forceseek forcescan freetext freetexttable from full
fulltext function go goto grant group having hierarchyid holdlock identity identity_insert
identitycol if ignore_constraints ignore_triggers image include index init initiator insert
int integer intersect into isolation key kill lastrow level lifetime lineno load login
max_queue_readers maxerrors merge message mirror_address mirrorexit money move name national
nchar next no nocheck nocount noexec noformat nonclustered none norecompute noskip notification
nounload ntext numeric nvarchar of off offset offsets on once only open opendatasource
openquery openrowset option order over out output owner ownership pad_index partition percent perm
permanent persisted pipe plan precision prepare primary print privileges proc procedure
procedure_name processexit public queue quoted_identifier raiserror read read_only readtext
real reconfigure recovery references repeatable replication restore restrict retention
return returns revoke role rollback route row rowcount rowguidcol rows rule save schema schemabinding
select self send sent serializable service service_name set setuser
shutdown single_blob single_clob single_nclob size smalldatetime
smallint smallmoney sql_variant statistics statistics_norecompute stats status
synonym sysname table take tape target temp temporary text textsize then time timestamp
tinyint to top tran transaction trigger truncate try tsequal type uncommitted
union unique uniqueidentifier update updatetext use user using valid_xml validation values varbinary
varchar varying view waitfor well_formed_xml when where while with without work
writetext xact_abort xml

allow_snapshot_isolation ansi_null_default ansi_padding ansi_warnings auto_close auto_create_statistics auto_shrink
auto_update_statistics auto_update_statistics_async bulk_logged compatibility_level concat_null_yields_null
cursor_close_on_commit cursor_default date_correlation_optimization db_chaining disable_broker enable_broker
forced global local multi_user numeric_roundabort page_verify parameterization
read_committed_snapshot recursive_triggers restricted_user simple single_user torn_page_detection trustworthy

geography, geometry, hierarchyid, date, time, datetime2, datetimeoffset
broker default_schema filestream filestream_on immediate instead password range read_write spatial columnstore allow_page_locks allow_row_locks 

memory_optimized_data hash bucket_count memory_optimized durability snapshot native_compilation atomic
");

			//Дополнительные ключевые слова
			oStyle = this.GetStyleByName(S_KEYWORDS_2);
			this.LoadKeywordsToGroup(dictionary, oStyle,
				"all and any apply between cross exists in inner is join left like matched not null or outer pivot right some source unpivot"
				);

			//Системные процедуры
			#region System procedures
			oStyle = this.GetStyleByName(S_SYS_PROC);
			this.LoadKeywordsToGroup(dictionary, oStyle,
@"sp_abort_xact sp_add_agent_parameter sp_add_agent_profile sp_add_server_sortinfo
sp_addalias sp_addapprole sp_addarticle sp_adddistpublisher sp_adddistributiondb sp_adddistributor
sp_addextendedproc sp_addextendedproperty sp_addgroup sp_addlinkedserver sp_addlinkedsrvlogin sp_addlogin
sp_addmergearticle sp_addmergefilter sp_addmergepublication  sp_addmergepullsubscription sp_addmergepullsubscription_agent
sp_addmergesubscription sp_addmessage sp_addpublication sp_addpublication_snapshot sp_addpublisher  sp_addpullsubscription
sp_addpullsubscription_agent sp_addremotelogin sp_addrole sp_addrolemember sp_addserver sp_addsrvrolemember sp_addsubscriber
sp_addsubscriber_schedule  sp_addsubscription sp_addsynctriggers sp_addtype sp_addumpdevice sp_adduser sp_altermessage
sp_approlepassword sp_article_validation sp_articlecolumn sp_articlefilter  sp_articlesynctranprocs sp_articleview
sp_attach_db sp_attach_single_file_db sp_autostats sp_bindefault sp_bindrule sp_bindsession sp_blockcnt sp_catalogs
sp_catalogs_rowset sp_certify_removable sp_change_subscription_properties sp_change_users_login sp_changearticle
sp_changedbowner sp_changedistpublisher sp_changedistributiondb  sp_changedistributor_password
sp_changedistributor_property sp_changegroup sp_changemergearticle sp_changemergefilter sp_changemergepublication
sp_changemergepullsubscription  sp_changemergesubscription sp_changeobjectowner sp_changepublication
sp_changesubscriber sp_changesubscriber_schedule sp_changesubscription sp_changesubstatus  sp_check_for_sync_trigger
sp_check_removable sp_check_removable_sysusers sp_check_sync_trigger sp_checknames sp_cleanupwebtask sp_column_privileges
sp_column_privileges_ex  sp_column_privileges_rowset sp_columns sp_columns_ex sp_columns_rowset sp_commit_xact
sp_configure sp_create_removable sp_createorphan sp_createstats sp_cursor sp_cursor_list
sp_cursorclose sp_cursorexecute sp_cursorfetch sp_cursoropen sp_cursoroption sp_cursorprepare
sp_cursorunprepare sp_databases sp_datatype_info sp_db_upgrade sp_dbcmptlevel sp_dbfixedrolepermission
sp_dboption sp_dbremove sp_ddopen sp_defaultdb sp_defaultlanguage sp_deletemergeconflictrow sp_denylogin
sp_depends sp_describe_cursor  sp_describe_cursor_columns sp_describe_cursor_tables sp_detach_db sp_diskdefault
sp_distcounters sp_drop_agent_parameter sp_drop_agent_profile sp_dropalias sp_dropapprole  sp_droparticle
sp_dropdevice sp_dropdistpublisher sp_dropdistributiondb sp_dropdistributor sp_dropextendedproc sp_dropgroup
sp_droplinkedsrvlogin sp_droplogin  sp_dropmergearticle sp_dropmergefilter sp_dropmergepublication
sp_dropmergepullsubscription sp_dropmergesubscription sp_dropmessage sp_droporphans sp_droppublication
sp_droppublisher sp_droppullsubscription sp_dropremotelogin sp_droprole sp_droprolemember sp_dropserver
sp_dropsrvrolemember sp_dropsubscriber sp_dropsubscription  sp_droptype sp_dropuser sp_dropwebtask
sp_dsninfo sp_enumcodepages sp_enumcustomresolvers sp_enumdsn sp_enumfullsubscribers sp_enumoledbdatasources
sp_execute sp_executesql  sp_fallback_MS_sel_fb_svr sp_fetchshowcmdsinput sp_fixindex sp_fkeys
sp_foreign_keys_rowset sp_foreignkeys sp_fulltext_catalog sp_fulltext_column sp_fulltext_database
sp_fulltext_getdata sp_fulltext_service sp_fulltext_table sp_generatefilters sp_get_distributor
sp_getarticlepkcolbitmap sp_getbindtoken sp_GetMBCSCharLen  sp_getmergedeletetype sp_gettypestring
sp_grant_publication_access sp_grantdbaccess sp_grantlogin sp_help sp_help_agent_default sp_help_agent_parameter
sp_help_agent_profile  sp_help_fulltext_catalogs sp_help_fulltext_catalogs_cursor sp_help_fulltext_columns
sp_help_fulltext_columns_cursor sp_help_fulltext_tables sp_help_fulltext_tables_cursor  sp_help_publication_access
sp_helpallowmerge_publication sp_helparticle sp_helparticlecolumns sp_helpconstraint sp_helpdb sp_helpdbfixedrole
sp_helpdevice sp_helpdistpublisher  sp_helpdistributiondb sp_helpdistributor sp_helpdistributor_properties
sp_helpextendedproc sp_helpfile sp_helpfilegroup sp_helpgroup sp_helpindex sp_helplanguage sp_helplog
sp_helplogins sp_helpmergearticle sp_helpmergearticleconflicts sp_helpmergeconflictrows sp_helpmergedeleteconflictrows
sp_helpmergefilter sp_helpmergepublication  sp_helpmergepullsubscription sp_helpmergesubscription sp_helpntgroup
sp_helppublication sp_helppublication_snapshot sp_helppublicationsync sp_helppullsubscription  sp_helpremotelogin
sp_helpreplicationdb sp_helpreplicationdboption sp_helpreplicationoption sp_helprole sp_helprolemember
sp_helprotect sp_helpserver sp_helpsort sp_helpsql  sp_helpsrvrole sp_helpsrvrolemember sp_helpstartup
sp_helpsubscriber sp_helpsubscriberinfo sp_helpsubscription sp_helpsubscription_properties sp_helptext
sp_helptrigger  sp_helpuser sp_indexes sp_indexes_rowset sp_indexoption sp_isarticlecolbitset sp_IsMBCSLeadByte
sp_link_publication sp_linkedservers sp_linkedservers_rowset sp_lock  sp_lockinfo sp_logdevice sp_makestartup
sp_makewebtask sp_mergedummyupdate sp_mergesubscription_cleanup sp_mergesubscriptioncleanup sp_monitor
sp_MS_marksystemobject  sp_MS_replication_installed sp_MS_upd_sysobj_category sp_MSactivate_auto_sub
sp_MSadd_distributor_alerts_and_responses sp_MSadd_mergereplcommand sp_MSadd_repl_job sp_MSaddanonymousreplica
sp_MSaddarticletocontents sp_MSaddexecarticle sp_MSaddguidcolumn sp_MSaddguidindex sp_MSaddinitialarticle
sp_MSaddinitialpublication  sp_MSaddinitialsubscription sp_MSaddlogin_implicit_ntlogin sp_MSaddmergepub_snapshot
sp_MSaddmergetriggers sp_MSaddpub_snapshot sp_MSaddpubtocontents sp_MSaddupdatetrigger  sp_MSadduser_implicit_ntlogin
sp_MSarticlecleanup sp_MSarticletextcol sp_MSbelongs sp_MSchange_priority sp_MSchangearticleresolver
sp_MScheck_agent_instance  sp_MScheck_uid_owns_anything sp_MScheckatpublisher sp_MScheckexistsgeneration
sp_MScheckmetadatamatch sp_MScleanup_subscription sp_MScleanuptask sp_MScontractsubsnb
sp_MScreate_dist_tables sp_MScreate_distributor_tables sp_MScreate_mergesystables sp_MScreate_pub_tables
sp_MScreate_replication_checkup_agent  sp_MScreate_replication_status_table sp_MScreate_sub_tables
sp_MScreateglobalreplica sp_MScreateretry sp_MSdbuseraccess sp_MSdbuserpriv sp_MSdeletecontents
sp_MSdeletepushagent sp_MSdeleteretry sp_MSdelrow sp_MSdelsubrows sp_MSdependencies sp_MSdoesfilterhaveparent
sp_MSdrop_6x_replication_agent  sp_MSdrop_distributor_alerts_and_responses sp_MSdrop_mergesystables
sp_MSdrop_object sp_MSdrop_pub_tables sp_MSdrop_replcom sp_MSdrop_repltran sp_MSdrop_rladmin
sp_MSdrop_rlcore sp_MSdrop_rlrecon sp_MSdroparticleprocs sp_MSdroparticletombstones sp_MSdroparticletriggers
sp_MSdropconstraints sp_MSdropmergepub_snapshot sp_MSdropretry  sp_MSdummyupdate sp_MSenum_replication_agents
sp_MSenum_replication_job sp_MSenum3rdpartypublications sp_MSenumallpublications sp_MSenumchanges sp_MSenumcolumns
sp_MSenumdeletesmetadata sp_MSenumgenerations sp_MSenummergepublications sp_MSenumpartialchanges sp_MSenumpartialdeletes
sp_MSenumpubreferences sp_MSenumreplicas  sp_MSenumretries sp_MSenumschemachange sp_MSenumtranpublications
sp_MSexists_file sp_MSexpandbelongs sp_MSexpandnotbelongs sp_MSexpandsubsnb sp_MSfilterclause
sp_MSflush_access_cache sp_MSflush_command sp_MSforeach_worker sp_MSforeachdb sp_MSforeachtable
sp_MSgen_sync_tran_procs sp_MSgenreplnickname sp_MSgentablenickname  sp_MSget_col_position
sp_MSget_colinfo sp_MSget_oledbinfo sp_MSget_publisher_rpc sp_MSget_qualifed_name sp_MSget_synctran_commands
sp_MSget_type sp_MSgetalertinfo  sp_MSgetchangecount sp_MSgetconflictinsertproc sp_MSgetlastrecgen
sp_MSgetlastsentgen sp_MSgetonerow sp_MSgetreplicainfo sp_MSgetreplnick sp_MSgetrowmetadata sp_MSguidtostr
sp_MShelp_distdb sp_MShelp_replication_status sp_MShelpcolumns sp_MShelpfulltextindex sp_MShelpindex
sp_MShelpmergearticles sp_MShelpobjectpublications sp_MShelptype  sp_MSIfExistsRemoteLogin sp_MSindexcolfrombin
sp_MSindexspace sp_MSinit_replication_perfmon sp_MSinsertcontents sp_MSinsertdeleteconflict sp_MSinsertgenhistory
sp_MSinsertschemachange sp_MSis_col_replicated sp_MSis_pk_col sp_MSkilldb sp_MSload_replication_status
sp_MSlocktable sp_MSloginmappings sp_MSmakearticleprocs  sp_MSmakeconflictinsertproc sp_MSmakeexpandproc
sp_MSmakegeneration sp_MSmakeinsertproc sp_MSmakejoinfilter sp_MSmakeselectproc sp_MSmakesystableviews
sp_MSmaketempinsertproc  sp_MSmakeupdateproc sp_MSmakeviewproc sp_MSmaptype sp_MSmark_proc_norepl
sp_MSmatchkey sp_MSmergepublishdb sp_MSmergesubscribedb sp_MSobjectprivs sp_MSpad_command  sp_MSproxiedmetadata
sp_MSpublicationcleanup sp_MSpublicationview sp_MSpublishdb sp_MSrefcnt sp_MSregistersubscription
sp_MSreinit_failed_subscriptions sp_MSrepl_addrolemember  sp_MSrepl_dbrole sp_MSrepl_droprolemember
sp_MSrepl_encrypt sp_MSrepl_linkedservers_rowset sp_MSrepl_startup sp_MSreplcheck_connection sp_MSreplcheck_publish
sp_MSreplcheck_pull sp_MSreplcheck_subscribe sp_MSreplicationcompatlevel sp_MSreplrole sp_MSreplsup_table_has_pk
sp_MSscript_beginproc sp_MSscript_begintrig1  sp_MSscript_begintrig2 sp_MSscript_delete_statement sp_MSscript_dri
sp_MSscript_endproc sp_MSscript_endtrig sp_MSscript_insert_statement sp_MSscript_multirow_trigger  sp_MSscript_params
sp_MSscript_security sp_MSscript_singlerow_trigger sp_MSscript_sync_del_proc sp_MSscript_sync_del_trig
sp_MSscript_sync_ins_proc sp_MSscript_sync_ins_trig  sp_MSscript_sync_upd_proc sp_MSscript_sync_upd_trig
sp_MSscript_trigger_assignment sp_MSscript_trigger_exec_rpc sp_MSscript_trigger_fetch_statement
sp_MSscript_trigger_update_checks sp_MSscript_trigger_updates sp_MSscript_trigger_variables
sp_MSscript_update_statement sp_MSscript_where_clause sp_MSscriptdatabase  sp_MSscriptdb_worker
sp_MSsetaccesslist sp_MSsetalertinfo sp_MSsetartprocs sp_MSsetbit sp_MSsetconflictscript
sp_MSsetconflicttable sp_MSsetfilteredstatus  sp_MSsetfilterparent sp_MSsetlastrecgen
sp_MSsetlastsentgen sp_MSsetreplicainfo sp_MSsetreplicastatus sp_MSsetrowmetadata
sp_MSsettopology sp_MSsetupbelongs  sp_MSSQLDMO70_version sp_MSSQLOLE_version sp_MSSQLOLE65_version sp_MSsubscribedb
sp_MSsubscriptions sp_MSsubscriptionvalidated sp_MSsubsetpublication  sp_MStable_has_unique_index sp_MStable_not_modifiable
sp_MStablechecks sp_MStablekeys sp_MStablenamefromnick sp_MStablenickname sp_MStablerefs sp_MStablespace
sp_MStestbit sp_MStextcolstatus sp_MSunc_to_drive sp_MSuniquecolname sp_MSuniquename sp_MSuniqueobjectname
sp_MSuniquetempname sp_MSunmarkreplinfo  sp_MSunregistersubscription sp_MSupdate_agenttype_default
sp_MSupdate_replication_status sp_MSupdatecontents sp_MSupdategenhistory sp_MSupdateschemachange
sp_MSupdatesysmergearticles sp_msupg_createcatalogcomputedcols sp_msupg_dosystabcatalogupgrades
sp_msupg_dropcatalogcomputedcols sp_msupg_recreatecatalogfaketables  sp_msupg_recreatesystemviews
sp_msupg_removesystemcomputedcolumns sp_msupg_upgradecatalog sp_MSuplineageversion sp_MSvalidatearticle
sp_OACreate sp_OADestroy  sp_OAGetErrorInfo sp_OAGetProperty sp_OAMethod sp_OASetProperty sp_OAStop
sp_objectfilegroup sp_oledbinfo sp_password sp_pkeys sp_prepare sp_primary_keys_rowset
sp_primarykeys sp_probe_xact sp_procedure_params_rowset sp_procedures_rowset sp_processinfo
sp_processmail sp_procoption sp_provider_types_rowset sp_publication_validation  sp_publishdb
sp_recompile sp_refreshsubscriptions sp_refreshview sp_reinitmergepullsubscription sp_reinitmergesubscription
sp_reinitpullsubscription sp_reinitsubscription  sp_remoteoption sp_remove_tempdb_file sp_remove_xact
sp_removedbreplication sp_removesrvreplication sp_rename sp_renamedb sp_replcmds sp_replcounters sp_repldone
sp_replflush sp_replica sp_replication_agent_checkup sp_replicationdboption sp_replicationoption
sp_replincrementlsn sp_replpostcmd sp_replsetoriginator sp_replshowcmds sp_replsync
sp_repltrans sp_replupdateschema sp_reset_connection sp_revoke_publication_access sp_revokedbaccess
sp_revokelogin sp_runwebtask sp_scan_xact sp_schemata_rowset  sp_script_synctran_commands sp_scriptdelproc
sp_scriptinsproc sp_scriptmappedupdproc sp_scriptpkwhereclause sp_scriptupdateparams sp_scriptupdproc
sp_sdidebug  sp_sem_start_mail sp_server_info sp_serveroption sp_setapprole sp_setnetname sp_settriggerorder
sp_spaceused sp_special_columns sp_sproc_columns sp_sqlexec sp_sqlregister sp_srvrolepermission
sp_start_xact sp_stat_xact sp_statistics sp_statistics_rowset sp_stored_procedures sp_subscribe
sp_subscription_cleanup sp_subscriptioncleanup sp_table_privileges  sp_table_privileges_ex
sp_table_privileges_rowset sp_table_validation sp_tableoption sp_tables sp_tables_ex sp_tables_info_rowset
sp_tables_rowset sp_tempdbspace  sp_unbindefault sp_unbindrule sp_unmakestartup sp_unprepare sp_unsubscribe
sp_updatestats sp_user_counter1 sp_user_counter10 sp_user_counter2 sp_user_counter3  sp_user_counter4
sp_user_counter5 sp_user_counter6 sp_user_counter7 sp_user_counter8 sp_user_counter9 sp_validatelogins
sp_validlang sp_validname sp_who sp_who2  spt_committab spt_datatype_info spt_datatype_info_ext
spt_fallback_db spt_fallback_dev spt_fallback_usg spt_monitor spt_provider_types spt_server_info
spt_values  xp_availablemedia xp_check_query_results xp_cleanupwebtask xp_cmdshell xp_deletemail
xp_dirtree xp_displayparamstmt xp_dropwebtask xp_dsninfo xp_enum_activescriptengines
xp_enum_oledb_providers xp_enumcodepages xp_enumdsn xp_enumerrorlogs xp_enumgroups xp_eventlog
xp_execresultset xp_fileexist xp_findnextmsg xp_fixeddrives  xp_get_mapi_default_profile
xp_get_mapi_profiles xp_get_tape_devices xp_getfiledetails xp_getnetname xp_grantlogin xp_initcolvs
xp_intersectbitmaps xp_load_dummy_handlers  xp_logevent xp_loginconfig xp_logininfo xp_makewebtask
xp_mergexpusage xp_msver xp_msx_enlist xp_ntsec_enumdomains xp_ntsec_enumgroups xp_ntsec_enumusers
xp_oledbinfo  xp_param_dump xp_perfend xp_perfmonitor xp_perfsample xp_perfstart xp_printstatements
xp_proxiedmetadata xp_qv xp_readerrorlog xp_readmail xp_regaddmultistring xp_regdeletekey
xp_regdeletevalue xp_regenumvalues xp_regread xp_regremovemultistring xp_regwrite
xp_revokelogin xp_runwebtask xp_sendmail xp_servicecontrol xp_showcolv xp_showlineage
xp_snmp_getstate xp_snmp_raisetrap xp_sprintf xp_sqlagent_enum_jobs xp_sqlagent_is_starting
xp_sqlagent_monitor xp_sqlagent_notify xp_sqlinventory xp_sqlmaint xp_sqlregister
xp_sqltrace xp_sscanf xp_startmail xp_stopmail xp_subdirs xp_terminate_process
xp_test_mapi_profile xp_trace_addnewqueue xp_trace_deletequeuedefinition xp_trace_destroyqueue
xp_trace_enumqueuedefname xp_trace_enumqueuehandles xp_trace_eventclassrequired xp_trace_flushqueryhistory
xp_trace_generate_event xp_trace_getappfilter  xp_trace_getconnectionidfilter xp_trace_getcpufilter
xp_trace_getdbidfilter xp_trace_getdurationfilter xp_trace_geteventfilter xp_trace_geteventnames xp_trace_getevents
xp_trace_gethostfilter xp_trace_gethpidfilter xp_trace_getindidfilter xp_trace_getntdmfilter xp_trace_getntnmfilter
xp_trace_getobjidfilter xp_trace_getqueueautostart  xp_trace_getqueuecreateinfo xp_trace_getqueuedestination
xp_trace_getqueueproperties xp_trace_getreadfilter xp_trace_getserverfilter xp_trace_getseverityfilter
xp_trace_getspidfilter xp_trace_gettextfilter xp_trace_getuserfilter xp_trace_getwritefilter xp_trace_loadqueuedefinition
xp_trace_opentracefile xp_trace_pausequeue  xp_trace_restartqueue xp_trace_savequeuedefinition xp_trace_setappfilter
xp_trace_setconnectionidfilter xp_trace_setcpufilter xp_trace_setdbidfilter xp_trace_setdurationfilter
xp_trace_seteventclassrequired xp_trace_seteventfilter xp_trace_sethostfilter xp_trace_sethpidfilter
xp_trace_setindidfilter xp_trace_setntdmfilter xp_trace_setntnmfilter  xp_trace_setobjidfilter
xp_trace_setqueryhistory xp_trace_setqueueautostart xp_trace_setqueuecreateinfo xp_trace_setqueuedestination
xp_trace_setreadfilter  xp_trace_setserverfilter xp_trace_setseverityfilter xp_trace_setspidfilter
xp_trace_settextfilter xp_trace_setuserfilter xp_trace_setwritefilter xp_trace_startconsumer
xp_trace_toeventlogconsumer xp_trace_tofileconsumer xp_unc_to_drive xp_unload_dummy_handlers
xp_updatecolvbm xp_updatelineage xp_varbintohexstr xp_writesqlinfo sp_helpprotect"
				);
			#endregion

			//Системные функции
			oStyle = this.GetStyleByName(S_SYS_FUNCTION);
			this.LoadKeywordsToGroup(dictionary, oStyle,
				@"abs acos app_name ascii asin atan atn2 avg binary_checksum cast ceiling charindex checksum checksum_agg coalesce collationproperty col_length col_name columns_updated columnproperty convert cos cot count count_big current_timestamp current_user cursor_status databaseproperty databasepropertyex datalength dateadd datediff datename datepart day db_id db_name degrees difference exp file_id file_name filegroup_id filegroup_name filegroupproperty fileproperty floor fn_helpcollations fn_listextendedproperty fn_servershareddrives fn_trace_geteventinfo fn_trace_getfilterinfo fn_trace_getinfo fn_trace_gettable fn_virtualfilestats formatmessage fulltextcatalogproperty fulltextserviceproperty getansinull getdate getutcdate grouping has_dbaccess host_id host_name  ident_current ident_incr ident_seed index_col indexkey_property indexproperty is_member is_srvrolemember isdate isnull isnumeric len log log10 lower ltrim max min month newid nullif object_id object_name objectproperty parsename patindex permissions pi power quotename radians rand replace replicate reverse round rowcount_big rtrim scope_identity serverproperty sessionproperty session_user sign sin soundex space sqare sql_variant_property sqrt stats_date stdev stdevp str stuff substring sum suser_sid suser_sname system_user tan typeproperty unicode upper user_id user_name var varp year
dense_rank error_message error_number error_severity error_state eventdata ntile rank row_number xact_state
@@connections @@cpu_busy @@cursor_rows @@datefirst @@dbts @@error @@fetch_status @@identity @@idle @@io_busy @@langid @@language @@lock_timeout @@max_connections @@max_precision @@nestlevel @@options @@packet_errors @@packet_received @@pack_sent @@patindex @@procid @@remserver @@rowcount @@servername @@servicename @@spid @@textptr @@textsize @@textvalid @@timeticks @@total_errors @@total_read @@total_write @@trancount @@version
"
				);

			//Системные таблицы
			oStyle = this.GetStyleByName(S_SYS_TABLES);
			this.LoadKeywordsToGroup(dictionary, oStyle,
@"sys columns tables deleted inserted sysallocations sysalternates sysaltfiles syscacheobjects syscharsets syscolumns syscomments sysconfigures sysconstraints syscurconfigs syscursorcolumns syscursorrefs  syscursors syscursortables sysdatabases sysdepends sysdevices sysfilegroups sysfiles sysfiles1 sysforeignkeys sysfulltextcatalogs sysindexes sysindexkeys syslanguages  syslockinfo syslocks syslogins sysmembers sysmessages sysobjects sysoledbusers sysperfinfo syspermissions sysprocesses sysprotects sysreferences sysremote_catalogs sysremote_column_privileges sysremote_columns sysremote_foreign_keys sysremote_indexes sysremote_primary_keys sysremote_provider_types sysremote_schemata sysremote_statistics sysremote_table_privileges sysremote_tables sysremote_views sysremotelogins syssegments sysservers systypes sysusers sysxlogins"
				);
		}
		//=========================================================================================
	}
}
