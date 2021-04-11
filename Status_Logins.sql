/**
       Descrição: Retorna os logins e os grupos dos mesmos
*/

select
    upper([SP].[name])                            as [Nome do Login]
   ,[SP].type_desc                                as [Tipo do Login]
   ,case [SP].is_disabled
        when 1 then 'DESABILITADO'
        when 0 then 'HABILITADO'
        else convert(varchar, [SP].is_disabled)
    end                                         as [Status]
   ,case
        when SL.sysadmin          = 1 then 'SYSADMIN'
        when SL.securityadmin     = 1 then 'SECURITYADMIN'
        when SL.serveradmin       = 1 then 'SERVERADMIN'
        when SL.setupadmin        = 1 then 'SETUPADMIN'
        when SL.processadmin      = 1 then 'PROCESSADMIN'
        when SL.diskadmin         = 1 then 'DISKADMIN'
        when SL.dbcreator         = 1 then 'DBCREATOR'
        when SL.bulkadmin         = 1 then 'BULKADMIN'
        else 'PUBLIC'
    end as [Nível de Acesso]

from
    sys.server_principals   [SP]
    left join sys.syslogins SL
        on [SP].[sid] = SL.[sid]

where
    [SP].type_desc <> 'SERVER_ROLE'

order by
    [Status]
   ,[Nível de Acesso]
   ,[Nome do Login]
 