-- oracle_create_user_oseries_script.sql
-- created on 2020-01-21
--
-- Script that creates a tablespace named 'oseries' with a password
-- of 'oseries'.
-- 

-- TO-DO:   Create a conditional check to delete the tablespace if it exists
--          This would allow this script to 'reset' the database.
-- drop tablespace oseries including contents and datafiles;

CREATE BIGFILE TABLESPACE oseries DATAFILE 'E:\app\stetester\oradata\A001\oseries.dbf' SIZE 4096M REUSE LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
