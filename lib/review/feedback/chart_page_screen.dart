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

  @override
  Widget build(BuildContext context) {
    final List<ReviewScore> chartData = <ReviewScore>[
      ReviewScore('9-10', 9, 6),
      ReviewScore('7-8', 2, 5),
      ReviewScore('5-6', 4, 9),
      ReviewScore('3-4', 7, 3),
      ReviewScore('1-2', 5, 3),
    ];

    return Container(
              height: MediaQuery.of(context).size.width * 0.8,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(
                        minimum: 0, maximum: 10, interval: 10),
                    series: <CartesianSeries>[
                      BarSeries<ReviewScore, String>(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.pinkAccent,
                                Color(0xFFD07AFF),
                              ]),
                          name: 'Female',
                          dataSource: chartData,
                          xValueMapper: (ReviewScore data, _) => data.score,
                          yValueMapper: (ReviewScore data, _) => data.Female
                      ),
                      BarSeries<ReviewScore, String>(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.blueAccent,
                                Color(0xFFa6ceff),
                              ]),
                          name: 'Male',
                          dataSource: chartData,
                          xValueMapper: (ReviewScore data, _) => data.score,
                          yValueMapper: (ReviewScore data, _) => data.Male
                      )
                    ]
                )

    );
  }
}

//data type.
class ReviewScore {
  final String score;
  final int Female;
  final int Male;

  ReviewScore(this.score, this.Female, this.Male);
}