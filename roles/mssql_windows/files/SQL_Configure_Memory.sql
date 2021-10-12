EXEC sys.sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sys.sp_configure 'max server memory', 8192;
GO
RECONFIGURE;
GO
