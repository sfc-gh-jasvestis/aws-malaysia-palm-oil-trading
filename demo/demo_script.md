# Demo Script: Commodity Trading Intelligence
## ~4-Minute Recorded Walkthrough
**Format**: Screen recording with voiceover
**Target**: Customer meeting / booth loop / social share
**Narrative**: "Snowflake streams MDEX price feeds in real-time, forecasts CPO prices with ML, detects position risk anomalies, and answers trading queries in natural language — all native SQL, no external quant platform needed"
**Demo Mode**: Open app with `?demo=true` for presenter notes

---

## Two Personas

| Persona | Role | Tool | What they care about |
|---|---|---|---|
| **Encik Rizal bin Osman** | Head of Trading | React App (SPCS) | P&L, position risk, margin calls, hedging effectiveness, market volatility |
| **Michelle Tan** | Commodity Analyst | Amazon QuickSight | Price patterns, basis risk, spread analysis, market report synthesis, competitor positioning |

---

## What's Built

| Layer | Component | Detail |
|---|---|---|
| **RAW** | 7 tables | CPO_TRADES (100000), POSITIONS (5000), MDEX_PRICES (50000), HEDGE_RECORDS (2000), MARKET_REPORTS (100), COUNTERPARTIES (200), CPO_PRICE_HISTORY (10000) |
| **CURATED** | 4 Dynamic Tables | POSITION_RISK_SUMMARY, CPO_PRICE_TIMESERIES, HEDGE_EFFECTIVENESS, TRADING_PNL |
| **ML** | ML.FORECAST + ML.ANOMALY_DETECTION | Forecasting + anomaly detection |
| **AI** | SUMMARIZE, AI_EXTRACT, AI_CLASSIFY | Classification + extraction |
| **Search** | Cortex Search | 100 documents indexed |
| **Agent** | TRADING_INTELLIGENCE_AGENT | Semantic View + Search tools |


---

## The Story

A Malaysian palm oil trading house operates on Bursa Malaysia Derivatives (MDEX), managing RM 2.8B in monthly CPO futures and physical trading volume. Three margin calls triggered this month as back-month spreads widened unexpectedly. The Head of Trading needs real-time position risk visibility, price forecasts, and instant access to market intelligence — without waiting for overnight batch reports.

---

## Script

### [0:00–0:45] EXECUTIVE COCKPIT

**Show**: Executive Cockpit tab

> "RM 2.8 billion monthly trading volume across CPO futures and physical contracts."

**Action**: Point at the RM 2.8B volume KPI

### [0:45–1:30] PRICE ANALYTICS

**Show**: Price Analytics tab

> "ML.FORECAST predicts CPO front-month settling at RM 4,280/tonne — 3.2% above current."

**Action**: Show CPO price chart with ML forecast band

### [1:30–2:15] POSITION RISK

**Show**: Position Risk tab

> "Five thousand positions, RM 340M total margin deployed. Three positions above 85% margin utilization."

**Action**: Show position risk heatmap by desk and contract month

### [2:15–3:00] ASK AI

**Show**: Ask AI tab

> "Encik Rizal asks: 'Which positions are at risk of margin call this week?'"

**Action**: Type: 'Which positions are approaching margin call?'

### [3:00–3:45] ARCHITECTURE & DATA

**Show**: Architecture & Data tab

> "Seven Snowflake capabilities, six AWS services."

**Action**: Walk through architecture diagram


---

## Key Demo Differentiators

1. **ML.FORECAST on CPO price timeseries** — Only demo forecasting commodity prices — not demand or yields
2. **Snowpipe Streaming for MDEX price feeds** — Only demo ingesting real-time exchange price data via streaming
3. **ML.ANOMALY_DETECTION for position risk** — Only demo detecting anomalous trading positions — not manufacturing or IoT
4. **Malaysian CPO/MDEX trading context** — Malaysia as global CPO price-setter via Bursa Malaysia Derivatives
5. **100 market reports searchable** — Cortex Search on broker research, MPOB monthly data, and USDA WASDE
6. **AWS Kinesis + EventBridge for trading events** — Only demo combining streaming price ingestion with event-driven margin alerts


---

## Demo Prep Checklist

### Data Verification
- [ ] `SELECT COUNT(*) FROM PALM_OIL_TRADING.RAW.CPO_TRADES` → 100000
- [ ] `SELECT COUNT(*) FROM PALM_OIL_TRADING.RAW.POSITIONS` → 5000
- [ ] `SELECT COUNT(*) FROM PALM_OIL_TRADING.RAW.MDEX_PRICES` → 50000

### ML Model Verification
- [ ] `SELECT COUNT(*) FROM PALM_OIL_TRADING.ML.CPO_PRICE_FORECAST_RESULTS` → >0
- [ ] `SELECT SUM(CASE WHEN IS_ANOMALY THEN 1 ELSE 0 END) FROM PALM_OIL_TRADING.ML.POSITION_RISK_ANOMALY_RESULTS` → >=3

### AI/Agent Verification
- [ ] `SELECT COUNT(*) FROM PALM_OIL_TRADING.AI.MARKET_REPORT_EXTRACTIONS` → 100

