import { LiveVideo, LiveStatus } from '@/lib/types';
import { SafeImage } from '@/components/ui/SafeImage';
import { formatNumber } from '@/lib/utils/format';
import { useTranslations } from 'next-intl';

interface LiveCardProps {
  video: LiveVideo;
}

export function LiveCard({ video }: LiveCardProps) {
  const t = useTranslations('videos.live');
  
  const isLive = video.live_status === LiveStatus.Live;
  const isUpcoming = video.live_status === LiveStatus.Upcoming;

  const formatLiveTime = (dateString: string | null) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleString('ja-JP', {
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  return (
    <a
      href={`https://www.youtube.com/watch?v=${video.id}`}
      target="_blank"
      rel="noopener noreferrer"
      className="block"
    >
      <div className="bg-white hover:bg-gray-50 transition-colors border-b border-gray-200 p-3">
        <div className="flex gap-3">
          {/* Thumbnail */}
          <div className="flex-shrink-0 w-32 aspect-video overflow-hidden rounded relative bg-gray-200">
            <SafeImage
              src={video.thumbnail_image_url}
              alt={video.title}
              fill
              className="object-cover"
              sizes="128px"
            />
            {/* Live Badge */}
            {isLive && (
              <div className="absolute top-1 left-1 px-1.5 py-0.5 bg-red-600 text-white text-xs font-bold rounded">
                LIVE
              </div>
            )}
            {isUpcoming && (
              <div className="absolute top-1 left-1 px-1.5 py-0.5 bg-blue-600 text-white text-xs font-bold rounded">
                UPCOMING
              </div>
            )}
          </div>

          {/* Info */}
          <div className="flex-1 min-w-0">
            <h3 className="font-medium text-gray-900 line-clamp-2 text-sm mb-1">
              {video.title}
            </h3>
            
            <div className="flex items-center gap-2 mb-1">
              <SafeImage
                src={video.channel_thumbnail_image_url}
                alt={video.channel_title}
                width={20}
                height={20}
                className="rounded-full bg-gray-200"
              />
              <p className="text-xs text-gray-600 truncate">
                {video.channel_title}
              </p>
            </div>

            {isLive && video.live_concurrent_viewer_count && (
              <p className="text-xs text-red-600 font-medium">
                {t('concurrent_view', { concurrentView: formatNumber(video.live_concurrent_viewer_count) })}
              </p>
            )}

            {isUpcoming && video.live_schedule && (
              <p className="text-xs text-blue-600">
                {t('start', { liveStart: formatLiveTime(video.live_schedule) })}
              </p>
            )}
          </div>
        </div>
      </div>
    </a>
  );
}
