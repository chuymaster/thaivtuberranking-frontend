import { VideoRanking, VideoRankingType } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface VideoRankingResponse {
  result: VideoRanking[];
}

export async function getVideoRankings(type: VideoRankingType): Promise<VideoRanking[]> {
  const typeMap = {
    [VideoRankingType.OneDay]: 'one_day_ranking',
    [VideoRankingType.ThreeDay]: 'three_days_ranking',
    [VideoRankingType.SevenDay]: 'seven_days_ranking',
  };

  const res = await fetch(
    `${BASE_URL}/v2/channel_data/${typeMap[type]}.json`,
    {
      next: {
        revalidate: 3600, // 1 hour ISR
        tags: ['video-rankings', type]
      }
    }
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch video rankings: ${res.status}`);
  }

  const data: VideoRankingResponse = await res.json();
  return data.result;
}
