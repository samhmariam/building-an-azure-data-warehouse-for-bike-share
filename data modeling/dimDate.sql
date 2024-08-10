IF OBJECT_ID('dbo.dimDate') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dimDate
END

CREATE EXTERNAL TABLE [dbo].[dimDate] WITH(
    LOCATION = 'dimDate',
    DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        DISTINCT(CONVERT(INT, CONVERT(VARCHAR(8), CAST(date AS DATE), 112))) AS date_id,
        CONVERT(DATE, date) AS date,
        DATEPART(DAY, CONVERT(Date, date)) AS day,
        DATEPART(MONTH, CONVERT(Date, date)) AS month, 
        DATEPART(QUARTER, CONVERT(Date,date)) AS quarter,
        DATEPART(YEAR, CONVERT(Date,date)) AS  year,
        DATEPART(WEEKDAY,CONVERT(Date,date)) AS dayOfWeek
    FROM
        dbo.staging_payments
);

SELECT TOP 10 * FROM [dbo].[dimDate];


