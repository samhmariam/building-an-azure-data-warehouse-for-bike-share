IF OBJECT_ID('dbo.factPayment') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.factPayment
END

CREATE EXTERNAL TABLE [dbo].[factPayment] WITH(
    LOCATION = 'factPayment',
    DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        sp.payment_id,    
        sp.rider_id,
	    sp.amount,
        dd.date_id
FROM 
	staging_payments sp
    JOIN dimDate dd ON CONVERT(VARCHAR, dd.date_id) = CONVERT(VARCHAR(8), CAST(sp.date AS DATE), 112)
);

SELECT TOP 10 * FROM dbo.factPayment;