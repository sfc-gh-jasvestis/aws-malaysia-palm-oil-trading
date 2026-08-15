-- ============================================================================
-- 08_AGENT.SQL — Cortex Agent for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA APP;

CREATE OR REPLACE CORTEX AGENT APP.TRADING_INTELLIGENCE_AGENT
  COMMENT = 'Commodity Trading Intelligence AI Assistant'
  MODEL = 'claude-opus-4-8'
  TOOLS = (
    SEMANTIC_VIEW_TOOL(SEMANTIC_VIEW => 'PALM_OIL_TRADING.APP.TRADING_ANALYTICS'),    CORTEX_SEARCH_TOOL(CORTEX_SEARCH_SERVICE => 'PALM_OIL_TRADING.SEARCH.MARKET_INTELLIGENCE_SEARCH', TOOL_DESCRIPTION => 'Search documents for Palm Oil & Commodity Trading information')
  )
  SYSTEM_PROMPT = 'You are the Commodity Trading Intelligence Agent for a Malaysian palm oil trading desk operating on Bursa Malaysia Derivatives (MDEX), managing RM 2.8B monthly volume in CPO futures and physical contracts.';
