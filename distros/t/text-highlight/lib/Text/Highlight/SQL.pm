package Text::Highlight::SQL;
use strict;

sub syntax
{
	return {
          'key5' => {
                      'int' => 1,
                      'bit' => 1,
                      'varchar' => 1,
                      'nvarchar' => 1,
                      'money' => 1,
                      'datetime' => 1,
                      'double' => 1,
                      'float' => 1,
                      'text' => 1,
                      'smallmoney' => 1,
                      'smallint' => 1,
                      'nchar' => 1,
                      'real' => 1,
                      'varbinary' => 1,
                      'tinyint' => 1,
                      'binary' => 1,
                      'smalldatetime' => 1,
                      'image' => 1,
                      'bigint' => 1,
                      'char' => 1,
                      'numeric' => 1,
                      'decimal' => 1
                    },
          'key6' => {
                      'system' => 1,
                      'sysindexes' => 1,
                      'sysusers' => 1,
                      'systypes' => 1,
                      'sysdepends' => 1,
                      'syssegments' => 1,
                      'syscomments' => 1,
                      'syscolumns' => 1,
                      'sysconstraints' => 1,
                      'sysreferences' => 1,
                      'sysprotects' => 1,
                      'sysalternates' => 1,
                      'sysobjects' => 1
                    },
          'name' => 'ANSI_SQL',
          'case' => 0,
          'blockCommentOn' => [
                                '/*'
                              ],
          'key3' => {
                      'sp_dropdevice' => 1,
                      'sp_helplog' => 1,
                      'sp_special_columns' => 1,
                      'sp_remoteoption' => 1,
                      'sp_validlang' => 1,
                      'sp_processmail' => 1,
                      'sp_revokelogin' => 1,
                      'sp_droplogin' => 1,
                      'sp_unbindefault' => 1,
                      'sp_recompile' => 1,
                      'sp_addmessage' => 1,
                      'sp_server_info' => 1,
                      'xp_enumgroups' => 1,
                      'sp_defaultdb' => 1,
                      'sp_table_privileges' => 1,
                      'sp_stored_procedures' => 1,
                      'sp_datatype_info' => 1,
                      'sp_rename' => 1,
                      'sp_monitor' => 1,
                      'xp_logevent' => 1,
                      'sp_sproc_columns' => 1,
                      'sp_fixindex' => 1,
                      'sp_diskdefault' => 1,
                      'sp_helptext' => 1,
                      'sp_dropserver' => 1,
                      'sp_helpsort' => 1,
                      'sp_grantlogin' => 1,
                      'sp_helpuser' => 1,
                      'xp_sendmail' => 1,
                      'sp_addgroup' => 1,
                      'xp_readmail' => 1,
                      'sp_changedbowner' => 1,
                      'sp_password' => 1,
                      'sp_serveroption' => 1,
                      'sp_helpremotelogin' => 1,
                      'sp_statistics' => 1,
                      'sp_addalias' => 1,
                      'sp_dropalias' => 1,
                      'sp_defaultlanguage' => 1,
                      'sp_helpconstraint' => 1,
                      'sp_altermessage' => 1,
                      'sp_droptype' => 1,
                      'sp_addserver' => 1,
                      'sp_pkeys' => 1,
                      'sp_unbindrule' => 1,
                      'sp_checknames' => 1,
                      'xp_startmail' => 1,
                      'sp_who' => 1,
                      'xp_stopmail' => 1,
                      'sp_helprotect' => 1,
                      'sp_addremotelogin' => 1,
                      'xp_deletemail' => 1,
                      'sp_bindrule' => 1,
                      'sp_addextendedproc' => 1,
                      'sp_addlogin' => 1,
                      'sp_dropextendedproc' => 1,
                      'sp_helpdb' => 1,
                      'sp_helpdevice' => 1,
                      'sp_spaceused' => 1,
                      'sp_helplanguage' => 1,
                      'sp_addtype' => 1,
                      'sp_logdevice' => 1,
                      'sp_helpextendedproc' => 1,
                      'sp_configure' => 1,
                      'sp_fkeys' => 1,
                      'sp_helpindex' => 1,
                      'sp_adduser' => 1,
                      'sp_helpserver' => 1,
                      'sp_renamedb' => 1,
                      'sp_changegroup' => 1,
                      'sp_dropuser' => 1,
                      'sp_depends' => 1,
                      'sp_dropgroup' => 1,
                      'sp_dboption' => 1,
                      'sp_column_privileges' => 1,
                      'sp_lock' => 1,
                      'sp_who2' => 1,
                      'xp_cmdshell' => 1,
                      'sp_addumpdevice' => 1,
                      'sp_dropremotelogin' => 1,
                      'sp_tables' => 1,
                      'sp_bindefault' => 1,
                      'sp_databases' => 1,
                      'sp_columns' => 1,
                      'sp_helpgroup' => 1,
                      'xp_findnextmsg' => 1,
                      'sp_dropmessage' => 1,
                      'sp_help' => 1
                    },
          'key2' => {
                      'outer' => 1,
                      '/' => 1,
                      '=' => 1,
                      '*' => 1,
                      'not' => 1,
                      'all' => 1,
                      '-' => 1,
                      'like' => 1,
                      'or' => 1,
                      'in' => 1,
                      '.' => 1,
                      '<' => 1,
                      '!' => 1,
                      'between' => 1,
                      '||' => 1,
                      '%' => 1,
                      '>' => 1,
                      'any' => 1,
                      '+' => 1,
                      'join' => 1,
                      'null' => 1,
                      ')' => 1,
                      'some' => 1,
                      'exists' => 1,
                      'and' => 1,
                      '(' => 1
                    },
          'lineComment' => [
                             '--'
                           ],
          'delimiters' => ',()-+*/="\'!<>:.',
          'key4' => {
                      'sqrt' => 1,
                      'patindex' => 1,
                      'floor' => 1,
                      'coalesce' => 1,
                      '@@total_write' => 1,
                      'degrees' => 1,
                      'power' => 1,
                      'day' => 1,
                      'sum' => 1,
                      'atan' => 1,
                      'sign' => 1,
                      'ltrim' => 1,
                      'index_col' => 1,
                      'datalength' => 1,
                      'count' => 1,
                      'str' => 1,
                      'indexproperty' => 1,
                      'abs' => 1,
                      'dateadd' => 1,
                      '@@trancount' => 1,
                      'lower' => 1,
                      'textptr' => 1,
                      'host_name' => 1,
                      '@@cursor_rows' => 1,
                      'user_id' => 1,
                      'month' => 1,
                      'datepart' => 1,
                      'round' => 1,
                      '@@dbts' => 1,
                      '@@max_connections' => 1,
                      'case' => 1,
                      'nullif' => 1,
                      'col_length' => 1,
                      '@@cpu_busy' => 1,
                      '@@max_precision' => 1,
                      'asin' => 1,
                      'charindex' => 1,
                      'rtrim' => 1,
                      '@@nestlevel' => 1,
                      'suser_id' => 1,
                      '@@pack_sent' => 1,
                      '@@remserver' => 1,
                      'avg' => 1,
                      'host_id' => 1,
                      '@@datefirst' => 1,
                      'right' => 1,
                      'ascii' => 1,
                      'datediff' => 1,
                      'db_id' => 1,
                      'getutcdate' => 1,
                      'year' => 1,
                      'left' => 1,
                      '@@pack_received' => 1,
                      '@@idle' => 1,
                      '@@textsize' => 1,
                      'soundex' => 1,
                      '@@timeticks' => 1,
                      'textvalid' => 1,
                      'replicate' => 1,
                      '@@servicename' => 1,
                      'user' => 1,
                      'getdate' => 1,
                      '@@version' => 1,
                      'exp' => 1,
                      '@@langid' => 1,
                      'ceiling' => 1,
                      '@@procid' => 1,
                      'user_name' => 1,
                      'datename' => 1,
                      'reverse' => 1,
                      'sin' => 1,
                      'replace' => 1,
                      'stuff' => 1,
                      '@@error' => 1,
                      'tan' => 1,
                      '@@spid' => 1,
                      '@@rowcount' => 1,
                      'cast' => 1,
                      'objectproperty' => 1,
                      '@@lock_timeout' => 1,
                      '@@io_busy' => 1,
                      '@@fetch_status' => 1,
                      'cos' => 1,
                      'log10' => 1,
                      '@@language' => 1,
                      'log' => 1,
                      'object_id' => 1,
                      'pi' => 1,
                      'substring' => 1,
                      'cot' => 1,
                      'atn2' => 1,
                      'isnull' => 1,
                      '@@total_errors' => 1,
                      'suser_name' => 1,
                      'convert' => 1,
                      '@@connections' => 1,
                      'radians' => 1,
                      'upper' => 1,
                      'rand' => 1,
                      'col_name' => 1,
                      'acos' => 1,
                      'space' => 1,
                      '@@options' => 1,
                      '@@identity' => 1,
                      'object_name' => 1,
                      '@@total_read' => 1,
                      '@@servername' => 1,
                      '@@packet_errors' => 1
                    },
          'key1' => {
                      'insert' => 1,
                      'absolute' => 1,
                      'statistics' => 1,
                      'file' => 1,
                      'tsequal' => 1,
                      'print' => 1,
                      'loop' => 1,
                      'key' => 1,
                      'init' => 1,
                      'if' => 1,
                      'save' => 1,
                      'view' => 1,
                      'constraint' => 1,
                      'load' => 1,
                      'unique' => 1,
                      'relative' => 1,
                      'isolation' => 1,
                      'unload' => 1,
                      'name' => 1,
                      'clustered' => 1,
                      'open' => 1,
                      'hash' => 1,
                      'commit' => 1,
                      'prior' => 1,
                      'delete' => 1,
                      'override' => 1,
                      'privileges' => 1,
                      'cursor' => 1,
                      'time' => 1,
                      'of' => 1,
                      'mirror' => 1,
                      'rule' => 1,
                      'is' => 1,
                      'asc' => 1,
                      'procedure' => 1,
                      'when' => 1,
                      'noinit' => 1,
                      'vdevno' => 1,
                      'cascade' => 1,
                      'truncate' => 1,
                      'last' => 1,
                      'concat' => 1,
                      'dbcc' => 1,
                      'where' => 1,
                      'execute' => 1,
                      'index' => 1,
                      'char' => 1,
                      'update' => 1,
                      'checktable' => 1,
                      'remove' => 1,
                      'next' => 1,
                      'checkalloc' => 1,
                      'off' => 1,
                      'dbrepair' => 1,
                      'kill' => 1,
                      'proc' => 1,
                      'order' => 1,
                      'transaction' => 1,
                      'fetch' => 1,
                      'unmirror' => 1,
                      'noexec' => 1,
                      'escape' => 1,
                      'reconfigure' => 1,
                      'only' => 1,
                      'traceoff' => 1,
                      'returns' => 1,
                      'values' => 1,
                      'readtext' => 1,
                      'full' => 1,
                      'by' => 1,
                      'declare' => 1,
                      'nowait' => 1,
                      'columns' => 1,
                      'ignore_dup_key' => 1,
                      'checkcatalog' => 1,
                      'trigger' => 1,
                      'fillfactor' => 1,
                      'add' => 1,
                      'checkdb' => 1,
                      'drop_existing' => 1,
                      'tran' => 1,
                      'close' => 1,
                      'check' => 1,
                      'public' => 1,
                      'option' => 1,
                      'goto' => 1,
                      'select' => 1,
                      'checkpoint' => 1,
                      'while' => 1,
                      'as' => 1,
                      'fast' => 1,
                      'blocksize' => 1,
                      'serializable' => 1,
                      'percent' => 1,
                      'table' => 1,
                      'schema' => 1,
                      'writetext' => 1,
                      'on' => 1,
                      'desc' => 1,
                      'inner' => 1,
                      'traceon' => 1,
                      'distinct' => 1,
                      'truncate_only' => 1,
                      'break' => 1,
                      'waitfor' => 1,
                      'output' => 1,
                      'quoted_identifier' => 1,
                      'level' => 1,
                      'mirrorexit' => 1,
                      'top' => 1,
                      'physname' => 1,
                      'with' => 1,
                      'union' => 1,
                      'no_log' => 1,
                      'function' => 1,
                      'delay' => 1,
                      'drop' => 1,
                      'into' => 1,
                      'size' => 1,
                      'to' => 1,
                      'group' => 1,
                      'holdlock' => 1,
                      'sorted_data' => 1,
                      'references' => 1,
                      'from' => 1,
                      'set' => 1,
                      'prepare' => 1,
                      'create' => 1,
                      'stripe' => 1,
                      'vstart' => 1,
                      'work' => 1,
                      'database' => 1,
                      'identity_insert' => 1,
                      'then' => 1,
                      'parseonly' => 1,
                      'compute' => 1,
                      'nonclustered' => 1,
                      'headeronly' => 1,
                      'max' => 1,
                      'nocount' => 1,
                      'authorization' => 1,
                      'processexit' => 1,
                      'showplan' => 1,
                      'shutdown' => 1,
                      'alter' => 1,
                      'read' => 1,
                      'setuser' => 1,
                      'io' => 1,
                      'nounload' => 1,
                      'exec' => 1,
                      'offsets' => 1,
                      'dateformat' => 1,
                      'for' => 1,
                      'else' => 1,
                      'default' => 1,
                      'arithignore' => 1,
                      'end' => 1,
                      'foreign' => 1,
                      'continue' => 1,
                      'remirror' => 1,
                      'grant' => 1,
                      'browse' => 1,
                      'dump' => 1,
                      'disk' => 1,
                      'primary' => 1,
                      'rows' => 1,
                      'having' => 1,
                      'arithabort' => 1,
                      'rollback' => 1,
                      'use' => 1,
                      'merge' => 1,
                      'retaindays' => 1,
                      'at' => 1,
                      'current' => 1,
                      'revoke' => 1,
                      'begin' => 1,
                      'connect' => 1,
                      'first' => 1,
                      'recompile' => 1,
                      'min' => 1,
                      'return' => 1,
                      'deallocate' => 1
                    },
          'quot' => [
                      '\''
                    ],
          'blockCommentOff' => [
                                 '*/'
                               ],
          'continueQuote' => 1,
          'escape' => '\\'
        };
;
}

1;
