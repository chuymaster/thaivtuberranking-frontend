import { Suspense } from 'react';
import { getLiveVideos } from '@/lib/api/live';
import { LiveList } from '@/components/live';
import { getTranslations } from 'next-intl/server';

export default async function LivePage() {
  const t = await getTranslations('videos.tab');
  const videos = await getLiveVideos();

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-4 px-4">
        {/* Title */}
        <h1 className="text-xl font-bold text-gray-900 mb-4">
          {t('live')}
        </h1>

        {/* Live List */}
        <Suspense fallback={<LiveListSkeleton />}>
          <LiveList videos={videos} />
        </Suspense>
      </div>
    </div>
  );
}

function LiveListSkeleton() {
  return (
    <div className="bg-white rounded-lg shadow-sm overflow-hidden">
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="flex gap-3 p-3 border-b border-gray-200 animate-pulse">
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
