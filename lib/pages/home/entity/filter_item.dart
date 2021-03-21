enum Filter { Subscriber, View, PublishedDate, UpdatedDate }

class FilterItem {
  final Filter filter;
  String text = "";

  FilterItem(this.filter) {
    switch (filter) {
      case Filter.Subscriber:
        text = 'จำนวนผู้ติดตาม';
        break;
      case Filter.View:
        text = 'จำนวนการดู';
        break;
      case Filter.PublishedDate:
        text = 'วันเปิดแชนแนล';
        break;
      case Filter.UpdatedDate:
        text = 'คลิปล่าสุด';
        break;
    }
  }

  // Must implement Equatable https://stackoverflow.com/a/62471836
  @override
  bool operator ==(Object other) =>
      other is FilterItem && other.filter == filter && other.text == text;

  @override
  int get hashCode => text.hashCode;
}
