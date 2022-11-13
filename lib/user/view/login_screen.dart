import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView( // 밑의 자식 스크롤 가능하게 만들기
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding( // 컬럼 위에다가 패딩 넣어서
            // 양쪽으로 16씩 땡기기 - 답답함 줄어듬
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 상단 텍스트
                _Title(),
                const SizedBox(height: 16.0), // 공백 삽입
                _SubTitle(),

                const SizedBox(height: 100.0), // 공백 삽입
                _LoginText(),
                const SizedBox(height: 30.0), // 공백 삽입

                // 아이디 및 로그인 박스
                CustomTextFormField(
                  hintText: "아이디를 입력해주세요",
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 16.0), // 공백 삽입
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (String value) {},
                  obscureText: true,
                ),
                const SizedBox(height: 14.0), // 공백 삽입
                // 로그인 및 회원가입 버튼
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ))
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
