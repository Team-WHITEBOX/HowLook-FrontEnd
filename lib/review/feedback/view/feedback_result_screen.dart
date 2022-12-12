import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/component/feedback_result_card.dart';
import 'package:howlook/review/feedback/model/feedback_result_model.dart';

class FeedbackResult extends ConsumerWidget {
  final int npostId; // 포스트 아이디로 특정 게시글 조회
  const FeedbackResult({required this.npostId, Key? key}) : super(key: key);

  Future<Map<String, dynamic>> FeedbackReviewPage(WidgetRef ref) async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$API_SERVICE_URI/eval/readbypid?NPostId=$npostId',
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
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return DefaultLayout(
        child: FutureBuilder<Map<String, dynamic>>(
            future: FeedbackReviewPage(ref),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final item = FBResultModel.fromJson(
                json: snapshot.data!,
              );

              return FeedbackResultCard.fromModel(model: item);
            }));
  }
}
