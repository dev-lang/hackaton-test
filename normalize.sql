-- 23-08-2022
-- propuesta de normalización

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

-- u = tabla de usuario
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='contact_number' and xtype='U')
	CREATE TABLE contact_number(
		id_contact numeric(24,0) primary key,
		id_phone_number INT NOT NULL, --referencia al id de la tabla phone_number (número de salida)
		id_contacts VARCHAR(50) NOT NULL, --relación con el contacto
		wa_contact_id VARCHAR (50) NOT NULL, --id del remitente que devuelve la API de WA
		contact_phone_number VARCHAR(50) NOT NULL,
	)
GO


ALTER TABLE [message]
	DROP CONSTRAINT FK__message__id_phon__37A5467C;
	ALTER TABLE [message]
	DROP COLUMN id_phone_number; 
	ALTER TABLE [message]
	DROP COLUMN id_contacts; 
	ALTER TABLE [message]
	DROP COLUMN wa_contact_id;
	ALTER TABLE [message]
	DROP COLUMN contact_phone_number;
	ALTER TABLE [message]
	ADD id_contact numeric(24,0) NOT NULL;

-- alterar tabla destino para agregar constraint, no la "source"
-- agrega un foreign key DESTINO_ORIGEN
-- referencia el foreign (destino) al origen (primary key)

ALTER TABLE [message]
ADD CONSTRAINT FK_message_contact_number
FOREIGN KEY (id_contact) REFERENCES contact_number(id_contact)