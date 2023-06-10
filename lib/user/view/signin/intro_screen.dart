import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';

import '../../../common/const/colors.dart';
import '../../../common/const/data.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/secure_storage/secure_storage.dart';
import '../../../common/view/root_tab.dart';
import '../../../profile/repository/profile_repository.dart';
import '../../provider/sign_in_provider.dart';
import '../../repository/sign_in_repository.dart';
import '../signup/main_signup_screen.dart';
import '../signup/second_signup_screen.dart';
import 'login_screen.dart';

class IntroScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  Future<void> _loginWithWeb() async {
    var code, token;

    if (await isKakaoTalkInstalled()) {
      code = await AuthCodeClient.instance.authorizeWithTalk();
      token = await AuthApi.instance.issueAccessToken(authCode: code);
      print("HELLOHELLOHELLO $token");
    } else {
      code = await AuthCodeClient.instance.authorize();
      token = await AuthApi.instance.issueAccessToken(authCode: code);
    }

    final resp = await ref
        .read(signInRepositoryProvider)
        .loginOauth('kakao', token: token.accessToken);

    final storage = ref.read(secureStorageProvider);
    await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data.accessToken);
    await storage.write(key: REFRESH_TOKEN_KEY, value: resp.data.refreshToken);

    try {
      final resp = await ref.read(profileRepositoryProvider).checkToken();

      await storage.write(key: USERMID_KEY, value: resp.data);

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const RootTab(),
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
    // 일단 정보 받으면 멤버 체크 해야함,
    // 멤버 체크 오류 뜨면 첫 가입이라고 간주하고 회원가입 페이지로 이동
    // 멤버 체크 오류 안 뜨면 해당 토큰 시큐리티 스토리지에 쓰고 루트 페이지로 이동
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(height: 16.0),
              const _SubTitle(),
              const SizedBox(height: 100.0),
              const _LoginText(),
              const SizedBox(height: 100.0),
              TextButton(
                onPressed: _loginWithWeb,
                child: Image.asset('asset/img/logo/kakao_login_large_wide.png'),
              ),
              const SizedBox(height: 32.0),
              const _OR(),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  TextButton(
                    onPressed: () {
                      ref.read(memberIdProvider.notifier).update((state) => "");
                      ref
                          .read(memberPasswordProvider.notifier)
                          .update((state) => "");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MainSignUpScreen(),
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
      "How Look",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "NanumSquareNeo",
        fontSize: 50,
        fontWeight: FontWeight.w900,
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
