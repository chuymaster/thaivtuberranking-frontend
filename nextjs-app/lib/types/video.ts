export interface VideoRanking {
  id: string;
  title: string;
  channel_id: string;
  channel_title: string;
  view_count: number;
  comment_count: number;
  dislike_count: number;
  favorite_count: number;
  like_count: number;
  thumbnail_image_url: string;
  published_at: string;
  is_rebranded: boolean;
}

export interface VideoRankingResponse {
  result: VideoRanking[];
}
