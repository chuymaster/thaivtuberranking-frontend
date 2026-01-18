import Image from 'next/image';
import Link from 'next/link';
import { ChannelInfo } from '@/lib/types';
import { formatNumber, formatDate } from '@/lib/utils/format';
import { useTranslations } from 'next-intl';

interface ChannelCardProps {
  channel: ChannelInfo;
  rank: number;
}

export function ChannelCard({ channel, rank }: ChannelCardProps) {
  const t = useTranslations('channels');

  return (
    <Link href={`/channels/${channel.channel_id}`}>
      <div className="flex items-center gap-4 p-4 bg-white hover:bg-gray-50 transition-colors border-b border-gray-200">
        <div className="flex-shrink-0 text-gray-500 font-semibold w-12 text-center">
          {rank}
        </div>

        <div className="flex-shrink-0">
          <Image
            src={channel.thumbnail_icon_url}
            alt={channel.title}
            width={88}
            height={88}
            className="rounded-full"
          />
        </div>

        <div className="flex-1 min-w-0">
          <h3 className="font-semibold text-lg text-gray-900 truncate mb-1">
            {channel.title}
          </h3>

          <div className="text-sm text-gray-600 space-y-1">
            <p>
              {t('list.subscribers', { subscribers: formatNumber(channel.subscribers) })}
            </p>
            <p>
              {t('list.views', { views: formatNumber(channel.views) })}
            </p>
            <p className="text-xs text-gray-500">
              Latest: {formatDate(channel.last_published_video_at)} •
              Opened: {formatDate(channel.published_at)}
            </p>
          </div>
        </div>

        {channel.is_rebranded && (
          <div className="flex-shrink-0">
            <span className="inline-block px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded">
              Rebranded
            </span>
          </div>
        )}
      </div>
    </Link>
  );
}
