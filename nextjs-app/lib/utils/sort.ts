import { ChannelInfo, SortType } from '@/lib/types';

export function sortChannels(channels: ChannelInfo[], sortType: SortType): ChannelInfo[] {
  const sorted = [...channels];

  switch (sortType) {
    case SortType.Subscribers:
      return sorted.sort((a, b) => b.subscribers - a.subscribers);

    case SortType.Views:
      return sorted.sort((a, b) => b.views - a.views);

    case SortType.PublishedDate:
      return sorted.sort((a, b) => {
        const dateA = a.published_at ? new Date(a.published_at).getTime() : 0;
        const dateB = b.published_at ? new Date(b.published_at).getTime() : 0;
        return dateB - dateA;
      });

    default:
      return sorted;
  }
}
