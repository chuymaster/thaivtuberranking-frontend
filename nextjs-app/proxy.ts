import createMiddleware from 'next-intl/middleware';
import { locales } from './i18n';

export default createMiddleware({
  locales,
  defaultLocale: 'th',
  localePrefix: 'always',
});

export const config = {
  matcher: ['/', '/(th|en|ja)/:path*'],
};
