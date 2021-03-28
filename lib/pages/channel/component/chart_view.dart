import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';

class ChartView extends StatelessWidget {
  final ChannelChartData channelChartData;
  final double width;
  final double height;

  const ChartView(
      {Key? key,
      required this.width,
      required this.height,
      required this.channelChartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> subscriberSpots =
        channelChartData.chartDataPoints.reversed.take(7).map((element) {
      return FlSpot(element.getDateInDouble(), element.subscribers);
    }).toList();

    LineChartBarData subscribersBarData = LineChartBarData(
      spots: subscriberSpots,
      isCurved: true,
      curveSmoothness: 0.35,
      isStrokeCapRound: true,
      barWidth: 10,
    );

    LineChart lineChart = LineChart(
        LineChartData(
            lineBarsData: [subscribersBarData],
            axisTitleData: FlAxisTitleData(bottomTitle: _xAxisTitle()),
            titlesData: FlTitlesData(bottomTitles: _bottomTitles())),
        swapAnimationDuration: Duration(milliseconds: 150));
    final padding = 16;
    return SizedBox(width: width, height: height + padding, child: lineChart);
  }

  AxisTitle _xAxisTitle() {
    return AxisTitle(
        showTitle: true,
        titleText: 'Date',
        textStyle:
            TextStyle(color: Colors.black54, fontWeight: FontWeight.bold));
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
      margin: 8,
    );
  }
}
