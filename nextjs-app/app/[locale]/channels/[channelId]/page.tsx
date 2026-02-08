import { notFound } from 'next/navigation';
import Image from 'next/image';
import { getChannelDetail, getChannelChart } from '@/lib/api/channels';
import { ChannelChart } from '@/components/channels/ChannelChart';
import { CopyUrlButton } from '@/components/channels/CopyUrlButton';
import { formatNumber, formatDate } from '@/lib/utils/format';
import { getTranslations } from 'next-intl/server';

interface PageProps {
  params: Promise<{ locale: string; channelId: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { channelId } = await params;

  try {
    const channel = await getChannelDetail(channelId);
    return {
      title: `${channel.title} - Thai VTuber Ranking`,
      description: channel.description || `View ${channel.title}'s channel stats`,
      openGraph: {
        title: channel.title,
        description: channel.description || `View ${channel.title}'s channel stats`,
        images: [channel.thumbnail_icon_url],
      },
    };
  } catch {
    return {
      title: 'Channel Not Found - Thai VTuber Ranking',
    };
  }
}

export default async function ChannelDetailPage({ params }: PageProps) {
  const { channelId, locale } = await params;
  const t = await getTranslations('channel');
  const tChannels = await getTranslations('channels');

  let channel;
  let chartResponse;
  try {
    [channel, chartResponse] = await Promise.all([
      getChannelDetail(channelId),
      getChannelChart(channelId).catch(() => ({ chartData: [] })),
    ]);
  } catch {
    notFound();
  }

  const { chartData } = chartResponse;

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-8 px-4">
        {/* Back Link */}
        <a
          href={`/${locale}/channels`}
          className="inline-flex items-center text-blue-600 hover:text-blue-800 mb-6"
        >
          <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
          </svg>
          {tChannels('title')}
        </a>

        {/* Channel Header */}
        <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
          <div className="flex items-start gap-6">
            {/* Thumbnail */}
            <div className="flex-shrink-0">
              <Image
                src={channel.thumbnail_icon_url}
                alt={channel.title}
                width={120}
                height={120}
                className="rounded-full"
              />
            </div>

            {/* Info */}
            <div className="flex-1 min-w-0">
              <h1 className="text-2xl font-bold text-gray-900 mb-2">
                {channel.title}
              </h1>

              <div className="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <p className="text-sm text-gray-500">{tChannels('tab.subscribers')}</p>
                  <p className="text-lg font-semibold text-gray-900">
                    {formatNumber(channel.subscribers)}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-500">{tChannels('tab.views')}</p>
                  <p className="text-lg font-semibold text-gray-900">
                    {formatNumber(channel.views)}
                  </p>
                </div>
              </div>

              <div className="text-sm text-gray-600 space-y-1">
                {channel.last_published_video_at && (
                  <p>
                    Latest video: {formatDate(channel.last_published_video_at)}
                  </p>
                )}
                {channel.published_at && (
                  <p>
                    Channel opened: {formatDate(channel.published_at)}
                  </p>
                )}
              </div>

              {/* Actions */}
              <div className="flex gap-3 mt-4">
                <a
                  href={`https://www.youtube.com/channel/${channel.channel_id}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors"
                >
                  <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                  </svg>
                  YouTube
                </a>
                <CopyUrlButton />
              </div>
            </div>
          </div>

          {/* Description */}
          {channel.description && (
            <div className="mt-6 pt-6 border-t border-gray-200">
              <h2 className="text-sm font-medium text-gray-500 mb-2">Description</h2>
              <p className="text-gray-700 whitespace-pre-wrap">{channel.description}</p>
            </div>
          )}
        </div>

        {/* Charts */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            {t('graph_description')}
          </h2>
          <ChannelChart chartData={chartData} />
        </div>
      </div>
    </div>
  );
}
