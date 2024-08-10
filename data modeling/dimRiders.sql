IF OBJECT_ID('dbo.dimRider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dimRider
END

CREATE EXTERNAL TABLE [dbo].[dimRider] WITH(
    LOCATION = 'dimRider',
    DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
    rider_id,
    first AS first_Name,
    last AS last_Name,
    address,
    CONVERT(DATE, birthday) AS datebirthday,
    CONVERT(DATE, account_start_date) AS account_start,
    CONVERT(DATE, account_end_date) AS account_end,
    is_member
FROM staging_riders
);

-- Verify the output
SELECT TOP 10 * FROM dbo.dimRider;