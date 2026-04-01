INSERT INTO silver.crm_sales_details(
	sls_ord_num ,
	sls_prd_key ,
	sls_cust_id ,
	sls_order_dt ,
	sls_ship_dt ,
	sls_due_dt ,
	sls_sales ,
	sls_quantity ,
	sls_price 
)
SELECT 
    sls_ord_num, 
    sls_prd_key, 
    sls_cust_id, 
    CASE 
        -- 1. Handle zeros or nulls
        WHEN sls_order_dt = 0 OR sls_order_dt IS NULL THEN NULL 
        -- 2. Ensure the string is exactly 8 characters (YYYYMMDD)
        WHEN LENGTH(sls_order_dt::TEXT) != 8 THEN NULL 
        -- 3. Only then perform the conversion
        ELSE TO_DATE(sls_order_dt::TEXT, 'YYYYMMDD') 
    END AS sls_order_dt, 
	CASE 
        -- 1. Handle zeros or nulls
        WHEN sls_ship_dt = 0 OR sls_ship_dt IS NULL THEN NULL 
        -- 2. Ensure the string is exactly 8 characters (YYYYMMDD)
        WHEN LENGTH(sls_ship_dt::TEXT) != 8 THEN NULL 
        -- 3. Only then perform the conversion
        ELSE TO_DATE(sls_ship_dt::TEXT, 'YYYYMMDD') 
    END AS sls_ship_dt, 
	CASE 
        -- 1. Handle zeros or nulls
        WHEN sls_due_dt = 0 OR sls_due_dt IS NULL THEN NULL 
        -- 2. Ensure the string is exactly 8 characters (YYYYMMDD)
        WHEN LENGTH(sls_due_dt::TEXT) != 8 THEN NULL 
        -- 3. Only then perform the conversion
        ELSE TO_DATE(sls_due_dt::TEXT, 'YYYYMMDD') 
    END AS sls_due_dt, 
	CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales !=sls_quantity * ABS(sls_price)
		 	THEN sls_quantity * ABS(sls_price)
		 ELSE sls_sales 
	END AS sls_sales,
	sls_quantity, 
	CASE WHEN sls_price IS NULL OR sls_price <=0
		 	THEN sls_sales / NULLIF(sls_quantity , 0)
		 ELSE sls_price
	END 
FROM bronze.crm_sales_details;
