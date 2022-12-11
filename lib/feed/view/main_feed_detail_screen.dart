import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/feed/component/main_feed_detail_card.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/common/layout/bottom_navy_bar.dart';
import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/userinfomodel.dart';
import 'package:howlook/feed/repository/main_feed_repository.dart';

class MainFeedDetailScreen extends StatelessWidget {
  final int npostId; // 포스트 아이디로 특정 게시글 조회

  const MainFeedDetailScreen({
    required this.npostId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<MainFeedDetailModel> getMainFeedDetail() async {
      final dio = Dio();

      dio.interceptors.add(
        CustomInteceptor(storage: storage),
      );

      final repository =
          MainFeedRepository(dio, baseurl: 'http://$API_SERVICE_URI');

      return repository.getMainFeedDetail(NPostId: npostId);
    }

    return DefaultLayout(
      title: '게시글',
      child: FutureBuilder<MainFeedDetailModel>(
        future: getMainFeedDetail(),
        builder: (_, AsyncSnapshot<MainFeedDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Column(
                children: [
                  MainFeedDetailCard.fromModel(model: snapshot.data!),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        // selectedIndex: index,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (int index) {
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
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.message),
            title: Text('Review'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.add_circle_outline_outlined),
            title: Text('Upload'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.theater_comedy_outlined),
            title: Text('Tournament'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.person_outlined),
            title: Text('Profile'),
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
