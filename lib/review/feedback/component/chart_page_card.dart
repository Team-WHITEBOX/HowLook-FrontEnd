import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/model/chart_page_model.dart';

class ChartPageCard extends StatefulWidget {
  // 남자 차트
  final List<dynamic> maleCounts;
  // 여자 차트
  final List<dynamic> femaleCounts;

  ChartPageCard({
    Key? key,
    required this.maleCounts,
    required this.femaleCounts,
  }): super(key: key);

  factory ChartPageCard.fromModel({
    required ChartModel model,
  }) {
    return ChartPageCard(
      maleCounts: model.maleCounts,
      femaleCounts: model.femaleCounts,
    );
  }

  @override
  State<ChartPageCard> createState() => _ChartPageCardState();
}

class _ChartPageCardState extends State<ChartPageCard> {


  @override
  Widget build(BuildContext context) {
    final List<ReviewScore> chartData = <ReviewScore>[
      ReviewScore('9-10', widget.maleCounts[4], widget.femaleCounts[4]),
      ReviewScore('7-8', widget.maleCounts[3], widget.femaleCounts[3]),
      ReviewScore('5-6', widget.maleCounts[2], widget.femaleCounts[2]),
      ReviewScore('3-4', widget.maleCounts[1], widget.femaleCounts[1]),
      ReviewScore('1-2', widget.maleCounts[0], widget.femaleCounts[0]),
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
  final dynamic Female;
  final dynamic Male;

  ReviewScore(this.score, this.Female, this.Male);
}