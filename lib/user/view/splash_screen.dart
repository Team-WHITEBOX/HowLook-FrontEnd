import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/user/view/signin/intro_screen.dart';

import '../../common/const/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../../profile/repository/profile_repository.dart';
import '../model/token/token_model.dart';
import '../repository/sign_in_repository.dart';
import 'signup/second_signup_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // deleteToken();
    checkToken();
  }

  // 토큰 삭제하는 함수
  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);
    await storage.deleteAll();
  }

  void checkToken() async {
    final storage = ref.read(secureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      if(!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => IntroScreen(),
        ),
            (route) => false,
      );
      return;
    }

    try {
      final code = await ref.read(profileRepositoryProvider).checkToken();
      // 에러 뜨면 소셜 로그인이라는 것
      // 200이면 바로 진입
      // 200이 아니면 리프레쉬 하기
      if (code.status != 200) {
        final result = await ref.read(signInRepositoryProvider).refreshToken(
            tokenModel: TokenModel(
                accessToken: accessToken, refreshToken: refreshToken));

        await storage.write(
            key: ACCESS_TOKEN_KEY, value: result.data.accessToken);
        await storage.write(
            key: REFRESH_TOKEN_KEY, value: result.data.refreshToken);
      }
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => IntroScreen(),
          // builder: (_) => RootTab(),
        ),
            (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SecondSignupScreen(isSocial: true),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            "HowLook",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
