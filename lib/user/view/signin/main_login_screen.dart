import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/common/view/kakao_login.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/user/view/signin/login_screen.dart';
import 'package:howlook/user/view/signup/main_signup_screen.dart';
import 'package:dio/dio.dart';

class MainLoginScreen extends ConsumerWidget {
  // const MainLoginScreen({Key? key}) : super(key: key);

  final dio = Dio();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '',
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(),
              const SizedBox(height: 16.0), // 공백 삽입
              _SubTitle(),
              const SizedBox(height: 10.0), // 공백 삽입
              Image.asset(
                'asset/img/logo/hihi.png',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
              ),
              _LoginText(),
              const SizedBox(height: 50.0), // 공백 삽입
              // 카카오 로그인 버튼
              TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KakaoLoginScreen(),
                    ),
                  );
                  List<String> tokens = result.split(' ');

                  final refreshToken =
                      tokens[1].substring(0, tokens[1].length - 1);
                  final accessToken =
                      tokens[3].substring(0, tokens[3].length - 1);

                  print(accessToken);

                  final storage = ref.read(secureStorageProvider);

                  await storage.write(
                      key: REFRESH_TOKEN_KEY, value: refreshToken);
                  await storage.write(
                      key: ACCESS_TOKEN_KEY, value: accessToken);

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => RootTab(),
                    ),
                    (route) => false,
                  );
                },
                child: Image.asset('asset/img/logo/kakao_login_large_wide.png'),
              ),
              const SizedBox(height: 32.0), // 공백 삽입
              _OR(),
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
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 12,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  _board(),
                  // 회원가입 버튼
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MainSignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: 12,
                          color: PRIMARY_COLOR,
                        ),
                      )),
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
    return Text(
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
    return Text(
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
    return Text(
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
    return Text(
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

class _board extends StatelessWidget {
  const _board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "|",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: PRIMARY_COLOR,
      ),
    );
  }
}
