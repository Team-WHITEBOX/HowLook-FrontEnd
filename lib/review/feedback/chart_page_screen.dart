import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  List<ChartData> data = [
    ChartData('1-2', 1),
    ChartData('3-4', 9),
    ChartData('5-6', 5),
    ChartData('7-8', 8),
    ChartData('9-10', 6)
  ];
  late TooltipBehavior _tooltip= TooltipBehavior(enable: true);

  // @override
  // void initState() {
  //   data = [
  //     ChartData('CHN', 12),
  //     ChartData('GER', 15),
  //     ChartData('RUS', 30),
  //     ChartData('BRZ', 6.4),
  //     ChartData('IND', 14)
  //   ];
  //   _tooltip = TooltipBehavior(enable: true);
  //   super.initState();
  // }

  // List<double> Fscore = [1, 4, 7, 3, 8];
  // List<double> Mscore = [5, 2, 8, 6, 9];
  //
  // List<String> labels = [ // 가로축에 적을 텍스트(레이블)
  //   "1-2",
  //   "3-4",
  //   "5-6",
  //   "7-8",
  //   "9-10",
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //           child: Container(
  //               child: SfCartesianChart(
  //                 // Enables the legend
  //                   legend: Legend(isVisible: true),
  //                   // Initialize category axis
  //                   primaryXAxis: CategoryAxis(),
  //                   series: <ChartSeries>[
  //                     // Initialize line series
  //                     LineSeries<ChartData, String>(
  //                       dataSource: [
  //                         // Bind data source
  //                         ChartData('1-2',5),
  //                         ChartData('3-4', 4),
  //                         ChartData('5-6', 8),
  //                         ChartData('7-8', 3),
  //                         ChartData('9-10', 9)
  //                       ],
  //                       xValueMapper: (ChartData data, _) => data.x,
  //                       yValueMapper: (ChartData data, _) => data.y,
  //                     )
  //                   ]
  //               )
  //           )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _barChart(),
    );
  }

  Widget _barChart() {
    return SfCartesianChart(
        legend: Legend(isVisible: true),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 20, interval: 5),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<ChartData, String>>[
          // Renders bar chart
          BarSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Color.fromRGBO(8, 142, 255, 1))
        ]);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
