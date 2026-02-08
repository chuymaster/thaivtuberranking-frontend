'use client';

import { useState } from 'react';
import { useTranslations } from 'next-intl';
import { DrawerMenu } from './DrawerMenu';

export function Header() {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const t = useTranslations('navigation');

  return (
    <>
      <header className="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-sm">
        <div className="max-w-4xl mx-auto px-4 h-14 flex items-center justify-between">
          {/* Menu Button */}
          <button
            onClick={() => setIsDrawerOpen(true)}
            className="p-2 -ml-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg transition-colors"
            aria-label={t('menu_title')}
          >
            <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>

          {/* Title */}
          <h1 className="text-lg font-semibold text-gray-900 font-heading">
            {t('site_title')}
          </h1>

          {/* Placeholder for right side */}
          <div className="w-10" />
        </div>
      </header>

      <DrawerMenu isOpen={isDrawerOpen} onClose={() => setIsDrawerOpen(false)} />
    </>
  );
}
