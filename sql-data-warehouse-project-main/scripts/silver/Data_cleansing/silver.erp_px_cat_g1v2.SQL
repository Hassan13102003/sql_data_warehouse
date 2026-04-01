INSERT INTO silver.erp_px_cat_g1v2
( id1, cat,subcat, maintenance)
SELECT id1,
cat, 
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;

SELECT * FROM silver.erp_px_cat_g1v2 LIMIT 40;
