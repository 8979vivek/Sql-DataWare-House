/* Create Database and Schema
Scripts Purpose:
  This scripts creates a new database named 'DataWarehouse' after checking if it already exisr.
  If the database exits, it is drop and recreated. Additionaly ,the scripts sets up three schemas
  within the database :'bronze','silver','gold'.

WARNING:
  Run inf this scripts will drop the entire 'DataWarehouse' databse if it exists.
  All data in the database will be permanently deleted.Proceed with caution and
  ensure you have proper backups before running this scripts.
*/

USE master;
-- Drop and recreate the 'DataWarehouse' database
IF ExiSTS(SELECT 1 FROM sys.database WHERE name='DataWarehouse'
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;


-- Create 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
-- Create Schema
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO


