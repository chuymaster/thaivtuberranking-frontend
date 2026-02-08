'use client';

import { useRouter, useSearchParams, usePathname } from 'next/navigation';
import { useTranslations } from 'next-intl';
import { OriginType, ActivityType, SortType } from '@/lib/types';

interface FilterTabsProps {
  currentOrigin: OriginType;
  currentActivity: ActivityType;
  currentSort: SortType;
}

export function FilterTabs({
  currentOrigin,
  currentActivity,
  currentSort,
}: FilterTabsProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const t = useTranslations();

  const updateFilter = (key: string, value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set(key, value);
    params.delete('page'); // Reset to page 1 when filtering
    router.push(`${pathname}?${params.toString()}`);
  };

  return (
    <div className="space-y-4">
      {/* Sort Tabs */}
      <div>
        <h3 className="text-sm font-medium text-gray-500 mb-2">
          {t('channels.title')}
        </h3>
        <div className="flex gap-1 bg-gray-100 p-1 rounded-lg">
          <SortButton
            active={currentSort === SortType.Subscribers}
            onClick={() => updateFilter('sort', SortType.Subscribers)}
          >
            {t('channels.tab.subscribers')}
          </SortButton>
          <SortButton
            active={currentSort === SortType.Views}
            onClick={() => updateFilter('sort', SortType.Views)}
          >
            {t('channels.tab.views')}
          </SortButton>
          <SortButton
            active={currentSort === SortType.PublishedDate}
            onClick={() => updateFilter('sort', SortType.PublishedDate)}
          >
            {t('channels.tab.published')}
          </SortButton>
        </div>
      </div>

      {/* Origin Filter */}
      <div>
        <h3 className="text-sm font-medium text-gray-500 mb-2">
          {t('navigation.channel_type')}
        </h3>
        <div className="flex gap-2">
          <FilterChip
            active={currentOrigin === OriginType.OriginalOnly}
            onClick={() => updateFilter('origin', 'original_only')}
          >
            {t('common.type.full_vtuber')}
          </FilterChip>
          <FilterChip
            active={currentOrigin === OriginType.All}
            onClick={() => updateFilter('origin', 'all')}
          >
            {t('common.type.all_vtuber')}
          </FilterChip>
        </div>
      </div>

      {/* Activity Filter */}
      <div>
        <h3 className="text-sm font-medium text-gray-500 mb-2">
          {t('navigation.activity_type')}
        </h3>
        <div className="flex gap-2">
          <FilterChip
            active={currentActivity === ActivityType.ActiveOnly}
            onClick={() => updateFilter('activity', 'active_only')}
          >
            {t('navigation.active_only')}
          </FilterChip>
          <FilterChip
            active={currentActivity === ActivityType.All}
            onClick={() => updateFilter('activity', 'all')}
          >
            {t('navigation.active_and_inactive')}
          </FilterChip>
        </div>
      </div>
    </div>
  );
}

function SortButton({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      onClick={onClick}
      className={`flex-1 px-4 py-2 text-sm font-medium rounded-md transition-colors ${
        active
          ? 'bg-white text-blue-600 shadow-sm'
          : 'text-gray-600 hover:text-gray-900'
      }`}
    >
      {children}
    </button>
  );
}

function FilterChip({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      onClick={onClick}
      className={`px-3 py-1.5 text-sm font-medium rounded-full border transition-colors ${
        active
          ? 'bg-blue-600 text-white border-blue-600'
          : 'bg-white text-gray-700 border-gray-300 hover:border-gray-400'
      }`}
    >
      {children}
    </button>
  );
}
