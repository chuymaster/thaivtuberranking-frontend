'use client';

import { useEffect } from 'react';
import { useTranslations, useLocale } from 'next-intl';
import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import { OriginType, ActivityType, SortType } from '@/lib/types';

interface DrawerMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

const localeNames: Record<string, string> = {
  th: 'ไทย',
  en: 'English',
  ja: '日本語',
};

export function DrawerMenu({ isOpen, onClose }: DrawerMenuProps) {
  const t = useTranslations('navigation');
  const tChannels = useTranslations('channels');
  const tCommon = useTranslations('common');
  const locale = useLocale();
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();

  // Get current filter values
  const currentSort = (searchParams.get('sort') as SortType) || SortType.Subscribers;
  const currentOrigin = (searchParams.get('origin') as OriginType) || OriginType.OriginalOnly;
  const currentActivity = (searchParams.get('activity') as ActivityType) || ActivityType.ActiveOnly;

  // Check if we're on a page that shows filters
  const isChannelsPage = pathname.endsWith('/channels') || pathname.match(/\/[a-z]{2}$/);

  // Close drawer on escape key
  useEffect(() => {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    
    if (isOpen) {
      document.addEventListener('keydown', handleEscape);
      document.body.style.overflow = 'hidden';
    }
    
    return () => {
      document.removeEventListener('keydown', handleEscape);
      document.body.style.overflow = '';
    };
  }, [isOpen, onClose]);

  const handleLocaleChange = (newLocale: string) => {
    const newPathname = pathname.replace(`/${locale}`, `/${newLocale}`);
    router.push(newPathname);
    onClose();
  };

  const updateFilter = (key: string, value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set(key, value);
    params.delete('page');
    router.push(`${pathname}?${params.toString()}`);
  };

  if (!isOpen) return null;

  return (
    <>
      {/* Backdrop */}
      <div
        className="fixed inset-0 z-50 bg-black/50 transition-opacity"
        onClick={onClose}
      />

      {/* Drawer */}
      <div className="fixed inset-y-0 left-0 z-50 w-72 bg-white shadow-xl transform transition-transform">
        <div className="flex flex-col h-full">
          {/* Header */}
          <div className="flex items-center justify-between p-4 border-b border-gray-200">
            <h2 className="text-lg font-semibold text-gray-900">
              {t('menu_title')}
            </h2>
            <button
              onClick={onClose}
              className="p-2 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          {/* Content */}
          <div className="flex-1 overflow-y-auto p-4">
            {/* Site Description */}
            <div className="mb-6 text-sm text-gray-600 whitespace-pre-line">
              {t('site_description')}
            </div>

            {/* Filters - only show on channels page */}
            {isChannelsPage && (
              <div className="mb-6 space-y-4">
                <div className="pt-4 border-t border-gray-200">
                  <h3 className="text-sm font-medium text-gray-700 mb-2">
                    {tChannels('title')}
                  </h3>
                  <div className="flex flex-wrap gap-2">
                    <FilterChip
                      active={currentSort === SortType.Subscribers}
                      onClick={() => updateFilter('sort', SortType.Subscribers)}
                    >
                      {tChannels('tab.subscribers')}
                    </FilterChip>
                    <FilterChip
                      active={currentSort === SortType.Views}
                      onClick={() => updateFilter('sort', SortType.Views)}
                    >
                      {tChannels('tab.views')}
                    </FilterChip>
                    <FilterChip
                      active={currentSort === SortType.PublishedDate}
                      onClick={() => updateFilter('sort', SortType.PublishedDate)}
                    >
                      {tChannels('tab.published')}
                    </FilterChip>
                  </div>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-gray-700 mb-2">
                    {t('channel_type')}
                  </h3>
                  <div className="flex gap-2">
                    <FilterChip
                      active={currentOrigin === OriginType.OriginalOnly}
                      onClick={() => updateFilter('origin', 'original_only')}
                    >
                      {tCommon('type.full_vtuber')}
                    </FilterChip>
                    <FilterChip
                      active={currentOrigin === OriginType.All}
                      onClick={() => updateFilter('origin', 'all')}
                    >
                      {tCommon('type.all_vtuber')}
                    </FilterChip>
                  </div>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-gray-700 mb-2">
                    {t('activity_type')}
                  </h3>
                  <div className="flex gap-2">
                    <FilterChip
                      active={currentActivity === ActivityType.ActiveOnly}
                      onClick={() => updateFilter('activity', 'active_only')}
                    >
                      {t('active_only')}
                    </FilterChip>
                    <FilterChip
                      active={currentActivity === ActivityType.All}
                      onClick={() => updateFilter('activity', 'all')}
                    >
                      {t('active_and_inactive')}
                    </FilterChip>
                  </div>
                </div>
              </div>
            )}

            {/* Language Selection */}
            <div className="mb-6 pt-4 border-t border-gray-200">
              <h3 className="text-sm font-medium text-gray-700 mb-3">
                {t('language')}
              </h3>
              <div className="flex gap-2">
                {Object.entries(localeNames).map(([code, name]) => (
                  <button
                    key={code}
                    onClick={() => handleLocaleChange(code)}
                    className={`px-3 py-1.5 text-sm rounded-full border transition-colors ${
                      locale === code
                        ? 'bg-blue-600 text-white border-blue-600'
                        : 'bg-white text-gray-700 border-gray-300 hover:border-gray-400'
                    }`}
                  >
                    {name}
                  </button>
                ))}
              </div>
            </div>

            {/* Add Channel Link */}
            <div className="pt-4 border-t border-gray-200">
              <a
                href={`/${locale}/register`}
                className="flex items-center gap-3 p-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                onClick={onClose}
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
                {t('add_channel')}
              </a>
            </div>
          </div>
        </div>
      </div>
    </>
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
