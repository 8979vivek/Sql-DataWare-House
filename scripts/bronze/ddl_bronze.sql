
-- CREATE ALL TABLE IN BRONZE LAVEL
IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_Status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);

IF OBJECT_ID (' bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE  bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id	INT,
	prd_keu	NVARCHAR(50),
	prd_nm	NVARCHAR(50),
	prd_cost	INT,
	prd_line	NVARCHAR(50),	
	prd_start_dt	DATETIME,
	prd_end_dt	DATETIME
);

IF OBJECT_ID (' crm_sales_details','U') IS NOT NULL
	DROP TABLE  crm_sales_details;
 CREATE TABLE bronze.crm_sales_details(
	sls_ord_num	NVARCHAR(50),
	sls_prd_key	NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt	INT,
	sls_due_dt	INT,
	sls_Sales	INT,
	sls_quantity INT,
	sls_price	INT
);

IF OBJECT_ID ('  bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE   bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry	NVARCHAR(50)
);

IF OBJECT_ID (' bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE   bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
	cid	NVARCHAR(50),
	bdate DATE,
	gen	NVARCHAR(50)
);

IF OBJECT_ID (' bronze.erp_px_cat_glv2','U') IS NOT NULL
	DROP TABLE   bronze.erp_px_cat_glv2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id	NVARCHAR(50),
	cat	NVARCHAR(50),
	subcat	NVARCHAR(50),
	maintenance	NVARCHAR(50)
);

 
-- Develope SQL Load Scripts
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Declare tracking variables required for duration metrics
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        
        PRINT '=============================================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '=============================================================';
        
        -------------------------------------------------------------
        -- LOADING CRM TABLES
        -------------------------------------------------------------
        PRINT '-------------------------------------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '-------------------------------------------------------------';

        -- 1. crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        
        PRINT '>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -- 2. crm_prd_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        
        PRINT '>> Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -- 3. crm_sales_details
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        
        PRINT '>> Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -------------------------------------------------------------
        -- LOADING ERP TABLES
        -------------------------------------------------------------
        PRINT '-------------------------------------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '-------------------------------------------------------------';

        -- 4. erp_loc_a101
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        
        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -- 5. erp_cust_az12
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        
        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -- 6. erp_px_cat_g1v2
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        
        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2 
        FROM 'D:\New_Folder_MySql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' 
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );
        
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        -- Final summary metrics
        SET @batch_end_time = GETDATE();
        PRINT '=============================================================';
        PRINT 'BRONZE LAYER LOAD COMPLETE SUCCESSFULLY';
        PRINT 'Total Batch Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '=============================================================';

    END TRY
    BEGIN CATCH
        PRINT '=============================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=============================================================';
    END CATCH
END;
GO
