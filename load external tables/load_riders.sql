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

CREATE EXTERNAL TABLE dbo.staging_riders (
	[rider_id] INT,
	[first] VARCHAR(255),
	[last] VARCHAR(255),
	[address] VARCHAR(255),
	[birthday] VARCHAR(50),
	[account_start_date] VARCHAR(50),
	[account_end_date] VARCHAR(50),
	[is_member] BIT
	)
	WITH (
	LOCATION = 'riders.csv',
	DATA_SOURCE = [bikeshare_shplclake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_riders
GO