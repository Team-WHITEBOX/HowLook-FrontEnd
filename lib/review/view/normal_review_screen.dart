import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/model/review_model.dart';
import 'package:howlook/review/component/nomal_review_card.dart';

class NormalReview extends ConsumerWidget {
  const NormalReview({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> paginateNormalReview(WidgetRef ref) async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/eval/readNextEval',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: 'Normal Review',
      child: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: paginateNormalReview(ref),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final item = snapshot.data!; //인덱스값
              final pItem = ReviewModel.fromJson(json: item);
              return NormalReviewCard.fromModel(model: pItem);
            },
          ),
        ),
      ),
    );
  }
}
