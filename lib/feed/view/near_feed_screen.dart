import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';

class NearFeedScreen extends StatefulWidget {
  const NearFeedScreen({Key? key}) : super(key: key);

  @override
  State<NearFeedScreen> createState() => _NearFeedScreenState();
}

class _NearFeedScreenState extends State<NearFeedScreen> {
  // 위치 정보 불러오기
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
  Future<List> paginateMainFeed() async {
    var gps = await getCurrentLocation();
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int page = 0;

    print('http://$API_SERVICE_URI/feed/near?page=$page&latitude=${gps.latitude}&longitude=${gps.longitude}');
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/feed/near?page=$page&latitude=${gps.latitude}&longitude=${gps.longitude}',
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
      title: '지역 기반 게시글',
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

  SliverPadding renderFeed({required MainFeedModel feeds}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = feeds;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MainFeedDetailScreen(
                    npostId: feeds.npostId,
                  ),
                ));
              },
              child: MainFeedCard.fromModel(model: model),
            ),
          );
        }, childCount: 3),
      ),
    );
  }

  // SliverToBoxAdapter renderTop({
  //   required MainFeedModel model,
  // }) {
  //   SliverToBoxAdapter(
  //     child: MainFeedCard.fromModel(
  //       model: model,
  //     ),
  //   );
  // }
}

//       child: SingleChildScrollView(
//         child: SafeArea(
//           top: true,
//           bottom: false,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: FutureBuilder<List>(
//               future: paginateMainFeed(),
//               builder: (context, AsyncSnapshot<List> snapshot) {
//                 // 에러처리
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return ListView.separated(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (_, index) {
// // 받아온 데이터 JSON 매핑하기
//                     // 모델 사용
//                     final item = snapshot.data![index];
//                     final pItem = MainFeedModel.fromJson(json: item);
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => MainFeedDetailScreen(
//                             npostId: pItem.npostId,
//                           ),
//                         ));
//                       },
//                       child: MainFeedCard.fromModel(model: pItem),
//                     );
//                   },
//                   separatorBuilder: (_, index) {
//                     return SizedBox(height: 16.0);
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
