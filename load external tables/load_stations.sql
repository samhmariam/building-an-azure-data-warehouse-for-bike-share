IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'bikeshare_shplclake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [bikeshare_shplclake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://bikeshare@shplclake.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_stations (
	[station_id] VARCHAR(500),
	[name] VARCHAR(500),
	[latitude] FLOAT,
	[longitude] FLOAT
	)
	WITH (
	LOCATION = 'stations.csv',
	DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_stations
GO