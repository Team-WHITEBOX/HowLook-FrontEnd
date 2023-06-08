import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/user/view/signin/intro_screen.dart';
import '../../common/const/colors.dart';

class Splash_Screen extends ConsumerStatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends ConsumerState<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    final dio = Dio();
    // 스토리지로부터 토큰 받아오기
    final storage = ref.read(secureStorageProvider);

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // if (mounted) {
    //   if (accessToken != null) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //         builder: (_) => RootTab(),
    //       ),
    //           (route) => false,
    //     );
    //   }
    // }

    // refresh token 로직
    try {
      final resp = await dio.post(
        'http://$API_SERVICE_URI/account/generateToken',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );
      // 발급받은 토큰 저장하기
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);
      // 루트탭으로 이동
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            // builder: (_) => RootTab(),
            builder: (_) => IntroScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "HowLook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
          )),
    );
  }
}
