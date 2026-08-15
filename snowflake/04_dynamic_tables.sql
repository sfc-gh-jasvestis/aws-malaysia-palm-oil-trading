-- ============================================================================
-- 04_DYNAMIC_TABLES.SQL — Curated layer for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA CURATED;

-- POSITION_RISK_SUMMARY: Real-time position risk with mark-to-market and margin utilization
-- Source: POSITIONS, MDEX_PRICES
CREATE OR REPLACE DYNAMIC TABLE CURATED.POSITION_RISK_SUMMARY
  TARGET_LAG = '5 minutes'
  WAREHOUSE = TRADING_WH
AS
SELECT * FROM RAW.POSITIONS;
-- TODO: Replace with actual join/aggregation logic per demo

-- CPO_PRICE_TIMESERIES: Daily CPO settlement prices for ML.FORECAST input
-- Source: CPO_PRICE_HISTORY, MDEX_PRICES
CREATE OR REPLACE DYNAMIC TABLE CURATED.CPO_PRICE_TIMESERIES
  TARGET_LAG = '5 minutes'
  WAREHOUSE = TRADING_WH
AS
SELECT * FROM RAW.CPO_PRICE_HISTORY;
-- TODO: Replace with actual join/aggregation logic per demo

-- HEDGE_EFFECTIVENESS: Physical-to-derivative hedge ratio and basis risk
-- Source: HEDGE_RECORDS, POSITIONS, MDEX_PRICES
CREATE OR REPLACE DYNAMIC TABLE CURATED.HEDGE_EFFECTIVENESS
  TARGET_LAG = '5 minutes'
  WAREHOUSE = TRADING_WH
AS
SELECT * FROM RAW.HEDGE_RECORDS;
-- TODO: Replace with actual join/aggregation logic per demo

-- TRADING_PNL: Daily P&L by trader, desk, and contract month
-- Source: CPO_TRADES, POSITIONS, MDEX_PRICES
CREATE OR REPLACE DYNAMIC TABLE CURATED.TRADING_PNL
  TARGET_LAG = '5 minutes'
  WAREHOUSE = TRADING_WH
AS
SELECT * FROM RAW.CPO_TRADES;
-- TODO: Replace with actual join/aggregation logic per demo

