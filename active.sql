-- 24082022
-- propuesta de cambio

IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'IRSA.IRIS.DES')
BEGIN
	PRINT('DB SELECCIONADA')
	USE [IRSA.IRIS.DES]
END
ELSE
BEGIN
	PRINT('LA BASE DE DATOS SOLICITADA NO EXISTE, SE USARA REEMPLAZO')
	USE [IRSA.IRIS]
END

-- ELIMINAR DEPENDENCIAS

-- DF__contact_c__activ__2A4B4B5E
-- DF__contact_c__delet__2B3F6F97

ALTER TABLE [dbo].[contact_channel_type] DROP CONSTRAINT [DF__contact_c__activ__2A4B4B5E];
GO

ALTER TABLE [dbo].[contact_channel_type] DROP CONSTRAINT [DF__contact_c__delet__2B3F6F97];
GO


-- DF__contacts__active__2E1BDC42
-- DF__contacts__delete__2F10007B

ALTER TABLE [dbo].[contacts] DROP CONSTRAINT [DF__contacts__active__2E1BDC42];
GO

ALTER TABLE [dbo].[contacts] DROP CONSTRAINT [DF__contacts__delete__2F10007B];
GO

-- DF__message__active__34C8D9D1
-- DF__message__deleted__35BCFE0A

ALTER TABLE [dbo].[message] DROP CONSTRAINT [DF__message__active__34C8D9D1];
GO

ALTER TABLE [dbo].[message] DROP CONSTRAINT [DF__message__deleted__35BCFE0A];
GO

-- DF__phone_num__activ__267ABA7A
-- DF__phone_num__delet__276EDEB3

ALTER TABLE [dbo].[phone_number] DROP CONSTRAINT [DF__phone_num__activ__267ABA7A];
GO

ALTER TABLE [dbo].[phone_number] DROP CONSTRAINT [DF__phone_num__delet__276EDEB3];
GO

-- DROP COLUMNS

ALTER TABLE PHONE_NUMBER
DROP COLUMN ACTIVE;

ALTER TABLE PHONE_NUMBER
DROP COLUMN DELETED;

ALTER TABLE CONTACTS
DROP COLUMN ACTIVE;

ALTER TABLE CONTACTS
DROP COLUMN DELETED;

ALTER TABLE CONTACT_CHANNEL_TYPE
DROP COLUMN ACTIVE;

ALTER TABLE CONTACT_CHANNEL_TYPE
DROP COLUMN DELETED;

ALTER TABLE [MESSAGE]
DROP COLUMN ACTIVE;

ALTER TABLE [MESSAGE]
DROP COLUMN DELETED;

-- AÑADIR COLUMNA NUEVA

ALTER TABLE PHONE_NUMBER
ADD [active] numeric (1,0) not null default(1);

ALTER TABLE CONTACTS
ADD [active] numeric (1,0) not null default(1);

ALTER TABLE MESSAGE
ADD [active] numeric (1,0) not null default(1);

ALTER TABLE CONTACT_CHANNEL_TYPE
ADD [active] numeric (1,0) not null default(1);