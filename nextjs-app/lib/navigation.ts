// Re-export from next for non-URL-based locale routing
import NextLink from 'next/link';
export { redirect, usePathname, useRouter } from 'next/navigation';

export const Link = NextLink;
