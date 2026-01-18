export interface ChannelInfo {
  channel_id: string;
  title: string;
  subscribers: number;
  views: number;
  thumbnail_icon_url: string;
  published_at: string | null;
  last_published_video_at: string | null;
  description: string;
  is_rebranded: boolean;
  updated_at: number;
}

export interface ChannelChartData {
  date: string;
  subscribers: number;
  views: number;
}

export interface ChannelDetailResponse {
  channel: ChannelInfo;
  subscriber_history: ChannelChartData[];
  view_history: ChannelChartData[];
}
