import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';

class ChannelChartView extends StatefulWidget {
  ChannelChartView(
      {super.key,
      required this.channelChartData,
      required this.width,
      required this.height});
  final ChannelChartData channelChartData;
  final double width;
  final double height;

  @override
  _ChannelChartViewState createState() => _ChannelChartViewState();
}

class _ChannelChartViewState extends State<ChannelChartView> {
  late List<ChartDataPoint> _chartData =
      widget.channelChartData.chartDataPoints;
  late TooltipBehavior _tooltipBehavior =
      TooltipBehavior(enable: true, shared: true);

  String _viewsAxis = 'viewsAxis';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfCartesianChart(
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<ChartDataPoint, DateTime>(
              name: 'Subscribers',
              color: Colors.blueAccent,
              dataSource: _chartData,
              xValueMapper: (ChartDataPoint data, _) => data.date,
              yValueMapper: (ChartDataPoint data, _) => data.subscribers,
              dataLabelSettings: DataLabelSettings(isVisible: false),
              enableTooltip: true),
          LineSeries<ChartDataPoint, DateTime>(
              name: 'Views',
              color: Colors.redAccent,
              dataSource: _chartData,
              xValueMapper: (ChartDataPoint data, _) => data.date,
              yValueMapper: (ChartDataPoint data, _) => data.views,
              yAxisName: _viewsAxis,
              dataLabelSettings: DataLabelSettings(isVisible: false),
              enableTooltip: true)
        ],
        // adding multiple axis
        axes: <ChartAxis>[
          NumericAxis(
              name: _viewsAxis,
              opposedPosition: true,
              title: AxisTitle(text: 'Views'),
              labelFormat: '{value}',
              numberFormat: NumberFormat.compact()),
        ],
        primaryXAxis: DateTimeAxis(dateFormat: DateFormat('d/M/yyyy')),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Subscribers'),
            numberFormat: NumberFormat.compact()),
      ),
      width: widget.width,
      height: widget.height,
    );
  }
}
