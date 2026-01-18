import { notFound } from 'next/navigation';
import { getRequestConfig } from 'next-intl/server';

export const locales = ['th', 'en', 'ja'] as const;
export type Locale = (typeof locales)[number];

export default getRequestConfig(async ({ requestLocale }) => {
  let locale = await requestLocale;

  if (!locale || !locales.includes(locale as Locale)) {
    locale = 'th'; // Default locale
  }

  try {
    const messages = (await import(`./locales/${locale}.json`)).default;

    return {
      locale,
      messages,
    };
  } catch (error) {
    notFound();
  }
});
