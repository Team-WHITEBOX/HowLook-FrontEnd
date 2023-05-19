import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/profile/component/profile_scrap_card.dart';
import 'package:howlook/profile/model/scrap_model.dart';
//
// class MyScrap extends ConsumerStatefulWidget {
//   final String memberId; // 포스트 아이디로 특정 게시글 조회
//   const MyScrap({required this.memberId, Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<MyScrap> createState() => _MyScrap();
// }
//
// class _MyScrap extends ConsumerState<MyScrap> {
//   //final List<String> images = <String>['asset/img/Profile/HL1.JPG', 'asset/img/Profile/HL2.JPG', 'asset/img/Profile/HL3.JPG', 'asset/img/Profile/HL4.JPG'];
//
//   // Future<String> JWTcheck() async {
//   //
//   //   final dio = Dio();
//   //   final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
//   //   final resp = await dio.get(
//   //     // MainFeed 관련 api IP주소 추가하기
//   //     'http://$API_SERVICE_URI/member/check',
//   //     options: Options(
//   //       headers: {
//   //         'authorization': 'Bearer $accessToken',
//   //       },
//   //     ),
//   //   );
//   //   print(resp.data['data']);
//   //   userid = resp.data['data'];
//   //   return userid;
//   // }
//
//   Future<Map<String, dynamic>> paginateScrap() async {
//   // Future<List> paginateScrap() async {
//     final dio = Dio();
//     final storage = ref.read(secureStorageProvider);
//     final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
//     final resp = await dio.get(
//       // MainFeed 관련 api IP주소 추가하기
//       'http://$API_SERVICE_URI/member/${widget.memberId}/scrap',
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
//         title: 'Scrap Look',
//         actions: <Widget>[
//           CupertinoButton(
//             onPressed: () => _showActionSheet(context),
//             child: Icon(Icons.more_vert_sharp),
//           ),
//         ],
//         // child: FutureBuilder<List>(
//         //   future: paginateScrap(),
//         //   builder: (_, AsyncSnapshot<List> snapshot) {
//         //     // 에러처리
//         //     if (!snapshot.hasData) {
//         //       print('error');
//         //       return Center(
//         //         child: CircularProgressIndicator(),
//         //       );
//         //     }
//         //     final item = snapshot.data![];
//         //     final pItem = ScrapModel.fromJson(json: item);
//         //     return ScrapCard.fromModel(model: pItem);
//         //   },
//         // ),
//         child: FutureBuilder<Map<String, dynamic>>(
//         // child: FutureBuilder<List>(
//             future: paginateScrap(),
//             // builder: (_, AsyncSnapshot<List> snapshot) {
//               // 에러처리
//             builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
//               if (!snapshot.hasData) {
//                 print('error2');
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               // return ScrapCard.fromModel(model: pItem);
//               // return GridView.builder(
//               //     //physics: const NeverScrollableScrollPhysics(),
//               //     shrinkWrap: true,
//               //     itemCount: snapshot.data!.length,
//               //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               //         crossAxisCount: 3,
//               //         childAspectRatio: 1,
//               //         mainAxisSpacing: 1,
//               //         crossAxisSpacing: 1),
//               //     itemBuilder: (_, int index) {
//               //       final item = snapshot.data![0];
//               //       final pItem = ScrapModel.fromJson(json: item);
//               //       return Container(child: ScrapCard.fromModel(model: pItem));
//               //     });
//               final item = snapshot.data!;
//               final pItem = ScrapModel.fromJson(json: item);
//               return ScrapCard.fromModel(model: pItem);
//
//             }));
//   }
// }
//
// void _showActionSheet(BuildContext context) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoActionSheet(
//       title: const Text('스크랩 선택하기'),
//       actions: <CupertinoActionSheetAction>[
//         CupertinoActionSheetAction(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('선택'),
//         ),
//         CupertinoActionSheetAction(
//           isDestructiveAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('cancle'),
//         ),
//       ],
//     ),
//   );
// }

class MyScrap extends ConsumerStatefulWidget {
  final String memberId; // 포스트 아이디로 특정 게시글 조회
  const MyScrap({required this.memberId, Key? key}) : super(key: key);
  
  @override
  ConsumerState<MyScrap> createState() => _MyScrap();
}

class _MyScrap extends ConsumerState<MyScrap> {

  Future<Map<String, dynamic>> paginateScrap() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$API_SERVICE_URI/member/${widget.memberId}/scrap',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Scrap Look',
        actions: <Widget>[
          CupertinoButton(
            onPressed: () => _showActionSheet(context),
            child: Icon(Icons.more_vert_sharp, color: Colors.black,),
          ),
        ],
        child: FutureBuilder<Map<String, dynamic>>(
            future: paginateScrap(),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final item = snapshot.data!;
              final pItem = ScrapModel.fromJson(json: item);
              return ScrapCard.fromModel(model: pItem);
            }));
  }
}

void _showActionSheet(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('스크랩 선택하기'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('선택'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('cancle'),
        ),
      ],
    ),
  );
}
