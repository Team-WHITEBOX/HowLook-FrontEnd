import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../common/const/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../component/my_profile_card.dart';
import '../model/user_info_model.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  String memberId = '';

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
    memberId = resp.data['data'];
    await storage.write(key: USERMID_KEY, value: memberId);
    return memberId;
  }

  Future<Map<String, dynamic>> paginateProfile() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$API_SERVICE_URI/member/$memberId',
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
      child: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: JWTcheck(),
          builder: (_, AsyncSnapshot<String> snapshot) {
            // 에러처리
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return FutureBuilder<Map<String, dynamic>>(
              future: paginateProfile(),
              builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final item = snapshot.data!;
                final pItem = UserInfoModel.fromJson(item);
                return MainProfileCard.fromModel(model: pItem);
              },
            );
          },
        ),
      ),
    );
  }
}
