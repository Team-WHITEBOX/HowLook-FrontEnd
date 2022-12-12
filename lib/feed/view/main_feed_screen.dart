import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/near_feed_screen.dart';
import 'package:howlook/feed/view/second_main_feed_scrren.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'main_feed_category.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  //새로고침
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)); //1초를 기다린 후 새로고침한다.
    //이 부분에 새로고침 시 불러올 기능을 구현한다.
    _refreshController.refreshCompleted();
  }

  //무한 스크롤
  void _onLoading() async {
    await Future.delayed(
        Duration(milliseconds: 1000)); //1초를 기다린 후 새로운 데이터를 불러온다.
    //이부분에 데이터를 계속 불러오는 기능을 구현한다.
    //리스트뷰를 사용한다면 간단한 예로 list.add를 이용하여 데이터를 추가시켜준다.
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'HowLook',
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SecondMainFeedScreen(),
          ),
        ));
  }
}

//
// import 'dart:ui';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:howlook/common/const/data.dart';
// import 'package:howlook/common/layout/default_layout.dart';
// import 'package:howlook/feed/component/main_feed_card.dart';
// import 'package:howlook/feed/model/main_feed_model.dart';
// import 'package:howlook/feed/view/main_feed_detail_screen.dart';
// import 'package:howlook/feed/view/near_feed_screen.dart';
// import 'main_feed_category.dart';
//
// class MainFeedScreen extends StatefulWidget {
//   const MainFeedScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainFeedScreen> createState() => _MainFeedScreenState();
// }
//
// class _MainFeedScreenState extends State<MainFeedScreen> {
//   // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
//   Future<List> paginateMainFeed() async {
//     final dio = Dio();
//     final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
//     int page = 0;
//
//     final resp = await dio.get(
//       // MainFeed 관련 api IP주소 추가하기
//       'http://$API_SERVICE_URI/feed/recent?page=$page',
//       options: Options(
//         headers: {
//           'authorization': 'Bearer $accessToken',
//         },
//       ),
//     );
//     // 응답 데이터 중 data 값만 반환하여 사용하기!!
//     return resp.data['data'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//         title: 'HowLook',
//         actions: <Widget>[
//           IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble)),
//           IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
//         ],
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           child: SafeArea(
//             top: true,
//             bottom: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // 이웃, 모두, 카테고리 버튼 관련
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       TextButton(
//                         style: TextButton.styleFrom(
//                           minimumSize: Size(50, 20),
//                         ),
//                         onPressed: () {
//                           // 임시로 이웃버튼 누르면 각 피드 상세 페이지로 이동할 수 있게 우선 구현
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => NearFeedScreen(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           "이웃",
//                           style: TextStyle(
//                             fontFamily: 'NotoSans',
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       TextButton.icon(
//                         label: Text(''),
//                         icon: Icon(
//                           Icons.filter_alt,
//                           size: 20.0,
//                         ),
//                         // 버튼 누르면 필터 설정 값 불러오기
//                         onPressed: () async {
//                           final result = await Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => CategoryScreen(),
//                             ),
//                           );
//                           // result.returnValue에 카테고리 설정 값 날라옴
//                           // if (result != null) {
//                           //   print("${result.returnValue.isMenChecked}");
//                           // }
//                         },
//                         style: TextButton.styleFrom(
//                             primary: Colors.black, minimumSize: Size(50, 20)),
//                       ),
//                     ],
//                   ),
//                   FutureBuilder<List>(
//                     future: paginateMainFeed(),
//                     builder: (context, AsyncSnapshot<List> snapshot) {
//                       // 에러처리
//                       if (!snapshot.hasData) {
//                         print('error');
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       return ListView.separated(
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (_, index) {
//                           // 받아온 데이터 JSON 매핑하기
//                           // 모델 사용
//                           final item = snapshot.data![index];
//                           final pItem = MainFeedModel.fromJson(json: item);
//                           return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (_) => MainFeedDetailScreen(
//                                     npostId: pItem.npostId,
//                                   ),
//                                 ));
//                               },
//                               child: MainFeedCard.fromModel(model: pItem));
//                         },
//                         separatorBuilder: (_, index) {
//                           return SizedBox(height: 16.0);
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }


// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// TextButton(
// style: TextButton.styleFrom(
// minimumSize: Size(50, 20),
// ),
// onPressed: () {
// // 임시로 이웃버튼 누르면 각 피드 상세 페이지로 이동할 수 있게 우선 구현
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (_) => NearFeedScreen(),
// ),
// );
// },
// child: Text(
// "이웃",
// style: TextStyle(
// fontFamily: 'NotoSans',
// fontSize: 15,
// fontWeight: FontWeight.w500,
// color: Colors.black,
// ),
// ),
// ),
// TextButton.icon(
// label: Text(''),
// icon: Icon(
// Icons.filter_alt,
// size: 20.0,
// ),
// // 버튼 누르면 필터 설정 값 불러오기
// onPressed: () async {
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (_) => CategoryScreen(),
// ),
// );
// // result.returnValue에 카테고리 설정 값 날라옴
// // if (result != null) {
// //   print("${result.returnValue.isMenChecked}");
// // }
// },
// style: TextButton.styleFrom(
// primary: Colors.black, minimumSize: Size(50, 20)),
// ),
// ],
// ),