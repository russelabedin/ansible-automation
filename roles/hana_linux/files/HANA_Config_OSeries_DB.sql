--Connect using SYSTEM/Oseries8

--Run the following system alter statements
alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','minimal_password_length')='6' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','password_layout')='' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','password_lock_time')='0' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','force_first_password_change')='false' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','maximum_invalid_connect_attempts')='1000' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','minimum_password_lifetime')='0' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','maximum_password_lifetime')='1850' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','last_used_passwords')='0' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','maximum_unused_inital_password_lifetime')='1850' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','maximum_unused_productive_password_lifetime')='365' with reconfigure;

alter system alter configuration('indexserver.ini','SYSTEM')
Set('password policy','password_expire_warning_time')='14' with reconfigure;

create role HCP_SYSTEM;

grant CONTENT_ADMIN to HCP_SYSTEM;
grant MONITORING to HCP_SYSTEM;
--call grant_activated_role('sap.hana.xs.ide.roles::Developer','HCP_SYSTEM');
grant AFL__SYS_AFL_AFLPAL_EXECUTE_WITH_GRANT_OPTION to HCP_SYSTEM;
grant Audit Admin to HCP_SYSTEM;
grant create schema to HCP_SYSTEM;
grant table Admin to HCP_SYSTEM;
grant tenant Admin to HCP_SYSTEM;
grant user Admin to HCP_SYSTEM;
grant data Admin to HCP_SYSTEM;

Create USER oseries password Oseries8;
grant HCP_SYSTEM to oseries;

