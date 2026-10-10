# Malaysia Palm Oil Trading Settlements

**Malaysia - Palm Oil Trading**
Use case: Buyer settlement risk and trade credit

> Receivables monitoring for 120 buyers of a fictional Malaysian palm oil trading house that ships crude palm oil, RBD olein and stearin, palm kernel oil and PFAD through 5 port cities: dynamic tables, a holdout-evaluated late-settlement classifier, a late-settlement forecast, letter-of-credit headroom anomalies and cited AI answers. Buyers, cargoes and amounts are synthetic; nothing here is a price view or trading advice.

## Why Snowflake

- **Dynamic tables** reconcile settlements due, late settlements, exposure more than 30 days overdue and payment commitments from RAW buyer data, with checks in `run_core.py`
- **Late-settlement classification** gives a holdout-evaluated next-14-day probability per buyer
- **Late-settlement forecast** projects 14 days of desk-wide late settlements with prediction intervals, for credit-desk staffing
- **Grounded AI**: the Cortex Agent (Analyst over a semantic view, plus Search over settlement playbooks) shows its SQL and playbook citations
- **Live settlements**: a native simulator (Snowflake only) or Firehose, S3 and Snowpipe (AWS build), then an alert and email

## What is built

| | |
|---|---|
| Dimension table | `RAW.COUNTERPARTIES` (120 buyers) |
| Fact table | `RAW.SETTLEMENT_DAILY` (10,800 buyer-days, 90 days) |
| Curated layer | `CURATED.KPI_SUMMARY`, `PERFORMANCE_SUMMARY`, `PRODUCT_SUMMARY`, `TREND_ANALYSIS` |
| ML | `ML.LATE_RISK_SCORES`, `ML.LATE_RISK_HOLDOUT_METRICS`, `ML.LATE_FORECAST`, `ML.LC_HEADROOM_ANOMALIES` |

Port cities: Port Klang, Pasir Gudang, Kuantan, Lahad Datu, Bintulu.
Palm products: crude palm oil, RBD palm olein, RBD palm stearin, palm kernel oil, palm fatty acid distillate.

## KPI cards (live from `CURATED.KPI_SUMMARY`; no fallback values)

| Card | Value from the seeded data |
|---|---|
| On-time Settlement Rate | 85.7% |
| Settlements Due | 1,142 |
| Late Settlements | 163 |
| Exposure >30d Overdue | 3.5% |
| Open Exposure (USD m) | 490.4 |
| Payment Commitment Rate | 44.0% |
| Counterparties | 120 |
| Document Coverage | 62.9% |
| Documents Pending | 45 |

Values are synthetic. A rebuild reproduces them because the data is HASH-seeded; dates are relative to the build day.

## Demo flow

1. Executive Cockpit: KPIs, daily settlements due against late, settlements by palm product, buyer table
2. Predictive: holdout metrics, risk bands, 14-day late-settlement forecast, LC headroom drops
3. Credit Desk: payment-commitment rate, document coverage and pending documents, internal credit score against late settlements, then generate the action memo for the Head of Trade Credit
4. Live Settlements: run `CALL APP.SIMULATE_SETTLEMENTS(20)` (Snowflake only) or `python aws/publish_settlements.py --count 20` (AWS build). Then run `EXECUTE ALERT APP.LIVE_SETTLEMENT_ALERT` and show the alert log and email.
5. Ask AI: the Cortex Agent answers metric questions through the semantic view and cites settlement playbooks from Cortex Search. The SQL is shown.
6. QuickSight (AWS build): the same Snowflake tables through DIRECT_QUERY
7. Architecture: both builds side by side

## Talking points

- About one cargo invoice in seven settles late (85.7% on time). 3.5% of open exposure is more than 30 days overdue, concentrated in a small cohort of buyers who stopped settling.
- RBD palm stearin carries the highest share of exposure more than 30 days overdue (7.9%); palm fatty acid distillate has the lowest on-time rate (81.5%). Kuantan has the lowest on-time rate of the port cities (83.0%) and Port Klang the highest (89.4%).
- LC headroom tightens before late settlements in this data, which is why the headroom trend is both a model feature and an anomaly signal.
- The risk model is evaluated on a time-based holdout: precision 0.34 and recall 0.28 at 0.5, against a 0.16 base rate. Present it as triage for the credit desk, not a credit decision.
- Buyers already more than 30 days overdue are excluded from training and evaluation, because their next late settlement is not a prediction.

## Business impact

Use only the sourced references in `README.md` (Business Impact).
