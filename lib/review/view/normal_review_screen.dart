import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/model/normal_review_model.dart';
import 'package:howlook/review/component/nomal_review_card.dart';

class NormalReview extends StatelessWidget {
  const NormalReview({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> paginateNormalReview() async {
    final dio = Dio();
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
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Normal Review',
        child: SingleChildScrollView(
            child: SafeArea(
                child: FutureBuilder<Map<String, dynamic>>(
                    future: paginateNormalReview(),
                    builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final item = snapshot.data!; //인덱스값
                      final pItem = NRModel.fromJson(json: item);
                      return NormalReviewCard.fromModel(model: pItem);
                    }))));
  }
}
