import { ChannelInfo } from '@/lib/types';
import { ChannelCard } from './ChannelCard';
import { useTranslations } from 'next-intl';

interface ChannelListProps {
  channels: ChannelInfo[];
  startRank?: number;
}

export function ChannelList({ channels, startRank = 1 }: ChannelListProps) {
  const t = useTranslations('search');

  if (channels.length === 0) {
    return (
      <div className="bg-white shadow-sm rounded-lg p-8 text-center">
        <p className="text-gray-500">{t('not_found')}</p>
      </div>
    );
  }

  return (
    <div className="bg-white shadow-sm rounded-lg overflow-hidden">
      {channels.map((channel, index) => (
        <ChannelCard
          key={channel.channel_id}
          channel={channel}
          rank={startRank + index}
        />
      ))}
    </div>
  );
}
