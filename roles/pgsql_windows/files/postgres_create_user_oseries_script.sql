-- created by Sudhir Phadtare
-- created on 2021-03-01
-- Role: oseries
-- DROP ROLE oseries;

CREATE ROLE oseries WITH
  LOGIN
  SUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  PASSWORD 'oseries';
