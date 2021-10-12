--Log in SYSTEMDB as SYSTEM/Oseries9
--this creates the oseries databasedd

CREATE DATABASE OSERIES SYSTEM USER PASSWORD Oseries9;

#Commented By Sudhir Phadtare 12-May-2021
#CREATE DATABASE OSERIES SYSTEM USER PASSWORD Oseries8;

--start database
ALTER SYSTEM START DATABASE OSERIES;

