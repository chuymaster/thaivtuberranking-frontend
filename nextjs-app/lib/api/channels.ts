import { ChannelInfo, ChannelChartData } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface ChannelListResponse {
  result: ChannelInfo[];
}

export interface ChannelDetailResponse {
  channel: ChannelInfo;
  subscriber_history: ChannelChartData[];
  view_history: ChannelChartData[];
}

export async function getChannelList(): Promise<ChannelInfo[]> {
  const res = await fetch(
    `${BASE_URL}/v2/channel_data/simple_list.json`,
    {
      next: {
        revalidate: 3600, // 1 hour ISR
        tags: ['channels']
      }
    }
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch channel list: ${res.status}`);
  }

  const data: ChannelListResponse = await res.json();
  return data.result;
}

interface ChannelDetailApiResponse {
  result: ChannelInfo;
}

export async function getChannelDetail(channelId: string): Promise<ChannelInfo> {
  const res = await fetch(
    `${BASE_URL}/v2/channel_data/detail/${channelId}.json`,
    {
      next: {
        revalidate: 3600, // 1 hour ISR
        tags: ['channel-detail', channelId]
      }
    }
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch channel detail: ${res.status}`);
  }

  const data: ChannelDetailApiResponse = await res.json();
  return data.result;
}

interface ChartDataPoint {
  date: string;
  views: number;
  subscribers: number;
}

interface ChannelChartApiResponse {
  result: {
    id: string;
    title: string;
    chart_data_points: ChartDataPoint[];
  };
}

export interface ChannelChartResponse {
  chartData: ChannelChartData[];
}

export async function getChannelChart(channelId: string): Promise<ChannelChartResponse> {
  const res = await fetch(
    `${BASE_URL}/v2/channel_data/chart_data/${channelId}.json`,
    {
      next: {
        revalidate: 3600, // 1 hour ISR
        tags: ['channel-chart', channelId]
      }
    }
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch channel chart: ${res.status}`);
  }

  const data: ChannelChartApiResponse = await res.json();
  
  // Transform to ChannelChartData format
  const chartData: ChannelChartData[] = data.result.chart_data_points.map(point => ({
    date: point.date,
    subscribers: point.subscribers,
    views: point.views,
  }));

  return { chartData };
}
