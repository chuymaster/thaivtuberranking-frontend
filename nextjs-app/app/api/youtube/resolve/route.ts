import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const url = searchParams.get('url');

  if (!url) {
    return NextResponse.json({ error: 'URL is required' }, { status: 400 });
  }

  try {
    // Construct the YouTube URL to fetch
    let youtubeUrl = url;
    
    // If it's just a handle like @username, construct the full URL
    if (url.startsWith('@')) {
      youtubeUrl = `https://www.youtube.com/${url}`;
    } else if (url.startsWith('/c/') || url.startsWith('/user/')) {
      youtubeUrl = `https://www.youtube.com${url}`;
    } else if (!url.startsWith('http')) {
      youtubeUrl = `https://www.youtube.com/${url}`;
    }

    // Fetch the YouTube page
    const response = await fetch(youtubeUrl, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    });

    if (!response.ok) {
      return NextResponse.json({ error: 'Failed to fetch YouTube page' }, { status: 404 });
    }

    const html = await response.text();

    // Try to extract channel ID from canonical link
    // <link rel="canonical" href="https://www.youtube.com/channel/UCxxxx">
    const canonicalMatch = html.match(/<link[^>]+rel="canonical"[^>]+href="https:\/\/www\.youtube\.com\/channel\/(UC[\w-]{22})"/);
    if (canonicalMatch) {
      return NextResponse.json({ channelId: canonicalMatch[1] });
    }

    // Try to extract from meta tag
    // <meta itemprop="channelId" content="UCxxxx">
    const metaMatch = html.match(/<meta[^>]+itemprop="channelId"[^>]+content="(UC[\w-]{22})"/);
    if (metaMatch) {
      return NextResponse.json({ channelId: metaMatch[1] });
    }

    // Try to extract from page content
    // "channelId":"UCxxxx"
    const jsonMatch = html.match(/"channelId":"(UC[\w-]{22})"/);
    if (jsonMatch) {
      return NextResponse.json({ channelId: jsonMatch[1] });
    }

    // Try external ID format
    // "externalId":"UCxxxx"
    const externalMatch = html.match(/"externalId":"(UC[\w-]{22})"/);
    if (externalMatch) {
      return NextResponse.json({ channelId: externalMatch[1] });
    }

    return NextResponse.json({ error: 'Could not find channel ID' }, { status: 404 });
  } catch (error) {
    console.error('YouTube scrape error:', error);
    return NextResponse.json({ error: 'Failed to resolve channel' }, { status: 500 });
  }
}
