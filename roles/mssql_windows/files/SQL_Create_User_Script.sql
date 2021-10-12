/*
    File: SQL_Create_User_Script.sql
    Author: Robert Lendler
    Date: 2018-09-28
    Purpose: 
        This script creates the 'oseries' user to be used as the default
        user for all SqlServer datbases in the Oseries 9.0 Platform Test
        Cycle.

*/

USE [master]
GO

CREATE LOGIN [oseries] WITH PASSWORD=N'oseries', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

/*  SqlServer Management Studio addes the Disable command
    tiwc is commenting it out for the initial testing
ALTER LOGIN [oseries] DISABLE
GO
*/

ALTER SERVER ROLE [sysadmin] ADD MEMBER [oseries]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [oseries]
GO