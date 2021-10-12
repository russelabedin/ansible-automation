-- createOseriesReadyForInstall.sql
-- Robert Lendler 2016-05-17

-- creates a database to be used for the functional test env for O-Series 8.0
--		also create the BCI tables: BCCControl & BCCTransaction

CREATE DATABASE [oseries]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'oseries', FILENAME = N'E:\MSSQL\Data\oseries.mdf' , SIZE = 3072KB , FILEGROWTH = 10240KB )
 LOG ON 
( NAME = N'oseries_log', FILENAME = N'E:\MSSQL\log\oseries_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
 COLLATE Latin1_General_CS_AS
GO
ALTER DATABASE [oseries] SET COMPATIBILITY_LEVEL = 110
GO
ALTER DATABASE [oseries] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [oseries] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [oseries] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [oseries] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [oseries] SET ARITHABORT OFF 
GO
ALTER DATABASE [oseries] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [oseries] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [oseries] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [oseries] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [oseries] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [oseries] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [oseries] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [oseries] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [oseries] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [oseries] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [oseries] SET  DISABLE_BROKER 
GO
ALTER DATABASE [oseries] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [oseries] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [oseries] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [oseries] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [oseries] SET  READ_WRITE 
GO
ALTER DATABASE [oseries] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [oseries] SET  MULTI_USER 
GO
ALTER DATABASE [oseries] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [oseries] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [oseries]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [oseries] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
/**
	Create the BCCControl table
**/
USE [oseries]
GO

/****** Object:  Table [dbo].[BCCControl]    Script Date: 12/13/2016 2:13:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BCCControl](
	[batchId] [numeric](18, 0) NOT NULL,
	[batchStatus] [numeric](1, 0) NULL,
 CONSTRAINT [PK_BCCControl] PRIMARY KEY CLUSTERED 
(
	[batchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/**
	Create BCCTransaction table
**/

USE [oseries]
GO

/****** Object:  Table [dbo].[BCCTransaction]    Script Date: 12/13/2016 2:14:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BCCTransaction](
	[amountBilledToDate] [numeric](18, 3) NULL,
	[adminOriginTaxAreaId] [numeric](18, 0) NULL,
	[adminOriginSubDivision] [nvarchar](60) NULL,
	[adminOriginStreet2] [nvarchar](100) NULL,
	[adminOriginStreet] [nvarchar](100) NULL,
	[adminOriginPostalCode] [nvarchar](20) NULL,
	[adminOriginMainDivision] [nvarchar](60) NULL,
	[adminOriginLocationCode] [nvarchar](20) NULL,
	[adminOriginLocCustStatus] [nvarchar](60) NULL,
	[adminOriginCurrConversion] [numeric](18, 3) NULL,
	[adminOriginCurrUnit] [nvarchar](3) NULL,
	[adminOriginCountry] [nvarchar](60) NULL,
	[adminOriginCity] [nvarchar](60) NULL,
	[adminDestinationTaxAreaId] [numeric](18, 0) NULL,
	[adminDestinationSubDivision] [nvarchar](40) NULL,
	[adminDestinationStreet2] [nvarchar](100) NULL,
	[adminDestinationStreet] [nvarchar](100) NULL,
	[adminDestinationPostalCode] [nvarchar](20) NULL,
	[adminDestinationMainDivision] [nvarchar](60) NULL,
	[adminDestinationLocationCode] [nvarchar](20) NULL,
	[adminDestinationLocCustStatus] [nvarchar](60) NULL,
	[adminDestinationCurrConversion] [numeric](18, 3) NULL,
	[adminDestinationCurrUnit] [nvarchar](3) NULL,
	[adminDestinationCountry] [nvarchar](60) NULL,
	[adminDestinationCity] [nvarchar](60) NULL,
	[buyerRegistrationNumber] [nvarchar](40) NULL,
	[buyerRegMainDivision] [nvarchar](60) NULL,
	[buyerRegistrationCountry] [nvarchar](3) NULL,
	[buyerPhysicalPresenceInd] [numeric](1, 0) NULL,
	[batchId] [numeric](18, 0) NULL,
	[combinedRate] [numeric](10, 6) NULL,
	[customerBusinessInd] [numeric](1, 0) NULL,
	[customerRegistrationNumber] [nvarchar](40) NULL,
	[customerRegMainDivision] [nvarchar](60) NULL,
	[customerRegistrationCountry] [nvarchar](3) NULL,
	[customerPhysicalPresenceInd] [numeric](1, 0) NULL,
	[customerName] [nvarchar](40) NULL,
	[customerCode] [nvarchar](40) NULL,
	[customerClass] [nvarchar](40) NULL,
	[currencyCode] [nvarchar](40) NULL,
	[countryOfOrigin] [nvarchar](3) NULL,
	[costCenter] [numeric](18, 3) NULL,
	[cost] [numeric](18, 3) NULL,
	[companyCode] [nvarchar](40) NULL,
	[chargedTax] [numeric](18, 3) NULL,
	[chainTransactionPhase] [nvarchar](40) NULL,
	[calcBothInd] [numeric](1, 0) NULL,
	[documentNumber] [nvarchar](80) NULL,
	[documentDate] [nvarchar](10) NULL,
	[divisionCode] [nvarchar](40) NULL,
	[destinationTaxAreaId] [numeric](18, 0) NULL,
	[destinationSubDivision] [nvarchar](40) NULL,
	[destinationStreet2] [nvarchar](40) NULL,
	[destinationStreet] [nvarchar](40) NULL,
	[destinationPostalCode] [nvarchar](20) NULL,
	[destinationMainDivision] [nvarchar](60) NULL,
	[destinationLocationCode] [nvarchar](20) NULL,
	[destinationLocCustStatus] [nvarchar](60) NULL,
	[destinationCurrConversion] [numeric](18, 3) NULL,
	[destinationCurrUnit] [nvarchar](3) NULL,
	[destinationCountry] [nvarchar](60) NULL,
	[destinationCity] [nvarchar](60) NULL,
	[departmentCode] [nvarchar](40) NULL,
	[deliveryTerm] [nvarchar](3) NULL,
	[errorText] [nvarchar](2000) NULL,
	[extendedPrice] [numeric](18, 3) NULL,
	[exportId] [nvarchar](255) NULL,
	[freight] [numeric](18, 3) NULL,
	[flexibleNumericField10] [numeric](18, 6) NULL,
	[flexibleNumericField9] [numeric](18, 6) NULL,
	[flexibleNumericField8] [numeric](18, 6) NULL,
	[flexibleNumericField7] [numeric](18, 6) NULL,
	[flexibleNumericField6] [numeric](18, 6) NULL,
	[flexibleNumericField5] [numeric](18, 6) NULL,
	[flexibleNumericField4] [numeric](18, 6) NULL,
	[flexibleNumericField3] [numeric](18, 6) NULL,
	[flexibleNumericField2] [numeric](18, 6) NULL,
	[flexibleNumericField1] [numeric](18, 6) NULL,
	[flexibleDateField5] [nvarchar](10) NULL,
	[flexibleDateField4] [nvarchar](10) NULL,
	[flexibleDateField3] [nvarchar](10) NULL,
	[flexibleDateField2] [nvarchar](10) NULL,
	[flexibleDateField1] [nvarchar](10) NULL,
	[flexibleCodeField25] [nvarchar](40) NULL,
	[flexibleCodeField24] [nvarchar](40) NULL,
	[flexibleCodeField23] [nvarchar](40) NULL,
	[flexibleCodeField22] [nvarchar](40) NULL,
	[flexibleCodeField21] [nvarchar](40) NULL,
	[flexibleCodeField20] [nvarchar](40) NULL,
	[flexibleCodeField19] [nvarchar](40) NULL,
	[flexibleCodeField18] [nvarchar](40) NULL,
	[flexibleCodeField17] [nvarchar](40) NULL,
	[flexibleCodeField16] [nvarchar](40) NULL,
	[flexibleCodeField15] [nvarchar](40) NULL,
	[flexibleCodeField14] [nvarchar](40) NULL,
	[flexibleCodeField13] [nvarchar](40) NULL,
	[flexibleCodeField12] [nvarchar](40) NULL,
	[flexibleCodeField11] [nvarchar](40) NULL,
	[flexibleCodeField10] [nvarchar](40) NULL,
	[flexibleCodeField9] [nvarchar](40) NULL,
	[flexibleCodeField8] [nvarchar](40) NULL,
	[flexibleCodeField7] [nvarchar](40) NULL,
	[flexibleCodeField6] [nvarchar](40) NULL,
	[flexibleCodeField5] [nvarchar](40) NULL,
	[flexibleCodeField4] [nvarchar](40) NULL,
	[flexibleCodeField3] [nvarchar](40) NULL,
	[flexibleCodeField2] [nvarchar](40) NULL,
	[flexibleCodeField1] [nvarchar](40) NULL,
	[fairRentalValue] [numeric](18, 3) NULL,
	[fairMarketValue] [numeric](18, 3) NULL,
	[generalLedgerAccount] [nvarchar](40) NULL,
	[intrastatCommodityCode] [nvarchar](8) NULL,
	[inputTotalTax] [numeric](18, 3) NULL,
	[locationCode] [nvarchar](20) NULL,
	[lineItemNumber] [numeric](18, 0) NULL,
	[lineItemDiscountPercentage] [numeric](10, 6) NULL,
	[lineItemDiscountCategoryCode] [nvarchar](20) NULL,
	[lineItemDiscountAmount] [numeric](18, 0) NULL,
	[landedCost] [numeric](18, 3) NULL,
	[modeOfTransport] [nvarchar](2) NULL,
	[messageType] [nvarchar](40) NULL,
	[materialCode] [nvarchar](40) NULL,
	[netMassKilograms] [numeric](18, 0) NULL,
	[netBookValue] [numeric](18, 3) NULL,
	[natureOfTransaction] [nvarchar](3) NULL,
	[ownerRegMainDivision] [nvarchar](60) NULL,
	[ownerRegNumber] [nvarchar](40) NULL,
	[ownerRegCountry] [nvarchar](3) NULL,
	[ownerPhysicalPresenceInd] [numeric](1, 0) NULL,
	[originalCurrencyCode] [nvarchar](3) NULL,
	[purchaseCode] [nvarchar](40) NULL,
	[purchaseClassCode] [nvarchar](40) NULL,
	[projectNumber] [nvarchar](40) NULL,
	[productCode] [nvarchar](40) NULL,
	[productClassCode] [nvarchar](40) NULL,
	[postingDate] [nvarchar](10) NULL,
	[physicalOriginTaxAreaId] [numeric](18, 0) NULL,
	[physicalOriginSubDivision] [nvarchar](40) NULL,
	[physicalOriginStreet2] [nvarchar](100) NULL,
	[physicalOriginStreet] [nvarchar](100) NULL,
	[physicalOriginPostalCode] [nvarchar](20) NULL,
	[physicalOriginMainDivision] [nvarchar](60) NULL,
	[physicalOriginLocCode] [nvarchar](20) NULL,
	[physicalOriginLocCustStatus] [nvarchar](60) NULL,
	[physicalOriginCurrConversion] [numeric](18, 3) NULL,
	[physicalOriginCurrUnit] [nvarchar](3) NULL,
	[physicalOriginCountry] [nvarchar](60) NULL,
	[physicalOriginCity] [nvarchar](60) NULL,
	[quantity] [numeric](18, 6) NULL,
	[recoverableDate] [nvarchar](10) NULL,
	[rootException] [nvarchar](100) NULL,
	[status] [numeric](1, 0) NULL,
	[simplificationCode] [nvarchar](20) NULL,
	[sellerRegistrationNumber] [nvarchar](40) NULL,
	[sellerRegMainDivision] [nvarchar](60) NULL,
	[sellerRegistrationCountry] [nvarchar](3) NULL,
	[sellerPhysicalPresenceInd] [numeric](1, 0) NULL,
	[taxOnlyAdjustmentInd] [numeric](1, 0) NULL,
	[totalLineItemTax] [numeric](18, 3) NULL,
	[totalCountryTax] [numeric](18, 3) NULL,
	[totalMainDivisionTax] [numeric](18, 3) NULL,
	[totalSubDivisionTax] [numeric](18, 3) NULL,
	[totalCityTax] [numeric](18, 3) NULL,
	[totalDistrictTax] [numeric](18, 3) NULL,
	[taxAreaId2] [numeric](18, 0) NULL,
	[taxAreaId] [numeric](18, 0) NULL,
	[transactionType] [nvarchar](20) NULL,
	[transactionId] [nvarchar](80) NULL,
	[totalCost] [numeric](18, 3) NULL,
	[titleTransfer] [nvarchar](20) NULL,
	[taxIncludedInd] [numeric](1, 0) NULL,
	[taxDate] [nvarchar](10) NULL,
	[userDefinedLineItemSyncIdCode] [nvarchar](40) NULL,
	[usageCode] [nvarchar](40) NULL,
	[usageClassCode] [nvarchar](40) NULL,
	[unitPrice] [nvarchar](40) NULL,
	[unitOfMeasure] [numeric](18, 3) NULL,
	[volumeUnitOfMeasure] [numeric](18, 3) NULL,
	[volume] [numeric](18, 3) NULL,
	[vendorSKU] [nvarchar](40) NULL,
	[vendorRegistrationNumber] [nvarchar](40) NULL,
	[vendorRegMainDivision] [nvarchar](60) NULL,
	[vendorRegistrationCountry] [nvarchar](3) NULL,
	[vendorPhysicalPresenceInd] [numeric](1, 0) NULL,
	[vendorCode] [nvarchar](40) NULL,
	[vendorClassCode] [nvarchar](40) NULL,
	[weightUnitOfMeasure] [numeric](18, 3) NULL,
	[weight] [numeric](18, 3) NULL,
	[commodityCodeType] [nvarchar](60) NULL,
	[commodityCode] [nvarchar](40) NULL,
	[paymentDate] [nvarchar](10) NULL,
	[documentSequenceId] [nvarchar](80) NULL,
	[statisticalValue] [numeric](18, 0) NULL,
	[adminOriginExtJurisCode] [nvarchar](20) NULL,
	[adminDestinationExtJurisCode] [nvarchar](20) NULL,
	[destinationExtJurisCode] [nvarchar](20) NULL,
	[physicalOriginExtJurisCode] [nvarchar](20) NULL,
	[inputTaxIsImport1] [numeric](1, 0) NULL,
	[inputTaxIsImport2] [numeric](1, 0) NULL,
	[inputTaxIsImport3] [numeric](1, 0) NULL,
	[inputTaxTaxAreaId1] [numeric](18, 0) NULL,
	[inputTaxTaxAreaId2] [numeric](18, 0) NULL,
	[inputTaxTaxAreaId3] [numeric](18, 0) NULL,
	[inputTaxJurisdictionLevel1] [nvarchar](30) NULL,
	[inputTaxJurisdictionLevel2] [nvarchar](30) NULL,
	[inputTaxJurisdictionLevel3] [nvarchar](30) NULL,
	[inputTaxImpositionType1] [nvarchar](30) NULL,
	[inputTaxImpositionType2] [nvarchar](30) NULL,
	[inputTaxImpositionType3] [nvarchar](30) NULL,
	[inputTaxInputAmount1] [numeric](18, 3) NULL,
	[inputTaxInputAmount2] [numeric](18, 3) NULL,
	[inputTaxInputAmount3] [numeric](18, 3) NULL,
	[inputTaxBlockingOvrPct1] [numeric](18, 6) NULL,
	[inputTaxBlockingOvrPct2] [numeric](18, 6) NULL,
	[inputTaxBlockingOvrPct3] [numeric](18, 6) NULL,
	[inputTaxPartialExemptOvrPct1] [numeric](18, 6) NULL,
	[inputTaxPartialExemptOvrPct2] [numeric](18, 6) NULL,
	[inputTaxPartialExemptOvrPct3] [numeric](18, 6) NULL,
	[inputTaxStreetAddress11] [nvarchar](100) NULL,
	[inputTaxStreetAddress12] [nvarchar](100) NULL,
	[inputTaxStreetAddress13] [nvarchar](100) NULL,
	[inputTaxStreetAddress21] [nvarchar](100) NULL,
	[inputTaxStreetAddress22] [nvarchar](100) NULL,
	[inputTaxStreetAddress23] [nvarchar](100) NULL,
	[inputTaxCounty1] [nvarchar](40) NULL,
	[inputTaxCounty2] [nvarchar](40) NULL,
	[inputTaxCounty3] [nvarchar](40) NULL,
	[inputTaxCity1] [nvarchar](60) NULL,
	[inputTaxCity2] [nvarchar](60) NULL,
	[inputTaxCity3] [nvarchar](60) NULL,
	[inputTaxState1] [nvarchar](60) NULL,
	[inputTaxState2] [nvarchar](60) NULL,
	[inputTaxState3] [nvarchar](60) NULL,
	[inputTaxCountry1] [nvarchar](60) NULL,
	[inputTaxCountry2] [nvarchar](60) NULL,
	[inputTaxCountry3] [nvarchar](60) NULL,
	[inputTaxPostalCode1] [nvarchar](20) NULL,
	[inputTaxPostalCode2] [nvarchar](20) NULL,
	[inputTaxPostalCode3] [nvarchar](20) NULL,
	[billingType] [nvarchar](20) NULL,
	[orderType] [nvarchar](20) NULL,
	[documentType] [nvarchar](20) NULL,
	[statisticalValueIsoCode] [nvarchar](3) NULL,
	[supplementaryUnit] [numeric](18, 6) NULL,
	[supplementaryUnitType] [nvarchar](20) NULL,
	[exportProcedure] [nvarchar](20) NULL,
	[returnsCodeField] [nvarchar](1000) NULL,
	[returnsDateField] [nvarchar](1000) NULL,
	[returnsNumericField] [nvarchar](1000) NULL,
	[returnsIndicatorField] [nvarchar](1000) NULL,
	[taxPointDate] [nvarchar](10) NULL,
	[currencyConversionSource] [nvarchar](3) NULL,
	[currencyConversionTarget] [nvarchar](3) NULL,
	[currencyConversionFactor] [numeric](18, 3) NULL,
	[taxCatTotalCountry] [nvarchar](60) NULL,
	[taxCatTotalMainDivision] [nvarchar](60) NULL,
	[taxCatTotalSubDivision] [nvarchar](60) NULL,
	[taxCatTotalCity] [nvarchar](60) NULL,
	[taxCatTotalImpName] [nvarchar](60) NULL,
	[taxCatTotalImpUserDefined] [nvarchar](60) NULL,
	[taxCatTotalImpTypeName] [nvarchar](60) NULL,
	[taxCatTotalImpTypeUserDefined] [nvarchar](60) NULL,
	[taxCatTotalTaxCat] [nvarchar](60) NULL,
	[taxCatTotalTaxCatUserDef] [nvarchar](60) NULL,
	[taxCatTotalAmountCurrency] [nvarchar](3) NULL,
	[taxCatTotalAmount] [numeric](18, 3) NULL,
	[companyCodeCurrTaxableAmount] [numeric](18, 3) NULL,
	[companyCodeCurrTaxAmount] [numeric](18, 3) NULL,
	[companyCodeCurrencyCode] [nvarchar](3) NULL,
	[materialOrigin] [nvarchar](40) NULL,
	[specialTaxBasis] [numeric](18, 3) NULL
) ON [PRIMARY]

GO

/* Now add user to database
*/
USE oseries;
CREATE USER oseries FOR LOGIN oseries;
GO
