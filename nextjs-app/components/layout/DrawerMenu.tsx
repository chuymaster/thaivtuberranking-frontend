'use client';

import { useEffect } from 'react';
import { useTranslations, useLocale } from 'next-intl';
import { usePathname, useRouter } from 'next/navigation';

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
  const locale = useLocale();
  const pathname = usePathname();
  const router = useRouter();

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
    // Replace current locale in pathname
    const newPathname = pathname.replace(`/${locale}`, `/${newLocale}`);
    router.push(newPathname);
    onClose();
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

            {/* Language Selection */}
            <div className="mb-6">
              <h3 className="text-sm font-medium text-gray-500 mb-3">
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
