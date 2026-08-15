-- ============================================================================
-- 11_TASK_PIPELINE.SQL — Task DAG for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA APP;

CREATE OR REPLACE TASK APP.TASK_STREAM_PRICES
  WAREHOUSE = TRADING_WH
  SCHEDULE = 'USING CRON */5 * * * * UTC'
  COMMENT = 'Process latest MDEX price feed from Snowpipe Streaming'
AS
  SELECT 1; -- Replace with actual refresh logic

CREATE OR REPLACE TASK APP.TASK_REFRESH_RISK
  WAREHOUSE = TRADING_WH
  AFTER APP.TASK_STREAM_PRICES
  COMMENT = 'Refresh position risk and margin calculations'
AS
  SELECT 1; -- Replace with actual refresh logic

CREATE OR REPLACE TASK APP.TASK_FORECAST_PRICES
  WAREHOUSE = TRADING_WH
  SCHEDULE = 'USING CRON 0 18 * * 1-5 UTC'
  COMMENT = 'Retrain CPO price forecast after market close'
AS
  SELECT 1; -- Replace with actual refresh logic

ALTER TASK APP.TASK_FORECAST_PRICES RESUME;
ALTER TASK APP.TASK_REFRESH_RISK RESUME;
ALTER TASK APP.TASK_STREAM_PRICES RESUME;
