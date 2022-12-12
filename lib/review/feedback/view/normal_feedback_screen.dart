import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/feedback_result_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/model/normal_feedback_model.dart';
import 'package:howlook/review/feedback/component/normal_feedback_card.dart';

class NormalFeedback extends ConsumerStatefulWidget {
  const NormalFeedback({Key? key}) : super(key: key);

  @override
  ConsumerState<NormalFeedback> createState() => _NormalFeedbackState();
}

class _NormalFeedbackState extends ConsumerState<NormalFeedback> {
  // final List<String> images = <String>[
  //   'asset/img/Profile/HL1.JPG',
  //   'asset/img/Profile/HL2.JPG',
  //   'asset/img/Profile/HL3.JPG',
  //   'asset/img/Profile/HL4.JPG'
  // ];

  String userid = '';

  Future<String> JWTcheck() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/member/check',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    userid = resp.data['data'];
    return userid;
  }

  Future<List> paginateNormalReview() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final usermid = await storage.read(key: USERMID_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/eval/readbyuid?UserID=$userid',
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
        child: SingleChildScrollView(
      child: SafeArea(
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            FutureBuilder<String>(
                future: JWTcheck(),
                builder: (_, AsyncSnapshot<String> snapshot) {
                  // 에러처리
                  if (!snapshot.hasData) {
                    print('error1'); //에러 안남
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return FutureBuilder<List>(
                      future: paginateNormalReview(),
                      builder: (_, AsyncSnapshot<List> snapshot) {
                        // 에러처리
                        if (!snapshot.hasData) {
                          print('error');
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 400,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Swiper(
                              autoplay: false,
                              scale: 0.9,
                              viewportFraction: 0.8,
                              // pagination: SwiperPagination(
                              //   alignment: Alignment.bottomCenter
                              // ),
                              // control: SwiperControl(color: Colors.white),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = snapshot.data![index];
                                final pItem =
                                    NormalReviewModel.fromJson(json: item);
                                return NormalReviewCard.fromModel(model: pItem);
                              },
                            ),
                          ),
                        );
                      });
                })
          ]))),
    ));
  }
}
