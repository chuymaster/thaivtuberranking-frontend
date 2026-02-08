'use client';

export const locales = ['en', 'th', 'ja'] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = 'en';

const LOCALE_COOKIE_NAME = 'NEXT_LOCALE';
const COOKIE_MAX_AGE = 60 * 60 * 24 * 365; // 1 year

export function setLocale(locale: Locale): void {
  document.cookie = `${LOCALE_COOKIE_NAME}=${locale};path=/;max-age=${COOKIE_MAX_AGE};samesite=lax`;
  // Reload to apply new locale
  window.location.reload();
}

export function getLocaleFromCookie(): Locale | null {
  if (typeof document === 'undefined') return null;
  
  const match = document.cookie.match(new RegExp(`${LOCALE_COOKIE_NAME}=([^;]+)`));
  const value = match?.[1];
  
  if (value && locales.includes(value as Locale)) {
    return value as Locale;
  }
  
  return null;
}
