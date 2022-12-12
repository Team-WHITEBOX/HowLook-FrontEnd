import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/profile/view/my_feed.dart';
import 'package:howlook/user/view/profile/infoSetup/setting_list.dart';
import 'package:howlook/user/view/profile/view/my_scrap.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/profile/model/profile_screen_model.dart';
import 'package:howlook/user/view/profile/component/profile_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<Map<String, dynamic>> paginateProfile() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final usermid = await storage.read(key: USERMID_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/member/${usermid}',
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
            final pItem = MainProfileModel.fromJson(json: item);
            return MainProfileCard.fromModel(model: pItem);
            },
      ),
    );
  }
}
