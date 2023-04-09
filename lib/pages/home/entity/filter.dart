enum Filter {
  Subscriber,
  View,
  PublishedDate;

  @override
  String toString() {
    switch (this) {
      case Subscriber:
        return "เรียงตามจำนวนผู้ติดตาม";
      case View:
        return "เรียงตามจำนวนการดู";
      case PublishedDate:
        return "เรียงตามวันเปิดแชนแนลล่าสุด";
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
