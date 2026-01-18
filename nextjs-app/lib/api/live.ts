import { LiveVideo } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface LiveVideoResponse {
  result: LiveVideo[];
}

export async function getLiveVideos(): Promise<LiveVideo[]> {
  const res = await fetch(
    `${BASE_URL}/v2/live/live.json`,
    {
      next: {
        revalidate: 300, // 5 minutes ISR for fresher live data
        tags: ['live-videos']
      }
    }
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch live videos: ${res.status}`);
  }

  const data: LiveVideoResponse = await res.json();
  return data.result;
}
