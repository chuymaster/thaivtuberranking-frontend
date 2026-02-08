'use client';

import { useRouter, useSearchParams } from 'next/navigation';
import { useTranslations } from 'next-intl';
import { VideoRankingType } from '@/lib/types';

interface VideoTabsProps {
  currentType: VideoRankingType;
}

export function VideoTabs({ currentType }: VideoTabsProps) {
  const t = useTranslations('videos.tab');
  const router = useRouter();
  const searchParams = useSearchParams();

  const handleTabChange = (type: VideoRankingType) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set('type', type);
    router.push(`/videos?${params.toString()}`);
  };

  const tabs = [
    { type: VideoRankingType.OneDay, label: t('one_day') },
    { type: VideoRankingType.ThreeDay, label: t('three_days') },
    { type: VideoRankingType.SevenDay, label: t('seven_days') },
  ];

  return (
    <div className="flex gap-2 mb-4">
      {tabs.map((tab) => (
        <button
          key={tab.type}
          onClick={() => handleTabChange(tab.type)}
          className={`px-4 py-2 text-sm font-medium rounded-full border transition-colors ${
            currentType === tab.type
              ? 'bg-blue-600 text-white border-blue-600'
              : 'bg-white text-gray-700 border-gray-300 hover:border-gray-400'
          }`}
        >
          {tab.label}
        </button>
      ))}
    </div>
  );
}
