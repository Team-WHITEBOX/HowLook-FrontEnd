import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/user/view/signup/first_signup_screen.dart';
import 'package:howlook/user/view/signup/main_signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      title: '',
      child: SingleChildScrollView(
        // 밑의 자식 스크롤 가능하게 만들기
        // 키보드 올라와있을 때, 스크롤 등의 행위를 하면 키보드가 사라짐 - UI/UX 꿀팁
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            // 컬럼 위에다가 패딩 넣어서
            // 양쪽으로 16씩 땡기기 - 답답함 줄어듬
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 상단 텍스트
                _Title(),
                const SizedBox(height: 16.0), // 공백 삽입
                _SubTitle(),
                const SizedBox(height: 80.0), // 공백 삽입
                _LoginText(),
                const SizedBox(height: 30.0), // 공백 삽입

                // 아이디 및 로그인 박스
                CustomTextFormField(
                  hintText: "아이디를 입력해주세요",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0), // 공백 삽입
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 30.0), // 공백 삽입
                // 로그인 및 회원가입 버튼
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFD07AFF),
                        Color(0xFFa6ceff),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      // ID:비밀번호 형태
                      final rawString = '$username:$password';

                      // ** 중요한 코드 ** -> convert to base 64
                      // Flutter에서 ID, PW를 Base64 인코딩을 정의하는 코드
                      // Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      // Flutter에서 ID, PW를 실제로 Base64로 인코딩하는 코드
                      // String token = stringToBase64.encode(rawString);

                      /*
                        final resp = await dio.post(
                          'http://$ip/auth/login',
                          options: Options(headers: {
                            'authorization': 'Basic $token',
                          }),
                        );
                         */

                      // 일단 여기서는 간단하게 username과 password를
                      // 다음과 같은 json 형태로 구현하기로 약속
                      final resp = await dio.post(
                        'http://$API_SERVICE_URI/account/generateToken',
                        data: {
                          'memberID': username,
                          'memberPassword': password,
                        },
                      );

                      final refreshToken = resp.data['refreshToken'];
                      final accessToken = resp.data['accessToken'];

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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      minimumSize: Size(100, 50),
                    ),
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0), // 공백 삽입
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MainSignupScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
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
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: PRIMARY_COLOR,
      ),
    );
  }
}
