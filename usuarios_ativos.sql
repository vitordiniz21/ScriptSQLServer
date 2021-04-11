select b.text,* 
	from sys.sysprocesses a
	cross apply sys.dm_exec_sql_text(a.sql_handle) b
	where DB_NAME(b.dbid)='QSaude_Snapshot'
