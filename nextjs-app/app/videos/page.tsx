import { Suspense } from 'react';
import { getVideoRankings } from '@/lib/api/videos';
import { VideoList, VideoTabs } from '@/components/videos';
import { VideoRankingType } from '@/lib/types';
import { getTranslations } from 'next-intl/server';

interface PageProps {
  searchParams: Promise<{ type?: string }>;
}

export default async function VideosPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const t = await getTranslations('videos');
  
  // Parse type from URL, default to 1day
  const typeParam = params.type || '1day';
  const type = Object.values(VideoRankingType).includes(typeParam as VideoRankingType)
    ? (typeParam as VideoRankingType)
    : VideoRankingType.OneDay;

  const videos = await getVideoRankings(type);

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-4 px-4">
        {/* Tabs */}
        <Suspense fallback={null}>
          <VideoTabs currentType={type} />
        </Suspense>

        {/* Video Count */}
        <div className="text-sm text-gray-600 mb-4">
          {videos.length} videos
        </div>

        {/* Video List */}
        <Suspense fallback={<VideoListSkeleton />}>
          <VideoList videos={videos} />
        </Suspense>
      </div>
    </div>
  );
}

function VideoListSkeleton() {
  return (
    <div className="bg-white rounded-lg shadow-sm overflow-hidden">
      {Array.from({ length: 10 }).map((_, i) => (
        <div key={i} className="flex gap-3 p-3 border-b border-gray-200 animate-pulse">
          <div className="flex-shrink-0 w-8 h-6 bg-gray-200 rounded" />
          <div className="flex-shrink-0 w-40 aspect-video bg-gray-200 rounded" />
          <div className="flex-1 space-y-2">
            <div className="h-4 bg-gray-200 rounded w-3/4" />
            <div className="h-3 bg-gray-200 rounded w-1/2" />
            <div className="h-3 bg-gray-200 rounded w-1/3" />
          </div>
        </div>
      ))}
    </div>
  );
}
