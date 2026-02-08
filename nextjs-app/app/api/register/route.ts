import { NextRequest, NextResponse } from 'next/server';

const ADD_CHANNEL_API = 'https://us-central1-thaivtuberranking.cloudfunctions.net/postChannelRequest';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { channelId, channelType } = body;

    // Validate channel ID format
    if (!channelId || !channelId.startsWith('UC') || channelId.length !== 24) {
      return NextResponse.json(
        { error: 'Invalid channel ID format' },
        { status: 400 }
      );
    }

    // Call the Cloud Functions API
    const formData = new URLSearchParams();
    formData.append('channel_id', channelId);
    formData.append('type', channelType);

    const response = await fetch(ADD_CHANNEL_API, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: formData.toString(),
    });

    if (response.ok) {
      return NextResponse.json({ success: true });
    } else {
      console.error('Cloud Functions API error:', response.status);
      return NextResponse.json(
        { error: `API error: ${response.status}` },
        { status: response.status }
      );
    }
  } catch (error) {
    console.error('Registration error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
