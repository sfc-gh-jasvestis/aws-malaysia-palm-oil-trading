-- ============================================================================
-- 03_STAGING.SQL — Generate synthetic data for Commodity Trading Intelligence
-- Country: MALAYSIA | Currency: MYR
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA RAW;

-- Data generation scripts are demo-specific.
-- See the handcrafted SQL in the aws-malaysia-semiconductor-yield demo for
-- the full pattern: GENERATOR + UNIFORM + LATERAL for distribution,
-- Cortex Complete for text generation, engineered key demo numbers.

-- Target row counts:
-- CPO_TRADES: 100,000 rows — MDEX CPO futures trades with price, volume, and counterparty
-- POSITIONS: 5,000 rows — Open trading positions with mark-to-market and margin requirements
-- MDEX_PRICES: 50,000 rows — Tick-level CPO futures prices from Bursa Malaysia Derivatives
-- HEDGE_RECORDS: 2,000 rows — Physical-to-derivative hedge linkages and effectiveness tracking
-- MARKET_REPORTS: 100 rows — Analyst reports, MPOB monthly data, USDA WASDE, and broker research
-- COUNTERPARTIES: 200 rows — Trading counterparties with credit ratings and exposure limits
-- CPO_PRICE_HISTORY: 10,000 rows — Daily CPO settlement prices for ML.FORECAST training (10 years)
