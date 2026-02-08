import type { Metadata } from "next";
import { Sarabun, Kanit } from "next/font/google";
import { NextIntlClientProvider } from 'next-intl';
import { getLocale, getMessages } from 'next-intl/server';
import { Header, BottomNav } from '@/components/layout';
import "./globals.css";

const sarabun = Sarabun({
  variable: "--font-sarabun",
  subsets: ["latin", "thai"],
  weight: ["300", "400", "500", "600", "700"],
  display: "swap",
});

const kanit = Kanit({
  variable: "--font-kanit",
  subsets: ["latin", "thai"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
});

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

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const locale = await getLocale();
  const messages = await getMessages();

  return (
    <html lang={locale} suppressHydrationWarning>
      <body
        className={`${sarabun.variable} ${kanit.variable} antialiased font-sans`}
      >
        <NextIntlClientProvider messages={messages} locale={locale}>
          <Header />
          <main className="pb-16">
            {children}
          </main>
          <BottomNav />
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
