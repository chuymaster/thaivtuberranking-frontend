import { VideoRanking } from '@/lib/types';
import { SafeImage } from '@/components/ui/SafeImage';
import { formatNumber, formatDate } from '@/lib/utils/format';

interface VideoCardProps {
  video: VideoRanking;
  rank: number;
}

export function VideoCard({ video, rank }: VideoCardProps) {
  return (
    <a
      href={`https://www.youtube.com/watch?v=${video.id}`}
      target="_blank"
      rel="noopener noreferrer"
      className="block"
    >
      <div className="flex gap-3 p-3 bg-white hover:bg-gray-50 transition-colors border-b border-gray-200">
        {/* Rank */}
        <div className="flex-shrink-0 text-gray-500 font-semibold w-8 text-center pt-1">
          {rank}
        </div>

        {/* Thumbnail */}
        <div className="flex-shrink-0 w-32 aspect-video overflow-hidden rounded relative bg-gray-200">
          <SafeImage
            src={video.thumbnail_image_url}
            alt={video.title}
            fill
            className="object-cover"
            sizes="128px"
          />
        </div>

        {/* Info */}
        <div className="flex-1 min-w-0">
          <h3 className="font-medium text-gray-900 line-clamp-2 text-sm mb-1">
            {video.title}
          </h3>
          <p className="text-xs text-gray-600 truncate mb-1">
            {video.channel_title}
          </p>
          <p className="text-xs text-gray-500">
            {formatNumber(video.view_count)} views • {formatDate(video.published_at)}
          </p>
        </div>

        {video.is_rebranded && (
          <div className="flex-shrink-0">
            <span className="inline-block px-2 py-0.5 text-xs font-medium bg-blue-100 text-blue-800 rounded">
              Rebranded
            </span>
          </div>
        )}
      </div>
    </a>
  );
}
