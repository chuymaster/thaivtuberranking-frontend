enum Filter {
  Subscriber,
  View,
  PublishedDate;

  @override
  String toString() {
    switch (this) {
      case Subscriber:
        return "จำนวนผู้ติดตาม";
      case View:
        return "จำนวนการดู";
      case PublishedDate:
        return "วันเปิดแชนแนล";
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
