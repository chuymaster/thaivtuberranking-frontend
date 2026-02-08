import { getRequestConfig } from 'next-intl/server';

export const locales = ['th', 'en', 'ja'] as const;
export type Locale = (typeof locales)[number];

export default getRequestConfig(async ({ requestLocale }) => {
  // Get the locale from the request (middleware handles validation)
  let locale = await requestLocale;

  // Fallback to default locale if somehow missing
  if (!locale || !locales.includes(locale as Locale)) {
    locale = 'th';
  }

  const messages = (await import(`./locales/${locale}.json`)).default;

  return {
    locale,
    messages,
  };
});
