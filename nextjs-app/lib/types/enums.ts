export enum OriginType {
  OriginalOnly = 'original_only',
  All = 'all',
}

export enum ActivityType {
  ActiveOnly = 'active_only',
  All = 'all',
}

export enum LiveStatus {
  None = 0,
  Live = 1,
  Upcoming = 2,
  Past = 3,
}

export enum VideoRankingType {
  OneDay = '1day',
  ThreeDay = '3day',
  SevenDay = '7day',
}

export enum SortType {
  Subscribers = 'subscribers',
  Views = 'views',
  PublishedDate = 'published_date',
}
