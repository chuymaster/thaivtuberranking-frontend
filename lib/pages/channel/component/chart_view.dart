import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';

class ChartView extends StatelessWidget {
  final ChannelChartData channelChartData;
  final double width;
  final double height;

  final int _numberOfChartData = 7;

  const ChartView(
      {Key? key,
      required this.width,
      required this.height,
      required this.channelChartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> subscriberSpots =
        channelChartData.takeChartDataPoints(_numberOfChartData).map((element) {
      return FlSpot(element.getDateInDouble(), element.subscribers);
    }).toList();

    LineChartBarData subscribersBarData = LineChartBarData(
      spots: subscriberSpots,
    );

    LineChart lineChart = LineChart(LineChartData(
        lineBarsData: [subscribersBarData],
        titlesData: FlTitlesData(bottomTitles: _bottomTitles())));
    final padding = 16;
    return SizedBox(width: width, height: height + padding, child: lineChart);
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value) {
        return TextStyle(
          color: Colors.black87,
          fontSize: 14,
        );
      },
      getTitles: (value) {
        final DateTime date =
            DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return DateFormat('d/M/yyyy').format(date);
      },
      rotateAngle: 315,
      margin: 24,
    );
  }
}
