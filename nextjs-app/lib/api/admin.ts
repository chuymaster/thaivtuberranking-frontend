import { env } from '../env';
import { ChannelRequest, ChannelRequestStatus, ChannelType } from '../types/admin';

const getBaseUrl = () => {
  if (env.isProduction) {
    return 'https://us-central1-thaivtuberranking.cloudfunctions.net';
  }
  return 'https://us-central1-thaivtuberranking-dev.cloudfunctions.net';
};

export const AdminEndpoints = {
  getChannelRequestList: `${getBaseUrl()}/getChannelRequestList`,
  postChannelRequest: `${getBaseUrl()}/postChannelRequest`,
  deleteChannelRequest: `${getBaseUrl()}/deleteChannelRequest`,
  getChannelList: `${getBaseUrl()}/getChannelList`,
  postChannel: `${getBaseUrl()}/postChannel`,
  deleteChannel: `${getBaseUrl()}/deleteChannel`,
};

export async function getChannelRequests(accessToken: string): Promise<ChannelRequest[]> {
  const response = await fetch(AdminEndpoints.getChannelRequestList, {
    headers: {
      'Authorization': `Bearer ${accessToken}`,
    },
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch channel requests: ${response.status}`);
  }

  const data: ChannelRequest[] = await response.json();
  
  // Sort: unconfirmed first, then by updated_at desc
  data.sort((a, b) => {
    if (a.status === ChannelRequestStatus.Unconfirmed && b.status !== ChannelRequestStatus.Unconfirmed) {
      return -1;
    }
    if (a.status !== ChannelRequestStatus.Unconfirmed && b.status === ChannelRequestStatus.Unconfirmed) {
      return 1;
    }
    return b.updated_at - a.updated_at;
  });

  return data.slice(0, 200);
}

export async function updateChannelRequest(
  accessToken: string,
  channelId: string,
  type: ChannelType,
  status: ChannelRequestStatus
): Promise<void> {
  const formData = new URLSearchParams();
  formData.append('channel_id', channelId);
  formData.append('type', type.toString());
  formData.append('status', status.toString());

  const response = await fetch(AdminEndpoints.postChannelRequest, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    },
    body: formData.toString(),
  });

  if (!response.ok) {
    throw new Error(`Failed to update channel request: ${response.status}`);
  }
}

export async function deleteChannelRequest(
  accessToken: string,
  channelId: string
): Promise<void> {
  const formData = new URLSearchParams();
  formData.append('channel_id', channelId);

  const response = await fetch(AdminEndpoints.deleteChannelRequest, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    },
    body: formData.toString(),
  });

  if (!response.ok) {
    throw new Error(`Failed to delete channel request: ${response.status}`);
  }
}

export async function addChannel(
  accessToken: string,
  channelId: string,
  title: string,
  thumbnailImageUrl: string,
  type: ChannelType
): Promise<void> {
  const formData = new URLSearchParams();
  formData.append('channel_id', channelId);
  formData.append('title', title);
  formData.append('thumbnail_image_url', thumbnailImageUrl);
  formData.append('type', type.toString());

  const response = await fetch(AdminEndpoints.postChannel, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    },
    body: formData.toString(),
  });

  if (!response.ok) {
    throw new Error(`Failed to add channel: ${response.status}`);
  }
}
