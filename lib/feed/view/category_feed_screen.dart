import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/view/main_feed_category.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';

class CategoryFeedScreen extends StatelessWidget {
  Arguments arguments;

  CategoryFeedScreen({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
  Future<List> paginateMainFeed() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int page = 0;
    String gender;

    if (arguments.isMenChecked)
      gender = "M";
    else
      gender = "F";

    print('http://3.34.164.14:8080/feed/search?amekaji=${arguments.isAmericanCasualChecked}&casual=${arguments.isCasualChecked}&guitar=${arguments.isEtcChecked}&minimal=${arguments.isMinimalChecked}&sporty=${arguments.isSportyChecked}&street=${arguments.isStreetChecked}&heightHigh=${arguments.maxHeight}&heightLow=${arguments.minHeight}&weightHigh=${arguments.maxWeight}&weightLow=${arguments.minWeight}&gender=${gender}&page=${page}');

    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://3.34.164.14:8080/feed/search?amekaji=${arguments.isAmericanCasualChecked}&casual=${arguments.isCasualChecked}&guitar=${arguments.isEtcChecked}&minimal=${arguments.isMinimalChecked}&sporty=${arguments.isSportyChecked}&street=${arguments.isStreetChecked}&heightHigh=${arguments.maxHeight}&heightLow=${arguments.minHeight}&weightHigh=${arguments.maxWeight}&weightLow=${arguments.minWeight}&gender=${gender}&page=${page}',
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
      title: '검색 기반 게시글',
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder<List>(
              future: paginateMainFeed(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                // 에러처리
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    // 받아온 데이터 JSON 매핑하기
                    // 모델 사용
                    final item = snapshot.data![index];
                    final pItem = MainFeedModel.fromJson(item);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MainFeedDetailScreen(
                            npostId: pItem.npostId,
                          ),
                        ));
                      },
                      child: MainFeedCard.fromModel(model: pItem),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 16.0);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
