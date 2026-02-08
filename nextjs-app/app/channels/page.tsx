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
    page?: string;
    origin?: string;
    activity?: string;
    sort?: string;
    q?: string;
  }>;
}

export async function generateMetadata() {
  const t = await getTranslations('channels');

  return {
    title: `${t('title')} - Thai VTuber Ranking`,
    description: 'Browse and discover Thai VTuber channels sorted by subscribers, views, and more',
  };
}

export default async function ChannelsPage(props: PageProps) {
  const searchParams = await props.searchParams;
  const t = await getTranslations('channels');

  // Parse URL parameters
  const page = parseInt(searchParams.page || '1', 10);
  const originType =
    searchParams.origin === 'all' ? OriginType.All : OriginType.OriginalOnly;
  const activityType =
    searchParams.activity === 'all' ? ActivityType.All : ActivityType.ActiveOnly;
  const sortType =
    (searchParams.sort as SortType) || SortType.Subscribers;
  const searchQuery = searchParams.q || '';

  // Fetch all channels (with ISR caching)
  const allChannels = await getChannelList();

  // Apply filters, search, and sorting
  const filteredChannels = applyFilters(allChannels, originType, activityType, searchQuery);
  const sortedChannels = sortChannels(filteredChannels, sortType);

  // Pagination
  const totalPages = getTotalPages(sortedChannels.length);
  const paginatedChannels = paginateItems(sortedChannels, page);
  const startRank = (page - 1) * ITEMS_PER_PAGE + 1;

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-6 px-4">
        {/* Channel Count */}
        <div className="mb-4 text-sm text-gray-600">
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
          currentPage={page}
          totalPages={totalPages}
          baseUrl="/channels"
        />
      </div>
    </div>
  );
}

function ChannelListSkeleton() {
  return (
    <div className="bg-white shadow-sm rounded-lg">
      {Array.from({ length: 10 }).map((_, i) => (
        <div
          key={i}
          className="flex items-center gap-4 p-4 border-b border-gray-200 animate-pulse"
        >
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
