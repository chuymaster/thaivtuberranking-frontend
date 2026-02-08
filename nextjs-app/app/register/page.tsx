'use client';

import { useState } from 'react';
import { useTranslations } from 'next-intl';
import { OriginType } from '@/lib/types';
import Link from 'next/link';

type SubmitStatus = 'idle' | 'loading' | 'success' | 'error';

export default function RegisterPage() {
  const t = useTranslations('register');
  const tCommon = useTranslations('common');
  
  const [channelId, setChannelId] = useState('');
  const [channelType, setChannelType] = useState<OriginType>(OriginType.OriginalOnly);
  const [status, setStatus] = useState<SubmitStatus>('idle');
  const [error, setError] = useState<string>('');

  const isValidChannelId = channelId.startsWith('UC') && channelId.length === 24;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!isValidChannelId) {
      setError('Channel ID must start with "UC" and be 24 characters long');
      return;
    }

    setStatus('loading');
    setError('');

    try {
      const response = await fetch('/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          channelId,
          channelType,
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to submit channel');
      }

      setStatus('success');
    } catch (err) {
      setStatus('error');
      setError('Failed to submit. Please try again.');
    }
  };

  if (status === 'success') {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="max-w-md w-full mx-4">
          <div className="bg-white rounded-lg shadow-sm p-8 text-center">
            <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-gray-900 mb-2">
              {t('complete.title')}
            </h1>
            <p className="text-gray-600 mb-6 whitespace-pre-line">
              {t('complete.description')}
            </p>
            <Link
              href="/"
              className="inline-block px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              {t('complete.button_home')}
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-lg mx-auto py-8 px-4">
        <h1 className="text-xl font-bold text-gray-900 mb-6">
          {t('title')}
        </h1>

        <form onSubmit={handleSubmit} className="bg-white rounded-lg shadow-sm p-6 space-y-6 mb-6">
          {/* Channel ID Input */}
          <div>
            <label htmlFor="channelId" className="block text-sm font-medium text-gray-700 mb-2">
              {t('input_channel')}
            </label>
            <input
              type="text"
              id="channelId"
              value={channelId}
              onChange={(e) => setChannelId(e.target.value)}
              placeholder="UCqhhWjpw23dWhJ5rRwCCrMA"
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-400"
              maxLength={24}
            />
            {channelId && !isValidChannelId && (
              <p className="mt-1 text-sm text-red-600">
                {t('error.length_mismatched')}
              </p>
            )}
          </div>

          {/* Channel Type Selection */}
          {isValidChannelId && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  {t('select_channel_type')}
                </label>
                <div className="space-y-2">
                  <label className="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                    <input
                      type="radio"
                      name="channelType"
                      value={OriginType.OriginalOnly}
                      checked={channelType === OriginType.OriginalOnly}
                      onChange={(e) => setChannelType(e.target.value as OriginType)}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-gray-700">{tCommon('type.full_vtuber')}</span>
                  </label>
                  <label className="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                    <input
                      type="radio"
                      name="channelType"
                      value={OriginType.All}
                      checked={channelType === OriginType.All}
                      onChange={(e) => setChannelType(e.target.value as OriginType)}
                      className="w-4 h-4 text-blue-600"
                    />
                    <span className="text-gray-700">{tCommon('type.all_vtuber')}</span>
                  </label>
                </div>
              </div>

              {/* Check Before Submit */}
              <div>
                <p className="text-sm font-bold text-red-600 mb-2">
                  {t('check_before_submit')}
                </p>
                <a
                  href={`https://www.youtube.com/channel/${channelId}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:text-blue-800 underline text-sm"
                >
                  https://www.youtube.com/channel/{channelId}
                </a>
              </div>
            </>
          )}

          {/* Error Message */}
          {error && (
            <div className="p-3 bg-red-50 text-red-700 rounded-lg text-sm">
              {error}
            </div>
          )}

          {/* Submit Button */}
          <button
            type="submit"
            disabled={!isValidChannelId || status === 'loading'}
            className="w-full px-4 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
          >
            {status === 'loading' ? (
              <span className="flex items-center justify-center gap-2">
                <svg className="animate-spin h-5 w-5" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                </svg>
                Submitting...
              </span>
            ) : (
              t('button_submit')
            )}
          </button>
        </form>

        {/* Info Section */}
        <div className="bg-gray-100 rounded-lg p-6 space-y-4">
          {/* Channel ID Explanation */}
          <div>
            <h2 className="font-bold text-gray-900 mb-2">{t('info.id_title')}</h2>
            <p className="text-sm text-gray-700">
              {t('info.id_explanation')}
              <span className="font-bold text-red-700">{t('info.id_example')}</span>
            </p>
            <a
              href="https://commentpicker.com/youtube-channel-id.php"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:text-blue-800 underline text-sm"
            >
              {t('info.id_link')}
            </a>
          </div>

          {/* Channel Type Explanation */}
          <div>
            <h2 className="font-bold text-gray-900 mb-2">{t('info.type_title')}</h2>
            
            <p className="text-sm text-gray-900 font-medium mt-3">1. {tCommon('type.full_vtuber')}</p>
            <p className="text-sm text-gray-700 mt-1">- {t('info.full_vtuber_explanation')}</p>
            
            <p className="text-sm text-gray-900 font-medium mt-3">2. {tCommon('type.all_vtuber')}</p>
            <p className="text-sm text-gray-700 mt-1">- {t('info.all_vtuber_explanation')}</p>
            
            <p className="text-sm text-gray-700 mt-3">{t('info.type_note')}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
