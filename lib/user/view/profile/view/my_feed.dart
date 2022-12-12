import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/profile/component/feed_card.dart';
import 'package:howlook/user/view/profile/model/feed_model.dart';

class MyFeed extends StatefulWidget {
  final String usermid; // 포스트 아이디로 특정 게시글 조회
  const MyFeed({required this.usermid, Key? key}) : super(key: key);

  @override
  ConsumerState<MyFeed> createState() => _MyFeed();
}

class _MyFeed extends ConsumerState<MyFeed> {
  //final List<String> images = <String>['asset/img/Profile/HL1.JPG', 'asset/img/Profile/HL2.JPG', 'asset/img/Profile/HL3.JPG', 'asset/img/Profile/HL4.JPG'];

  Future<Map<String, dynamic>> paginateMyFeed() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/member/${widget.usermid}',
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
        title: 'My Look',
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: FutureBuilder<Map<String, dynamic>>(
                future: paginateMyFeed(),
                builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // 에러처리
                  if (!snapshot.hasData) {
                    print('error');
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // return GridView.custom(
                  //     shrinkWrap: true,
                  //     gridDelegate: SliverQuiltedGridDelegate(
                  //       crossAxisCount: 3,
                  //       mainAxisSpacing: 1,
                  //       crossAxisSpacing: 1,
                  //       repeatPattern: QuiltedGridRepeatPattern.inverted,
                  //       pattern: [
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(2, 2),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //         QuiltedGridTile(1, 1),
                  //       ],
                  //     ),
                  //     childrenDelegate: SliverChildBuilderDelegate(
                  //       childCount: snapshot.data!.length,
                  //         (_, int index) {
                  //           final item = snapshot.data![index];
                  //           final pItem = MyFeedModel.fromJson(json: item);
                  //       return MyFeedCard.fromModel(model: pItem);
                  //     }));
                  final item = snapshot.data!;
                  final pItem = MyFeedModel.fromJson(json: item);
                  return MyFeedCard.fromModel(model: pItem);
                })));
  }
}
