import { LiveStatus } from './enums';

export interface LiveVideo {
  id: string;
  title: string;
  channel_id: string;
  channel_title: string;
  channel_thumbnail_image_url: string;
  channel_is_rebranded: boolean;
  description: string;
  thumbnail_image_url: string;
  published_at: string;
  live_status: LiveStatus;
  live_schedule: string | null;
  live_start: string | null;
  live_end: string | null;
  live_concurrent_viewer_count: number | null;
}

export interface LiveVideoResponse {
  result: LiveVideo[];
}
