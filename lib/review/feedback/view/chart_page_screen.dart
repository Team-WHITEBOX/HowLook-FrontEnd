import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/model/chart_page_model.dart';
import 'package:howlook/review/feedback/component/chart_page_card.dart';

class ChartPage extends StatelessWidget {
  final int npostId; // 포스트 아이디로 특정 게시글 조회
  const ChartPage({required this.npostId, Key? key}) : super(key: key);

  Future<Map<String, dynamic>> FeedbackReviewPage() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$API_SERVICE_URI/eval/getReplyData?NPostId=${npostId}',
      // 특정 API 뒤에 id 값 넘어서 가져가기
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
            future: FeedbackReviewPage(),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final item = ChartModel.fromJson(
                json: snapshot.data!,
              );

              return ChartPageCard.fromModel(model: item);
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