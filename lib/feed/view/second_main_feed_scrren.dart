import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SecondMainFeedScreen extends StatefulWidget {
  const SecondMainFeedScreen({Key? key}) : super(key: key);

  @override
  State<SecondMainFeedScreen> createState() => _SecondMainFeedScreenState();
}

class _SecondMainFeedScreenState extends State<SecondMainFeedScreen> {
  // ScrollController _controller;
  final scrollController = ScrollController();
  // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
  Future<List> paginateMainFeed() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int page = 0;

    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/feed/recent?page=$page',
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
    return SingleChildScrollView(
      controller: scrollController,
      child: FutureBuilder<List>(
        future: paginateMainFeed(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          // 에러처리
          if (!snapshot.hasData) {
            print('error');
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
              final pItem = MainFeedModel.fromJson(json: item);
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MainFeedDetailScreen(
                          npostId: pItem.npostId,
                        ),
                      ),
                    );
                  },
                  child: MainFeedCard.fromModel(model: pItem));
            },
            separatorBuilder: (_, index) {
              return SizedBox(height: 16.0);
            },
          );
        },
      ),
    );
  }
}
