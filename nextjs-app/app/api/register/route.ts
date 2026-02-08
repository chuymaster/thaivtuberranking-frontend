import { NextRequest, NextResponse } from 'next/server';

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

    // TODO: Submit to actual backend/database
    // For now, just log and return success
    console.log('Channel registration request:', { channelId, channelType });

    // In production, this would:
    // 1. Verify the channel exists on YouTube
    // 2. Add to pending approval queue
    // 3. Send notification to admin

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Registration error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
