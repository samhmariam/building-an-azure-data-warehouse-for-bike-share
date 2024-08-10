IF OBJECT_ID('dbo.factTrip') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.factTrip
END

CREATE EXTERNAL TABLE [dbo].[factTrip] WITH(
    LOCATION = 'factTrip',
    DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
    st.trip_id,
    st.rider_id,
    st.rideable_type,
    st.start_station_id, 
    st.end_station_id, 
    DATEDIFF(MINUTE , st.start_at, st.end_at) AS duration_in_minutes,
    DATEDIFF(YEAR, CONVERT(DATE, sr.birthday), CONVERT(DATE, st.start_at)) AS rider_age,
    start_time.date_id AS start_time_id,
    end_time.date_id AS end_time_id

FROM 
    staging_trips st
    JOIN staging_riders sr ON sr.rider_id = st.rider_id
    JOIN dimDate start_time ON start_time.date = CONVERT(DATE, st.start_at)
    JOIN dimDate end_time ON DATEDIFF(dd, 0, end_time.date) = DATEDIFF(dd, 0, CONVERT(DATE, st.end_at))
);

SELECT TOP 10 * FROM dbo.factTrip;