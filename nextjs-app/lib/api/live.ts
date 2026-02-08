import { LiveVideo } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface LiveVideoResponse {
  result: LiveVideo[];
}

export async function getLiveVideos(): Promise<LiveVideo[]> {
  const [liveRes, upcomingRes] = await Promise.all([
    fetch(
      `${BASE_URL}/v2/channel_data/live_videos.json`,
      {
        next: {
          revalidate: 300, // 5 minutes ISR for fresher live data
          tags: ['live-videos']
        }
      }
    ),
    fetch(
      `${BASE_URL}/v2/channel_data/upcoming_videos.json`,
      {
        next: {
          revalidate: 300,
          tags: ['upcoming-videos']
        }
      }
    )
  ]);

  const liveVideos: LiveVideo[] = liveRes.ok 
    ? (await liveRes.json() as LiveVideoResponse).result 
    : [];
  
  const upcomingVideos: LiveVideo[] = upcomingRes.ok 
    ? (await upcomingRes.json() as LiveVideoResponse).result 
    : [];

  return [...liveVideos, ...upcomingVideos];
}
