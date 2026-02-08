/**
 * Extract channel ID from various YouTube URL formats
 * Returns the channel ID if found, or info about what needs API resolution
 */
export function parseYouTubeInput(input: string): {
  channelId: string | null;
  needsResolution: boolean;
  resolveUrl: string | null;
} {
  const trimmed = input.trim();
  
  // Already a channel ID (starts with UC and is 24 characters)
  if (/^UC[\w-]{22}$/.test(trimmed)) {
    return { channelId: trimmed, needsResolution: false, resolveUrl: null };
  }

  // Try to parse as URL
  try {
    const url = new URL(trimmed);
    
    if (url.hostname.includes('youtube.com') || url.hostname.includes('youtu.be')) {
      // https://www.youtube.com/channel/UCxxxx
      const channelMatch = url.pathname.match(/^\/channel\/(UC[\w-]{22})/);
      if (channelMatch) {
        return { channelId: channelMatch[1], needsResolution: false, resolveUrl: null };
      }

      // Handle @username, /c/, /user/ - needs resolution
      if (url.pathname.startsWith('/@') || url.pathname.startsWith('/c/') || url.pathname.startsWith('/user/')) {
        return { channelId: null, needsResolution: true, resolveUrl: trimmed };
      }
    }
  } catch {
    // Not a valid URL
  }

  // Check if it's a handle without URL
  if (trimmed.startsWith('@')) {
    return { channelId: null, needsResolution: true, resolveUrl: trimmed };
  }

  // Return as partial channel ID input
  return { channelId: trimmed, needsResolution: false, resolveUrl: null };
}

/**
 * Check if the input is a valid channel ID
 */
export function isValidChannelId(input: string): boolean {
  return /^UC[\w-]{22}$/.test(input);
}
