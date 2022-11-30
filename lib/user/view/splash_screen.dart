import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signin/login_screen.dart';
import '../../common/const/colors.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    //deleteToken();
    checkToken();
  }

  // 토큰 삭제하는 함수
  void deleteToken() async {
    await storage.deleteAll();
  }

  // initState() 안에서는 async가 안되기 때문에 토큰 체크 함수를 따로 빼서 해야함
  void checkToken() async {
    final dio = Dio();
    // 스토리지로부터 토큰 받아오기
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // refresh token 로직
    try {
      final resp =
          await dio.post('http://$API_SERVICE_URI/account/generateToken',
              options: Options(headers: {
                'authorization': 'Bearer $refreshToken',
              }));
      // 발급받은 토큰 저장하기
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);
      // 루트탭으로 이동
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RootTab(),
        ),
        (route) => false,
      );
    } catch (e) { //
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => MainLoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 16.0),
              CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
