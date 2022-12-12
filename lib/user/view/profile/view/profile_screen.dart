import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/profile/view/my_feed.dart';
import 'package:howlook/user/view/profile/infoSetup/setting_list.dart';
import 'package:howlook/user/view/profile/view/my_scrap.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/profile/component/other_profile_card.dart';
import 'package:howlook/user/view/profile/model/other_profile_model.dart';

class OtherProfileScreen extends StatefulWidget {
  final String usermid; // 포스트 아이디로 특정 게시글 조회
  const OtherProfileScreen({required this.usermid, Key? key}) : super(key: key);

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  Future<Map<String, dynamic>> paginateProfile() async {
    final dio = Dio();
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
      child: FutureBuilder<Map<String, dynamic>>(
        future: paginateProfile(),
        builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // 에러처리
          if (!snapshot.hasData) {
            print('error');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = snapshot.data!;
          final pItem = OtherProfileModel.fromJson(json: item);
          return OtherProfileCard.fromModel(model: pItem);
        },
      ),
    );
  }
}
