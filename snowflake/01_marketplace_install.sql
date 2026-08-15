-- ============================================================================
-- 01_MARKETPLACE_INSTALL.SQL — Install marketplace data for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA RAW;

-- Free listings to install from Snowflake Marketplace:
-- Install: Snowflake Public Data (Free)
--   https://app.snowflake.com/marketplace/listing/GZTSZ290BV255

-- Paid listing (mock): Refinitiv Commodity Prices
--   Real data: https://app.snowflake.com/marketplace/listing/GZT0Z4CM0T4
--   Using mock table: MDEX_PRICES
CREATE TABLE IF NOT EXISTS RAW.MDEX_PRICES (
  ID INT AUTOINCREMENT, DATA VARIANT, LOADED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Paid listing (mock): CEIC ASEAN Macro
--   Real data: https://app.snowflake.com/marketplace/listing/GZTSZRC7HPI
--   Using mock table: CPO_PRICE_HISTORY
CREATE TABLE IF NOT EXISTS RAW.CPO_PRICE_HISTORY (
  ID INT AUTOINCREMENT, DATA VARIANT, LOADED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

