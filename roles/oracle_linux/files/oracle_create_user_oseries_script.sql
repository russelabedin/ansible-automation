-- oracle_create_user_oseries_script.sql
-- created on 2020-01-21
--
-- Script that creates a user named 'oseries' with a password
-- of 'oseries'.
-- 
-- NOTE: 
--          tablespace 'oseries' must exist for this script to run
--          successfully.
--  
-- 

-- TO-DO:   Create a conditional check to delete the user if it exists
--          This would allow this script to 'reset' the database.
--      drop user oseries cascade;

create user oseries identified by oseries default tablespace oseries temporary tablespace TEMP; 
grant connect, resource to oseries;
GRANT CREATE TABLE to oseries;
GRANT CREATE VIEW to oseries;
grant create session TO oseries;
grant create sequence to oseries;
grant create trigger to oseries;
alter user oseries quota unlimited on oseries;
exit;
