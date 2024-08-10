IF OBJECT_ID('dbo.dimStation') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dimStation
END

CREATE EXTERNAL TABLE [dbo].[dimStation] WITH(
    LOCATION = 'dimStation',
    DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        station_id,
	    name AS station_name,
	    latitude,
	    longitude
FROM 
	staging_stations
);

SELECT TOP 10 * FROM dbo.dimStation;