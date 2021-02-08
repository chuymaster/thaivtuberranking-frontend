import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';

class ChartView extends StatelessWidget {
  final ChannelChartData channelChartData;
  final double width;
  final double height;

  const ChartView({Key key, this.width, this.height, this.channelChartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var webView = EasyWebView(
      src: _getChartHTML(width, height),
      isHtml: true,
      key: UniqueKey(),
      onLoaded: () {},
    );
    final padding = 16;
    return SizedBox(width: width, height: height + padding, child: webView);
  }

  String _getChartHTML(double width, double height) {
    var data = '';
    channelChartData.chartDataPoints.forEach((element) {
      final date = element.getDateFormatted();
      final subscribers = element.subscribers;
      final views = element.views;
      data += "['$date', $subscribers, $views],\n";
    });

    final html = '''
<html>
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'วันที่');
        data.addColumn('number', 'จำนวนผู้ติดตาม');
        data.addColumn('number', 'ยอดดูวิดีโอทั้งหมด');
        data.addRows([$data]);

        // Set chart options

        var options = {
        chartArea: {
          top: 32,
          height: '60%' 
        },
        vAxes: {
          0: {
            title: 'จำนวนผู้ติดตาม'
          },
          1: {
            title:'ยอดดูวิดีโอทั้งหมด'
          }
        },
        hAxis: {title: 'วันที่'},
         seriesType: 'line',
          series: {1: {type: 'line', targetAxisIndex: 1}
          },
          width: $width,
          height: $height
        }

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>

  <!--No need for body margin in embedded webview-->
  <style>
    body {
      margin: 0px;
      padding: 0px;
    }
  </style>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>
''';
    return html;
  }
}
