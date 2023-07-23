enum Filter {
  Subscriber,
  View,
  PublishedDate;

  @override
  String toString() {
    switch (this) {
      case Subscriber:
        return "ผู้ติดตาม";
      case View:
        return "Views";
      case PublishedDate:
        return "วันเปิดแชนแนล";
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
