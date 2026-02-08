import { VideoRanking } from '@/lib/types';
import { VideoCard } from './VideoCard';
import { useTranslations } from 'next-intl';

interface VideoListProps {
  videos: VideoRanking[];
}

export function VideoList({ videos }: VideoListProps) {
  const t = useTranslations('videos.list');

  if (videos.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">{t('not_found')}</p>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-sm overflow-hidden">
      {videos.map((video, index) => (
        <VideoCard
          key={video.id}
          video={video}
          rank={index + 1}
        />
      ))}
    </div>
  );
}
