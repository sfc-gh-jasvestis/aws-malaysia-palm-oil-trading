-- ============================================================================
-- 07_SEMANTIC_VIEW.SQL — Semantic View for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA APP;

CREATE OR REPLACE SEMANTIC VIEW APP.TRADING_ANALYTICS
  COMMENT = 'CPO trading, position risk, and market intelligence analytics'
AS
  TABLES (
    CURATED.POSITION_RISK_SUMMARY AS position_risk_summary,CURATED.CPO_PRICE_TIMESERIES AS cpo_price_timeseries,CURATED.HEDGE_EFFECTIVENESS AS hedge_effectiveness,CURATED.TRADING_PNL AS trading_pnl
  );
