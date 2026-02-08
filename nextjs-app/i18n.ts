import { getRequestConfig } from 'next-intl/server';
import { cookies, headers } from 'next/headers';

export const locales = ['en', 'th', 'ja'] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = 'en';

function getBrowserLocale(acceptLanguage: string | null): Locale {
  if (!acceptLanguage) return defaultLocale;
  
  // Parse Accept-Language header and find best match
  const languages = acceptLanguage.split(',').map(lang => {
    const [code] = lang.trim().split(';');
    return code.split('-')[0].toLowerCase();
  });
  
  for (const lang of languages) {
    if (locales.includes(lang as Locale)) {
      return lang as Locale;
    }
  }
  
  return defaultLocale;
}

export default getRequestConfig(async () => {
  // 1. Try to get locale from cookie
  const cookieStore = await cookies();
  const localeCookie = cookieStore.get('NEXT_LOCALE')?.value;
  
  let locale: Locale;
  
  if (localeCookie && locales.includes(localeCookie as Locale)) {
    locale = localeCookie as Locale;
  } else {
    // 2. Fall back to browser's Accept-Language header
    const headerStore = await headers();
    const acceptLanguage = headerStore.get('accept-language');
    locale = getBrowserLocale(acceptLanguage);
  }

  const messages = (await import(`./locales/${locale}.json`)).default;

  return {
    locale,
    messages,
  };
});
