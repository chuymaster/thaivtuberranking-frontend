import { LiveVideo, LiveStatus } from '@/lib/types';
import { LiveCard } from './LiveCard';
import { useTranslations } from 'next-intl';

interface LiveListProps {
  videos: LiveVideo[];
}

export function LiveList({ videos }: LiveListProps) {
  const t = useTranslations('videos.list');

  // Separate live and upcoming
  const liveVideos = videos.filter(v => v.live_status === LiveStatus.Live);
  const upcomingVideos = videos.filter(v => v.live_status === LiveStatus.Upcoming);

  if (videos.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">{t('not_found')}</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Live Now */}
      {liveVideos.length > 0 && (
        <div>
          <h2 className="text-lg font-semibold text-gray-900 mb-3 flex items-center gap-2">
            <span className="w-3 h-3 bg-red-600 rounded-full animate-pulse"></span>
            Live Now ({liveVideos.length})
          </h2>
          <div className="bg-white rounded-lg shadow-sm overflow-hidden">
            {liveVideos.map((video) => (
              <LiveCard key={video.id} video={video} />
            ))}
          </div>
        </div>
      )}

      {/* Upcoming */}
      {upcomingVideos.length > 0 && (
        <div>
          <h2 className="text-lg font-semibold text-gray-900 mb-3">
            Upcoming ({upcomingVideos.length})
          </h2>
          <div className="bg-white rounded-lg shadow-sm overflow-hidden">
            {upcomingVideos.map((video) => (
              <LiveCard key={video.id} video={video} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
