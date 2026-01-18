import { ChannelInfo } from '@/lib/types';
import { ChannelCard } from './ChannelCard';

interface ChannelListProps {
  channels: ChannelInfo[];
  startRank?: number;
}

export function ChannelList({ channels, startRank = 1 }: ChannelListProps) {
  return (
    <div className="bg-white shadow-sm">
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
