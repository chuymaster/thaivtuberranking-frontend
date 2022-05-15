enum VideoRankingType {
  OneDay,
  ThreeDay,
  SevenDay;

  Uri get jsonUrl {
    switch (this) {
      case OneDay:
        return Uri.parse(
            "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/one_day_ranking.json");
      case ThreeDay:
        return Uri.parse(
            "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/three_days_ranking.json");
      case SevenDay:
        return Uri.parse(
            "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/seven_days_ranking.json");
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
