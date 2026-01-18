import { ChannelInfo } from '@/lib/types';

const BASE_URL = 'https://storage.googleapis.com/thaivtuberranking.appspot.com';

export interface ChannelListResponse {
  result: ChannelInfo[];
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

export async function getChannelDetail(channelId: string): Promise<ChannelInfo> {
  const res = await fetch(
    `${BASE_URL}/v2/channel_data/${channelId}.json`,
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

  return res.json();
}
