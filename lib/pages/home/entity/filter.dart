enum Filter {
  Subscriber,
  View,
  PublishedDate,
  UpdatedDate;

  @override
  String toString() {
    switch (this) {
      case Subscriber:
        return "จำนวนผู้ติดตาม";
      case View:
        return "จำนวนการดู";
      case PublishedDate:
        return "วันเปิดแชนแนล";
      case UpdatedDate:
        return "คลิปล่าสุด";
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
