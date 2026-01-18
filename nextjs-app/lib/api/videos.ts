import { VideoRanking, VideoRankingType } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface VideoRankingResponse {
  result: VideoRanking[];
}

export async function getVideoRankings(type: VideoRankingType): Promise<VideoRanking[]> {
  const typeMap = {
    [VideoRankingType.OneDay]: '1day',
    [VideoRankingType.ThreeDay]: '3day',
    [VideoRankingType.SevenDay]: '7day',
  };

  const res = await fetch(
    `${BASE_URL}/v2/video_ranking/${typeMap[type]}.json`,
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
