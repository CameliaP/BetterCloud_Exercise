﻿CREATE PROCEDURE [dbo].[spCustomerDelete]
	@CustomerId uniqueidentifier	
AS
IF @CustomerId IS NULL SELECT @CustomerId = NEWID() 

BEGIN TRANSACTION "Delete_Customer"
BEGIN TRY
DECLARE @AddrId int

SELECT @AddrId = AddressId 
	FROM Customer
	WHERE CustomerId = @CustomerId

DELETE FROM Customer WHERE CustomerId = @CustomerId

-- Delete Address unles some other Customer is shareing it
IF @AddrId IS NOT NULL AND NOT EXISTS (SELECT Id FROM Customer WHERE AddressId = @AddrID) 
	DELETE FROM Address WHERE Id = @AddrId	

COMMIT TRANSACTION;

END TRY
BEGIN CATCH
	-- TODO Add better error messageing 
	ROLLBACK TRANSACTION;
END CATCH 


