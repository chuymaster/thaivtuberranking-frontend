import 'package:intl/intl.dart';

class ChannelChartData {
  final String id;
  final String title;
  final List<ChartDataPoint> chartDataPoints;

  ChannelChartData(this.id, this.title, this.chartDataPoints);

  factory ChannelChartData.fromJson(Map<String, dynamic> json) {
    List<ChartDataPoint> dataPoints = [];

    List<dynamic> jsons = json['chartDataPoints'];
    jsons.forEach((element) {
      dataPoints.add(ChartDataPoint.fromJson(element));
    });

    return ChannelChartData(json['id'], json['title'], dataPoints);
  }
}

class ChartDataPoint {
  final DateTime date;
  final int views;
  final int subscribers;
  final int comments;
  final int videos;

  ChartDataPoint(
      this.date, this.views, this.subscribers, this.comments, this.videos);

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(DateTime.parse(json['date']), json['views'],
        json['subscribers'], json['comments'], json['videos']);
  }

  String getDateFormatted() {
    return DateFormat('d/M/yyyy').format(date);
  }
}
