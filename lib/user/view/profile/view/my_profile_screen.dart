import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/profile/model/my_profile_screen_model.dart';
import 'package:howlook/user/view/profile/component/my_profile_card.dart';

class MyProfileScreen extends ConsumerStatefulWidget {

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {

  String userid = '';

  Future<String> JWTcheck() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/member/check',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    userid = resp.data['data'];
    await storage.write(key: USERMID_KEY, value: userid);
    return userid;
  }


  Future<Map<String, dynamic>> paginateProfile() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$API_SERVICE_URI/member/$userid',
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
      child: FutureBuilder<String>(
        future: JWTcheck(),
        builder: (_, AsyncSnapshot<String> snapshot) {
          // 에러처리
          if (!snapshot.hasData) {
            print('error1'); //에러 안남
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return FutureBuilder<Map<String, dynamic>>(
            future: paginateProfile(),
            builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              // 에러처리
              if (!snapshot.hasData) {
                print('error3');
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final item = snapshot.data!;
              final pItem = MainProfileModel.fromJson(json: item);
              return MainProfileCard.fromModel(model: pItem);
            }
            );
        },
      ),
    );
  }
}
