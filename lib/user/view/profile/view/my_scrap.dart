import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/profile/component/scrap_card.dart';
import 'package:howlook/user/view/profile/model/scrap_model.dart';

class MyScrap extends StatefulWidget {
  const MyScrap({Key? key}) : super(key: key);

  @override
  State<MyScrap> createState() => _MyScrap();
}

class _MyScrap extends State<MyScrap> {
  //final List<String> images = <String>['asset/img/Profile/HL1.JPG', 'asset/img/Profile/HL2.JPG', 'asset/img/Profile/HL3.JPG', 'asset/img/Profile/HL4.JPG'];

  Future<List> paginateScrap() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final usermid = await storage.read(key: USERMID_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/member/${usermid}/scrap',
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
        title: 'Scrap Look',
        actions: <Widget>[
          CupertinoButton(
            onPressed: () => _showActionSheet(context),
            child: Icon(Icons.more_vert_sharp),
          ),
        ],
        // child: FutureBuilder<List>(
        //   future: paginateScrap(),
        //   builder: (_, AsyncSnapshot<List> snapshot) {
        //     // 에러처리
        //     if (!snapshot.hasData) {
        //       print('error');
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     final item = snapshot.data![];
        //     final pItem = ScrapModel.fromJson(json: item);
        //     return ScrapCard.fromModel(model: pItem);
        //   },
        // ),
        child: FutureBuilder<List>(
            future: paginateScrap(),
            builder: (_, AsyncSnapshot<List> snapshot) {
              // 에러처리
              if (!snapshot.hasData) {
                print('error');
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //return ScrapCard.fromModel(model: pItem);
              return GridView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemBuilder: (_, int index) {
                    final item = snapshot.data![index];
                    final pItem = ScrapModel.fromJson(json: item);
                    return Container(child: ScrapCard.fromModel(model: pItem));
                  });
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
