'use client';

import { useEffect, useState } from 'react';
import { AppLayout } from '@/components/AppLayout';
import { KPICard } from '@/components/KPICard';
import { Chart } from '@/components/Chart';
import { DataTable } from '@/components/DataTable';
import { AskAI } from '@/components/AskAI';
import { ActionMemo } from '@/components/ActionMemo';
import { GeoMap } from '@/components/GeoMap';
import { ArchitectureDiagram } from '@/components/ArchitectureDiagram';

interface DemoNarrative {
  title: string;
  duration: string;
  thesis: string;
  tabs: any[];
}

export default function HomePage() {
  const [narrative, setNarrative] = useState<DemoNarrative | null>(null);
  const [data, setData] = useState<any>(null);

  useEffect(() => {
    fetch('/demo_narrative.json')
      .then((r) => r.json())
      .then(setNarrative)
      .catch(() => {});
    fetch('/api/data')
      .then((r) => r.json())
      .then(setData)
      .catch(() => {});
  }, []);


  // KPI values come from /api/data, which reads CURATED.KPI_SUMMARY. The literal
  // stays as a fallback so the card still renders if the API is unavailable.
  const kpiVal = (title: string, fallback: string): string =>
    (data?.kpiCards as { title: string; value: string }[] | undefined)
      ?.find((k) => k.title === title)?.value ?? fallback;

  const title = narrative?.title || 'SEA AWS Demo';

  const executiveCockpit = (
    <div className="space-y-6">
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <KPICard title="CPO Price (BMD)" value={kpiVal('CPO Price (BMD)', 'RM 3,847/MT')} status="neutral" />
        <KPICard title="Export Volume (MTD)" value={kpiVal('Export Volume (MTD)', '1.8M MT')} status="neutral" />
        <KPICard title="Export Duty" value={kpiVal('Export Duty', '8%')} status="neutral" />
        <KPICard title="Active Contracts" value={kpiVal('Active Contracts', '284')} status="neutral" />
      </div>
      <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
        <div className="lg:col-span-1">
          <GeoMap
            country="malaysia"
            regions={data?.regions}
            markers={[{"label": "Kuala Lumpur", "value": "PETRONAS Tower HQ", "color": "blue", "size": "lg"}, {"label": "Johor Bahru", "value": "Refinery: 242K bpd", "color": "green", "size": "lg"}, {"label": "Kota Kinabalu", "value": "Deepwater ops", "color": "green", "size": "md"}, {"label": "Kuching", "value": "Sarawak gas", "color": "green", "size": "md"}]}
            routes={[]}
            title="Geographic Overview"
            height={400}
          />
        </div>
        <div className="lg:col-span-1 grid grid-cols-1 gap-4">
      <div className="grid grid-cols-1 gap-4 grid-cols-1">
        <Chart data={data?.timeseries || [{ period: 'Jan', value: 112 }, { period: 'Feb', value: 118 }, { period: 'Mar', value: 135 }, { period: 'Apr', value: 148 }, { period: 'May', value: 156 }, { period: 'Jun', value: 142 }, { period: 'Jul', value: 138 }, { period: 'Aug', value: 151 }, { period: 'Sep', value: 144 }, { period: 'Oct', value: 132 }, { period: 'Nov', value: 121 }, { period: 'Dec', value: 115 }]} type="line" xKey="period" yKeys={[{ key: 'value', name: 'RM/MT' }]} title="CPO Price vs Production (Weekly)" />
        <Chart data={data?.categories || [{ category: 'North', count: 82 }, { category: 'Central', count: 74 }, { category: 'South', count: 91 }, { category: 'Highland', count: 68 }, { category: 'Coastal', count: 77 }]} type="bar" xKey="category" yKeys={[{ key: 'count', name: 'MT (K)' }]} title="Export by Destination" />
      </div>
        </div>
      </div>
      <DataTable columns={[
          { key: 'id', header: '#' },
          { key: 'name', header: 'Buyer' },
          { key: 'status', header: 'Trend' },
          { key: 'value', header: 'Volume (K MT)' },
      ]} data={data?.entities || []} title="Trading Performance" />
    </div>
  );

  const domainTab1 = (
    <div className="space-y-6">
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
        <KPICard title="FOB Premium" value={kpiVal('FOB Premium', '+RM 84/MT')} />
        <KPICard title="B20 Impact" value={kpiVal('B20 Impact', '+420K MT')} />
        <KPICard title="India Duty" value={kpiVal('India Duty', '12.5%')} />
      </div>
      <Chart data={data?.detail || [{ x: 'Mon', y: 24 }, { x: 'Tue', y: 28 }, { x: 'Wed', y: 22 }, { x: 'Thu', y: 31 }, { x: 'Fri', y: 26 }, { x: 'Sat', y: 19 }, { x: 'Sun', y: 23 }]} type="area" xKey="x" yKeys={[{ key: 'y', name: 'RM/MT' }]} title="CPO Price Forecast (30-day)" height={400} />
    </div>
  );

  const domainTab2 = (
    <div className="space-y-6">
      <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
        <Chart data={data?.regionAlerts || [{ label: 'Zone North', value: 35 }, { label: 'Zone Central', value: 28 }, { label: 'Zone South', value: 22 }, { label: 'Zone East', value: 15 }]} type="pie" xKey="label" yKeys={[{ key: 'value', name: 'RM M' }]} title="Export Duty Sensitivity" />
        <ActionMemo persona={{ name: 'Ahmad Faiz Rahman', role: 'Head of Trading' }} context={{}} onGenerate={async () => ({ subject: 'Action Required', body: 'AI-generated recommendation based on current data patterns.', urgency: 'HIGH', actions: ['Lock in India price before duty revision', 'Hedge 30K MT for Q4', 'Negotiate premium for RSPO cargo'] })} />
      </div>
    </div>
  );

  const askAiTab = (
    <div className="h-[600px]">
      <AskAI title="Ask AI" mode="sql" sampleQuestions={['What is the CPO price forecast?', 'Show export duty impact vs Indonesia', 'Which markets have best margins?']} onSubmit={async (question, mode) => ({ answer: `[Demo Mode] Response to: "${question}" (${mode} mode). Connect to Snowflake for live data.`, sql: mode === 'sql' ? 'SELECT * FROM CURATED.SUMMARY LIMIT 10;' : undefined })} />
    </div>
  );

  const architectureTab = (
    <ArchitectureDiagram
      snowflakeFeatures={['Dynamic Tables (5-min refresh)', 'ML Functions (Forecast + Anomaly)', 'Cortex Search + Agent', 'Semantic View + Intelligence', 'Alerts + Notifications']}
      awsServices={[{ name: 'Amazon S3', role: 'Strategy Docs' }, { name: 'Amazon S3 + Kinesis', role: 'Integration' }, { name: 'Amazon SNS', role: 'Integration' }, { name: 'Amazon QuickSight + Q', role: 'Integration' }]}
    />
  );

  const tabs = [
    { id: 'executive-cockpit', label: 'Executive Cockpit', icon: '📊', content: executiveCockpit },
    { id: 'domain-1', label: 'Price Analytics', icon: '📈', content: domainTab1 },
    { id: 'domain-2', label: 'Trade Risk', icon: '⚡', content: domainTab2 },
    { id: 'ask-ai', label: 'Ask AI', icon: '🤖', content: askAiTab },
    { id: 'architecture', label: 'Architecture & Data', icon: '🏗️', content: architectureTab },
  ];

  return <AppLayout title={title} tabs={tabs} narrative={narrative} />;
}
