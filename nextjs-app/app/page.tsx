import { Suspense } from 'react';
import { getChannelList } from '@/lib/api/channels';
import { ChannelList } from '@/components/channels/ChannelList';
import { Pagination } from '@/components/ui/Pagination';
import { OriginType, ActivityType, SortType } from '@/lib/types';
import { applyFilters } from '@/lib/utils/filter';
import { sortChannels } from '@/lib/utils/sort';
import { paginateItems, getTotalPages, ITEMS_PER_PAGE } from '@/lib/utils/pagination';
import { getTranslations } from 'next-intl/server';

interface PageProps {
  searchParams: Promise<{
    sort?: string;
    origin?: string;
    activity?: string;
    q?: string;
    page?: string;
  }>;
}

export default async function HomePage({ searchParams }: PageProps) {
  const params = await searchParams;
  const t = await getTranslations('channels');

  // Parse URL parameters
  const sortType = (params.sort as SortType) || SortType.Subscribers;
  const originType = (params.origin as OriginType) || OriginType.OriginalOnly;
  const activityType = (params.activity as ActivityType) || ActivityType.ActiveOnly;
  const searchQuery = params.q || '';
  const currentPage = parseInt(params.page || '1', 10);

  // Fetch all channels (with ISR caching)
  const allChannels = await getChannelList();

  // Apply filters, search, and sorting
  const filteredChannels = applyFilters(allChannels, originType, activityType, searchQuery);
  const sortedChannels = sortChannels(filteredChannels, sortType);

  // Pagination
  const totalPages = getTotalPages(sortedChannels.length);
  const paginatedChannels = paginateItems(sortedChannels, currentPage);
  const startRank = (currentPage - 1) * ITEMS_PER_PAGE + 1;

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-4 px-4">
        {/* Channel Count */}
        <div className="text-sm text-gray-600 mb-4">
          {sortedChannels.length} {t('channels_count')}
        </div>

        {/* Channel List */}
        <Suspense fallback={<ChannelListSkeleton />}>
          <ChannelList
            channels={paginatedChannels}
            startRank={startRank}
          />
        </Suspense>

        {/* Pagination */}
        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          baseUrl="/"
        />
      </div>
    </div>
  );
}

function ChannelListSkeleton() {
  return (
    <div className="bg-white rounded-lg shadow-sm overflow-hidden">
      {Array.from({ length: 10 }).map((_, i) => (
        <div key={i} className="flex items-center gap-4 p-4 border-b border-gray-200 animate-pulse">
          <div className="flex-shrink-0 w-12 h-6 bg-gray-200 rounded" />
          <div className="flex-shrink-0 w-12 h-12 bg-gray-200 rounded-full" />
          <div className="flex-1 space-y-2">
            <div className="h-5 bg-gray-200 rounded w-3/4" />
            <div className="h-4 bg-gray-200 rounded w-1/2" />
          </div>
        </div>
      ))}
    </div>
  );
}
