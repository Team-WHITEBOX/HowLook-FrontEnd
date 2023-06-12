import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/component/chart_page_card.dart';

import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../provider/normal_result_provider.dart';

class ChartPage extends ConsumerWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회
  ChartPage({required this.postId, Key? key}) : super(key: key);

  late Future<NormalResultModel> _NormalChartFuture;

  Future<void> _fetchNormalChart(WidgetRef ref) async {
    final repository = ref.read(NormalResultProvider.notifier);
    _NormalChartFuture = repository.getResultData(postId: postId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchNormalChart(ref);

    return FutureBuilder<NormalResultModel>(
        future: _NormalChartFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final item = snapshot.data!.data;
            return ChartPageCard.fromModel(model: item);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

//     return Container(
//               height: MediaQuery.of(context).size.width * 0.8,
//                 child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     primaryYAxis: NumericAxis(
//                         minimum: 0, maximum: 10, interval: 10),
//                     series: <CartesianSeries>[
//                       BarSeries<ReviewScore, String>(
//                           gradient: const LinearGradient(
//                               begin: Alignment.bottomRight,
//                               end: Alignment.topLeft,
//                               colors: [
//                                 Colors.pinkAccent,
//                                 Color(0xFFD07AFF),
//                               ]),
//                           name: 'Female',
//                           dataSource: chartData,
//                           xValueMapper: (ReviewScore data, _) => data.score,
//                           yValueMapper: (ReviewScore data, _) => data.Female
//                       ),
//                       BarSeries<ReviewScore, String>(
//                           gradient: const LinearGradient(
//                               begin: Alignment.bottomRight,
//                               end: Alignment.topLeft,
//                               colors: [
//                                 Colors.blueAccent,
//                                 Color(0xFFa6ceff),
//                               ]),
//                           name: 'Male',
//                           dataSource: chartData,
//                           xValueMapper: (ReviewScore data, _) => data.score,
//                           yValueMapper: (ReviewScore data, _) => data.Male
//                       )
//                     ]
//                 )
//
//     );
//   }
// }
//
// //data type.
// class ReviewScore {
//   final String score;
//   final int Female;
//   final int Male;
//
//   ReviewScore(this.score, this.Female, this.Male);
// }
