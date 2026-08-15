-- ============================================================================
-- 05_SEARCH.SQL — Cortex Search for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA SEARCH;

CREATE OR REPLACE CORTEX SEARCH SERVICE SEARCH.MARKET_INTELLIGENCE_SEARCH
  ON CONTENT
  ATTRIBUTES REPORT_SOURCE, REPORT_TYPE, COMMODITY
  WAREHOUSE = TRADING_WH
  TARGET_LAG = '1 hour'
AS (
  SELECT * FROM RAW.MARKET_REPORTS
);
