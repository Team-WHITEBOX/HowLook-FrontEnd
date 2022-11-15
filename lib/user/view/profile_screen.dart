import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // deleteToken();
    checkToken();
  }

  void checkToken() async {
    // 스토리지로부터 토큰 받아오기
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MainLoginScreen()),
      );
      /*
      * Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginMainScreen()),
        (route) => false,
      );
      * */
      // 원래는 토큰의 유효성 검사도 해야하지만 일단 11월 13일 기준으로는 생략하기
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
