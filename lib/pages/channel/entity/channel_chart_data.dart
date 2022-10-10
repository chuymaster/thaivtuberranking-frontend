import 'package:intl/intl.dart';

class ChannelChartData {
  final String id;
  final String title;
  final List<ChartDataPoint> chartDataPoints;

  ChannelChartData(this.id, this.title, this.chartDataPoints);

  factory ChannelChartData.fromJson(Map<String, dynamic> json) {
    List<ChartDataPoint> dataPoints = [];

    List<dynamic> jsons = json['chart_data_points'];
    jsons.forEach((element) {
      dataPoints.add(ChartDataPoint.fromJson(element));
    });

    return ChannelChartData(json['id'], json['title'], dataPoints);
  }
}

class ChartDataPoint {
  final DateTime date;
  final double views;
  final double subscribers;
  final double comments;
  final double videos;

  ChartDataPoint(
      this.date, this.views, this.subscribers, this.comments, this.videos);

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(DateTime.parse(json['date']), json['views'] ?? 0,
        json['subscribers'] ?? 0, json['comments'] ?? 0, json['videos'] ?? 0);
  }

  String getDateFormatted() {
    return DateFormat('d/M/yyyy').format(date);
  }

  double getDateInDouble() {
    return date.millisecondsSinceEpoch.toDouble();
  }
}
