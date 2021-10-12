-- JFleming@   recreateoseries.sql
--drop /recreate oseries user and tablespace

-- RLendler
-- removed the double-quotes around the tablespace name oseries on line 11
-- these quotes were forcing case-sensitivity

drop user oseries cascade;

drop tablespace oseries including contents and datafiles;

CREATE BIGFILE TABLESPACE oseries DATAFILE 'E:\app\oracle\oradata\A001\oseries.dbf' SIZE 4096M REUSE LOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;


create user oseries identified by oseries default tablespace oseries temporary tablespace TEMP;
grant connect, resource to oseries;
GRANT CREATE TABLE to oseries;
GRANT CREATE VIEW to oseries;
grant create session TO oseries;
grant create sequence to oseries;
grant create trigger to oseries;

--  Edit by Robert Lendler 2016-09-22
-- adding the alter statement after a few O-Series 8.0 installs failed
alter user oseries quota unlimited on oseries;

exit;
