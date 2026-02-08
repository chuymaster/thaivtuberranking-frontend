'use client';

import { useEffect } from 'react';
import { useTranslations, useLocale } from 'next-intl';
import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import Link from 'next/link';
import { OriginType, ActivityType, SortType } from '@/lib/types';
import { setLocale } from '@/lib/locale';
import { getEnvironmentPrefix } from '@/lib/env';

interface DrawerMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

const localeNames: Record<string, string> = {
  th: 'ไทย',
  en: 'English',
  ja: '日本語',
};

const externalLinks = {
  reportProblems: 'https://twitter.com/chuymaster',
  deletionCriteria: 'https://chuysan.notion.site/Public-d92d99d2b88a4747814834bcbdd9989f',
  disclaimer: 'https://chuysan.notion.site/Public-f97473612ebc4166b1e8293624fb9062',
  vtuberthaiinfo: 'https://vtuberthaiinfo.com/',
  twitterVtuberTH: 'https://twitter.com/hashtag/VtuberTH',
  vtuberAsia: 'https://vtuber.asia/',
  apiDocument: 'https://github.com/chuymaster/thaivtuberranking-docs',
  clientRepo: 'https://github.com/chuymaster/thaivtuberranking-frontend',
  releaseNotes: 'https://chuysan.notion.site/Public-Release-Notes-fddbe59f838949038fcaa4d774a4f2fc',
  developerBlog: 'https://chuysan.com/',
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
  const isChannelsPage = pathname === '/';

  const envPrefix = getEnvironmentPrefix();

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
    setLocale(newLocale as 'en' | 'th' | 'ja');
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
      <div className="fixed inset-y-0 left-0 z-50 w-80 bg-white shadow-xl transform transition-transform overflow-y-auto">
        <div className="flex flex-col">
          {/* Header */}
          <div className="bg-blue-600 text-white p-4">
            <div className="flex items-center gap-3 mb-2">
              <div className="w-12 h-12 bg-white rounded-full flex items-center justify-center">
                <span className="text-2xl">🎭</span>
              </div>
              <div>
                <h2 className="font-bold">
                  {envPrefix}{t('site_title')}
                </h2>
                <p className="text-sm text-blue-100 whitespace-pre-line">
                  {t('site_description')}
                </p>
              </div>
            </div>
            <button
              onClick={onClose}
              className="absolute top-4 right-4 p-1 text-white/80 hover:text-white"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          {/* Filters - only show on channels page */}
          {isChannelsPage && (
            <div className="p-4 border-b border-gray-200">
              {/* Channel Type */}
              <div className="mb-4">
                <h3 className="text-sm font-bold text-gray-900 mb-2">
                  {t('channel_type')}
                </h3>
                <div className="space-y-2">
                  <label className="flex items-center gap-2">
                    <input
                      type="radio"
                      checked={currentOrigin === OriginType.OriginalOnly}
                      onChange={() => updateFilter('origin', 'original_only')}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-sm text-gray-900">{tCommon('type.full_vtuber')}</span>
                  </label>
                  <label className="flex items-center gap-2">
                    <input
                      type="radio"
                      checked={currentOrigin === OriginType.All}
                      onChange={() => updateFilter('origin', 'all')}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-sm text-gray-900">{tCommon('type.all_vtuber')}</span>
                  </label>
                </div>
                <p className="text-xs text-gray-600 mt-2">{t('channel_type_description')}</p>
              </div>

              {/* Activity Type */}
              <div>
                <h3 className="text-sm font-bold text-gray-900 mb-2">
                  {t('activity_type')}
                </h3>
                <div className="space-y-2">
                  <label className="flex items-center gap-2">
                    <input
                      type="radio"
                      checked={currentActivity === ActivityType.ActiveOnly}
                      onChange={() => updateFilter('activity', 'active_only')}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-sm text-gray-900">{t('active_only')}</span>
                  </label>
                  <label className="flex items-center gap-2">
                    <input
                      type="radio"
                      checked={currentActivity === ActivityType.All}
                      onChange={() => updateFilter('activity', 'all')}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-sm text-gray-900">{t('active_and_inactive')}</span>
                  </label>
                </div>
                <p className="text-xs text-gray-600 mt-2">{t('activity_explanation')}</p>
              </div>
            </div>
          )}

          {/* Language Selection */}
          <div className="p-4 border-b border-gray-200">
            <h3 className="text-sm font-bold text-gray-900 mb-3">
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

          {/* Menu */}
          <div className="p-4 border-b border-gray-200">
            <h3 className="text-sm font-bold text-gray-900 mb-3">
              {t('menu_title')}
            </h3>
            <div className="space-y-1">
              <Link
                href="/register"
                onClick={onClose}
                className="flex items-center justify-between p-2 hover:bg-gray-100 rounded"
              >
                <span className="text-sm text-gray-900">{t('add_channel')}</span>
                <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
              </Link>
              <ExternalLink href={externalLinks.reportProblems} label={t('report_problems')} />
              <ExternalLink href={externalLinks.deletionCriteria} label={t('deletion_criteria')} />
              <ExternalLink href={externalLinks.disclaimer} label={t('disclaimer')} />
            </div>
          </div>

          {/* Discover Thai VTubers */}
          <div className="p-4 border-b border-gray-200">
            <h3 className="text-sm font-bold text-gray-900 mb-3">
              {t('discover_vtuber')}
            </h3>
            <div className="space-y-1">
              <ExternalLink href={externalLinks.vtuberthaiinfo} label="VTuberThaiInfo" highlight />
              <ExternalLink href={externalLinks.twitterVtuberTH} label="X #VTuberTH" />
              <ExternalLink href={externalLinks.vtuberAsia} label="VTuber Indonesia / Malaysia / Philippines" />
            </div>
          </div>

          {/* For Developers */}
          <div className="p-4">
            <h3 className="text-sm font-bold text-gray-900 mb-3">
              {t('for_developers')}
            </h3>
            <div className="space-y-1">
              <ExternalLink href={externalLinks.apiDocument} label={t('api_document')} icon="code" />
              <ExternalLink href={externalLinks.clientRepo} label={t('client_repo')} icon="code" />
              <ExternalLink href={externalLinks.releaseNotes} label={t('release_notes')} />
              <ExternalLink href={externalLinks.developerBlog} label={t('developer_blog')} />
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

function ExternalLink({ 
  href, 
  label, 
  highlight = false,
  icon = 'external'
}: { 
  href: string; 
  label: string; 
  highlight?: boolean;
  icon?: 'external' | 'code';
}) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="flex items-center justify-between p-2 hover:bg-gray-100 rounded"
    >
      <span className={`text-sm ${highlight ? 'text-blue-600 font-bold' : 'text-gray-900'}`}>{label}</span>
      {icon === 'external' ? (
        <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
        </svg>
      ) : (
        <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
        </svg>
      )}
    </a>
  );
}
