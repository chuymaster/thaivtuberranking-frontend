'use client';

import { useState } from 'react';
import ReactEChartsCore from 'echarts-for-react/lib/core';
import * as echarts from 'echarts/core';
import { LineChart } from 'echarts/charts';
import {
  GridComponent,
  TooltipComponent,
  LegendComponent,
} from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';
import { ChannelChartData } from '@/lib/types';
import { formatNumber } from '@/lib/utils/format';

// Register ECharts components
echarts.use([
  LineChart,
  GridComponent,
  TooltipComponent,
  LegendComponent,
  CanvasRenderer,
]);

interface ChannelChartProps {
  chartData: ChannelChartData[];
}

type ChartMode = 'subscribers' | 'views';

export function ChannelChart({ chartData }: ChannelChartProps) {
  const [mode, setMode] = useState<ChartMode>('subscribers');

  const dataKey = mode === 'subscribers' ? 'subscribers' : 'views';
  const color = mode === 'subscribers' ? '#3b82f6' : '#10b981';

  const option = {
    tooltip: {
      trigger: 'axis',
      formatter: (params: { value: number; axisValueLabel: string }[]) => {
        const point = params[0];
        return `${point.axisValueLabel}<br/>${formatNumber(point.value)}`;
      },
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true,
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: chartData.map((d) => d.date),
      axisLabel: {
        rotate: 45,
        fontSize: 10,
      },
    },
    yAxis: {
      type: 'value',
      axisLabel: {
        formatter: (value: number) => formatNumber(value),
      },
    },
    series: [
      {
        name: mode === 'subscribers' ? 'Subscribers' : 'Views',
        type: 'line',
        smooth: true,
        data: chartData.map((d) => d[dataKey]),
        itemStyle: {
          color,
        },
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: `${color}40` },
            { offset: 1, color: `${color}00` },
          ]),
        },
      },
    ],
  };

  if (chartData.length === 0) {
    return (
      <div className="flex items-center justify-center h-64 text-gray-500">
        No chart data available
      </div>
    );
  }

  return (
    <div>
      {/* Mode Toggle */}
      <div className="flex gap-2 mb-4">
        <button
          onClick={() => setMode('subscribers')}
          className={`px-4 py-2 text-sm font-medium rounded-lg transition-colors ${
            mode === 'subscribers'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          }`}
        >
          Subscribers
        </button>
        <button
          onClick={() => setMode('views')}
          className={`px-4 py-2 text-sm font-medium rounded-lg transition-colors ${
            mode === 'views'
              ? 'bg-green-600 text-white'
              : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          }`}
        >
          Views
        </button>
      </div>

      {/* Chart */}
      <ReactEChartsCore
        echarts={echarts}
        option={option}
        style={{ height: '300px' }}
        notMerge={true}
        lazyUpdate={true}
      />
    </div>
  );
}
