import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/feed/component/main_feed_detail_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';

class MainFeedDetailScreen extends StatelessWidget {
  final int npostId; // 포스트 아이디로 특정 게시글 조회
  const MainFeedDetailScreen({required this.npostId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoModel userInfoModel = UserInfoModel(
      memberId: '김진범',
      memberNickName: 'df',
      memberHeight: 200,
      memberWeight: 100,
      profilePhotoId: 0,
    );

    List<String> list = [
      'asset/img/HL1.JPG',
      'asset/img/HL2.JPG',
      'asset/img/HL3.JPG',
    ];

    Future<Map<String, dynamic>> getMainFeedDetail() async {
      final dio = Dio();
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      final resp = await dio.get(
        'http://$API_SERVICE_URI/feed/readbypid?NPostId=$npostId',
        // 특정 API 뒤에 id 값 넘어서 가져가기
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
      );
      return resp.data['data'];
    }

    return DefaultLayout(
      title: '게시글',
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              MainFeedDetailCard(
                npostId: 1,
                userPostInfo: userInfoModel,
                photoPaths: list,
                photoCnt: 1,
                likeCount: 1,
                content: "1",
                commentCount: 1,
              ),
              //밑에 사진 인디케이터
            ],
          ),
        ),
      ),
      // child: FutureBuilder<Map<String, dynamic>>(
      //   future: getMainFeedDetail(),
      //   builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     print(snapshot.data!);
      //     final item = MainFeedDetailModel.fromJson(
      //       json: snapshot.data!,
      //     );
      //
      //     return SingleChildScrollView(
      //       child: SafeArea(
      //         top: true,
      //         bottom: false,
      //         child: Column(
      //           children: [
      //             MainFeedDetailCard.fromModel(model: item),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: BODY_TEXT_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        // BottomNavigationBarType <- 밑에 아이콘 변화하는 애니메이션 지정
        type: BottomNavigationBarType.fixed,
        // 현재 탭 가리키는 코드, controller의 index를 애니메이션 적용
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RootTab(
                    indexId: 0,
                  ),
                ),
                (route) => false,
              );
              break;
            case 1:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RootTab(
                    indexId: 1,
                  ),
                ),
                (route) => false,
              );
              break;
            case 2:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RootTab(
                    indexId: 2,
                  ),
                ),
                (route) => false,
              );
              break;
            case 3:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RootTab(
                    indexId: 3,
                  ),
                ),
                (route) => false,
              );
              break;
            case 4:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => RootTab(
                    indexId: 4,
                  ),
                ),
                (route) => false,
              );
              break;
          }
        },
        // 여기 안에는 밑의 네비게이션 바의 내용을 가리키는 곳
        items: [
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '?'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: '업로드'),
          BottomNavigationBarItem(
              icon: Icon(Icons.theater_comedy_outlined), label: '토너먼트'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
    );
  }
}
