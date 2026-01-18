import { ChannelInfo, OriginType, ActivityType } from '@/lib/types';

const DAYS_TO_CONSIDER_INACTIVE = 90;

export function isChannelActive(channel: ChannelInfo): boolean {
  if (!channel.last_published_video_at) {
    return false;
  }

  const now = new Date();
  const lastPublished = new Date(channel.last_published_video_at);
  const daysDiff = Math.floor((now.getTime() - lastPublished.getTime()) / (1000 * 60 * 60 * 24));

  return daysDiff < DAYS_TO_CONSIDER_INACTIVE;
}

export function filterByOrigin(channels: ChannelInfo[], originType: OriginType): ChannelInfo[] {
  if (originType === OriginType.All) {
    return channels;
  }

  // OriginalOnly: filter out rebranded channels
  return channels.filter(channel => !channel.is_rebranded);
}

export function filterByActivity(channels: ChannelInfo[], activityType: ActivityType): ChannelInfo[] {
  if (activityType === ActivityType.All) {
    return channels;
  }

  // ActiveOnly: filter out inactive channels
  return channels.filter(channel => isChannelActive(channel));
}

export function applyFilters(
  channels: ChannelInfo[],
  originType: OriginType,
  activityType: ActivityType
): ChannelInfo[] {
  let filtered = filterByOrigin(channels, originType);
  filtered = filterByActivity(filtered, activityType);
  return filtered;
}
