# Commodity Trading Intelligence

**Malaysia - Palm Oil & Commodity Trading**
Use case: Commodity Trading

> Real-time CPO trading analytics for MDEX — Snowpipe Streaming ingests price feeds, ML.FORECAST predicts CPO prices, and Cortex Agent answers trading queries in natural language.

## Why Snowflake

Snowflake streams MDEX price feeds in real-time, forecasts CPO prices with ML, detects position risk anomalies, and answers trading queries in natural language — all native SQL, no external quant platform needed

- **ML.FORECAST on CPO price timeseries** - Only demo forecasting commodity prices — not demand or yields
- **Snowpipe Streaming for MDEX price feeds** - Only demo ingesting real-time exchange price data via streaming
- **ML.ANOMALY_DETECTION for position risk** - Only demo detecting anomalous trading positions — not manufacturing or IoT
- **Malaysian CPO/MDEX trading context** - Malaysia as global CPO price-setter via Bursa Malaysia Derivatives
- **100 market reports searchable** - Cortex Search on broker research, MPOB monthly data, and USDA WASDE
- **AWS Kinesis + EventBridge for trading events** - Only demo combining streaming price ingestion with event-driven margin alerts

## What is deployed

| | |
|---|---|
| Database | `MY_PALM_OIL_TRADING` |
| Service | `MY_PALM_OIL_TRADING_APP` |
| Compute pool | `SEA_DEMOS_MALAYSIA_POOL` |
| Dimension table | `RAW.MARKET_REPORTS` (20 rows) |
| Fact table | `RAW.CPO_TRADES` (250,000 rows, 90 days) |
| Curated layer | `CURATED.PERFORMANCE_SUMMARY`, `CURATED.TREND_ANALYSIS`, `CURATED.KPI_SUMMARY` |
| Currency | MYR (RM) |

Regions in play: Selangor, Johor, Penang, Sabah, Sarawak
Segments: CPO Futures, Physical Delivered, Palm Kernel Oil, Biodiesel Feedstock

Dynamic tables are created suspended and refreshed on demand:

```bash
./refresh_demo_data.sh MY_PALM_OIL_TRADING
```

## KPI cards

Every card below is served live from `CURATED.KPI_SUMMARY`. The app keeps the
original literal as a fallback, so it still renders if Snowflake is unreachable.

| Card | Value | Backed by |
|---|---|---|
| CPO Price (BMD) | `RM 3,847/MT` | average per event |
| Export Volume (MTD) | `1.8M MT` | total across Market Reports |
| Export Duty | `8%` | average per event |
| Active Contracts | `284` | total across Market Reports |
| FOB Premium | `+RM 84/MT` | average per event |
| B20 Impact | `+420K MT` | total across Market Reports |
| India Duty | `12.5%` | average per event |


## Demo flow

1. Executive Cockpit
2. Price Analytics
3. Position Risk
4. Ask AI
5. Architecture & Data

## Talking points

- **RM 2.8B** - monthly trading volume (futures + physical)
- **5,000 open positions** - across CPO futures and physical contracts
- **$42/tonne premium** - CPO futures premium vs spot price
- **3 margin calls** - triggered this month on back-month spreads
- **100 market reports** - indexed in Cortex Search
- **92% hedge effectiveness** - declining from 97% (policy minimum: 90%)
- **RM 4,280/tonne** - ML.FORECAST predicted front-month CPO settlement

## Business impact

- Bursa Malaysia Derivatives (MDEX) CPO futures traded RM 120B notional volume in 2023 (Bursa Malaysia)
- Malaysia accounts for 27% of global palm oil exports, with CPO as the benchmark pricing contract (MPOB)
- Real-time risk analytics reduces margin call events by 35% through early warning systems (McKinsey Commodities)
- AI-powered trading analytics improves hedge effectiveness by 8-15% for commodity desks (Deloitte Trading)

---
Generated from `generator/demo_specs/aws-malaysia-palm-oil-trading.json`. Do not hand-edit: run
`python3 generator/gen_repo_docs.py aws-malaysia-palm-oil-trading` instead.
