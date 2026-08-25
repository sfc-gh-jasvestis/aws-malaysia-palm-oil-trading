-- ============================================================================
-- 10_ALERTS_NOTIFICATIONS.SQL — Alerts for Commodity Trading Intelligence
-- ============================================================================
USE DATABASE PALM_OIL_TRADING;
USE SCHEMA APP;

-- Notification integration (email)
CREATE OR REPLACE NOTIFICATION INTEGRATION aws_malaysia_palm_oil_trading_EMAIL_INT
  TYPE = EMAIL
  ENABLED = TRUE
  ALLOWED_RECIPIENTS = ('<YOUR_EMAIL>');

-- Alert: MARGIN_CALL_ALERT
CREATE OR REPLACE ALERT APP.MARGIN_CALL_ALERT
  WAREHOUSE = TRADING_WH
  SCHEDULE = '5 MINUTE'
  COMMENT = 'Position approaching margin call threshold'
IF (EXISTS (
  SELECT 1 FROM CURATED.POSITION_RISK_SUMMARY
  WHERE 1=1 -- Condition: MARGIN_UTILIZATION > 85% for any position
))
THEN
  CALL SYSTEM$SEND_EMAIL(
    'aws_malaysia_palm_oil_trading_EMAIL_INT',
    '<YOUR_EMAIL>',
    '[ALERT] Commodity Trading Intelligence: Position approaching margin call threshold',
    'Position approaching margin call threshold'
  );

ALTER ALERT APP.MARGIN_CALL_ALERT RESUME;

-- Alert: POSITION_ANOMALY_ALERT
CREATE OR REPLACE ALERT APP.POSITION_ANOMALY_ALERT
  WAREHOUSE = TRADING_WH
  SCHEDULE = '5 MINUTE'
  COMMENT = 'Anomalous position risk detected'
IF (EXISTS (
  SELECT 1 FROM CURATED.POSITION_RISK_SUMMARY
  WHERE 1=1 -- Condition: IS_ANOMALY = TRUE for any desk
))
THEN
  CALL SYSTEM$SEND_EMAIL(
    'aws_malaysia_palm_oil_trading_EMAIL_INT',
    '<YOUR_EMAIL>',
    '[ALERT] Commodity Trading Intelligence: Anomalous position risk detected',
    'Anomalous position risk detected'
  );

ALTER ALERT APP.POSITION_ANOMALY_ALERT RESUME;

