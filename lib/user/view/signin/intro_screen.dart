import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/kakao_login.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/user/view/signin/login_screen.dart';
import 'package:howlook/user/view/signup/main_signup_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'package:uuid/uuid.dart';

class IntroScreen extends ConsumerWidget {
  final dio = Dio();

  // Future<UserCredential> loginWithKakao() async {
  //   final clientState = const Uuid().v4();
  //   final authUri = Uri.https('kauth.kakao.com', '/oauth/authorize', {
  //     'response_type': 'code',
  //     'client_id': 'eaea17f771b2bbca9bb72a90b36e5244',
  //     'response_mode': 'form_post',
  //     'redirect_uri': '$API_SERVICE_URI/account/oauth/kakao',
  //     'scope': 'account_email profile',
  //     'state': clientState,
  //   });
  //   final authResponse = await FlutterWebAuth.authenticate(
  //       url: authUri.toString(),
  //       callbackUrlScheme: "webauthcallback"
  //   );
  //   final code = Uri.parse(authResponse).queryParameters['code'];
  //   final tokenUri = Uri.https('kauth.kakao.com', '/oauth/token', {
  //     'grant_type': 'authorization_code',
  //     'client_id': 'eaea17f771b2bbca9bb72a90b36e5244',
  //     'redirect_uri': '$API_SERVICE_URI/account/oauth/kakao',
  //     'code': code,
  //   });
  //   final tokenResult = await http.post(tokenUri);
  //   final accessToken = json.decode(tokenResult.body)['access_token'];
  //   final response = await http.get(
  //       Uri.parse('$API_SERVICE_URI/kakao/token?accessToken=$accessToken')
  //   );
  //   return await FirebaseAuth.instance.signInWithCustomToken(response.body);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(height: 16.0), // 공백 삽입
              const _SubTitle(),
              const SizedBox(height: 10.0), // 공백 삽입
              Image.asset(
                'asset/img/logo/hihi.png',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
              ),
              const _LoginText(),
              const SizedBox(height: 50.0), // 공백 삽입
              // 카카오 로그인 버튼
              TextButton(
                onPressed: () async {

                },
                child: Image.asset('asset/img/logo/kakao_login_large_wide.png'),
              ),
              const SizedBox(height: 32.0), // 공백 삽입
              const _OR(),
              const SizedBox(height: 32.0), // 공백 삽입
              // 가로로 "로그인 | 회원가입" 을 구현하기 위한 Row 삽입
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 로그인 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 12,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  const _Board(),
                  // 회원가입 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MainSignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 12,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hello👋",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "만나서 반가워요 :)\n로그인을 해서 다양한 패션을 만나보세요!",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "HowLook",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w700,
        color: PRIMARY_COLOR,
      ),
    );
  }
}

class _OR extends StatelessWidget {
  const _OR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "  OR   ",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: PRIMARY_COLOR,
      ),
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "|",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: PRIMARY_COLOR,
      ),
    );
  }
}
