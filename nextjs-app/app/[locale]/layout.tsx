import type { Metadata } from "next";
import { NextIntlClientProvider } from 'next-intl';
import { getMessages } from 'next-intl/server';
import { notFound } from 'next/navigation';
import { locales } from '@/i18n';
import { Header, BottomNav } from '@/components/layout';
import { LocaleHtmlLang } from '@/components/LocaleHtmlLang';

export const metadata: Metadata = {
  title: "Thai VTuber Ranking - ลิสต์รายชื่อ VTuber ไทย",
  description: "Find your favorite Thai VTubers! ค้นหา VTuber ไทยที่คุณชื่นชอบ",
  keywords: ["VTuber", "Thai VTuber", "Virtual YouTuber", "Thailand", "ไทย"],
  authors: [{ name: "chuymaster" }],
  openGraph: {
    title: "Thai VTuber Ranking",
    description: "Find your favorite Thai VTubers!",
    type: "website",
    locale: "th_TH",
    alternateLocale: ["en_US", "ja_JP"],
  },
  twitter: {
    card: "summary_large_image",
    title: "Thai VTuber Ranking",
    description: "Find your favorite Thai VTubers!",
  },
};

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;

  // Validate locale
  if (!locales.includes(locale as any)) {
    notFound();
  }

  const messages = await getMessages();

  return (
    <NextIntlClientProvider messages={messages} locale={locale}>
      <LocaleHtmlLang locale={locale} />
      <Header />
      <main className="pb-16 md:pb-0">
        {children}
      </main>
      <BottomNav />
    </NextIntlClientProvider>
  );
}
