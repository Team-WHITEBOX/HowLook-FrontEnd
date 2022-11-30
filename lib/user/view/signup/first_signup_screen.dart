import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';


class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({Key? key}) : super(key: key);

  @override
  State<FirstSignupScreen> createState() => _FirstSignupScreenState();
}

class _FirstSignupScreenState extends State<FirstSignupScreen> {
  String mid = '';
  String mpw = '';
  String mpw_check = '';

  @override
  Widget build(BuildContext context) {
    // validate
    final formkey = GlobalKey<FormState>();
    Future<void> _submit() async {
      if (formkey.currentState!.validate() == false) {
        return;
      } else {
        formkey.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SecondSignupScreen(
              mid: this.mid,
              mpw: this.mpw,
            ),
          ),
        );
      }
    }
    return DefaultLayout(
      title: '',
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                top: true,
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 상단 텍스트
                      _Title(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _SubTitle(),
                      const SizedBox(
                        height: 40.0,
                      ),

                      _LabelText(
                        labelText: "계정",
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      // 필요한 정보 받은 텍스트 폼 필드 나열
                      CustomTextFormField(
                        hintText: "아이디를 입력해주세요",
                        onChanged: (String value) {
                          mid = value;
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length < 5) {
                            return "아이디는 5자보다 짧을 수 없습니다 :(";
                          }
                        },
                      ),

                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "비밀번호",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "비밀번호를 입력해주세요",
                        onChanged: (String value) {
                          mpw = value;
                        },
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "비밀번호 확인",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "비밀번호를 한번 더 입력해주세요",
                        onChanged: (String value) {
                          mpw_check = value;
                        },
                        validator: (value) {
                          if (value!.toString() != mpw) {
                            return "비밀번호를 한번 더 확인해주세요 :(";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
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
                              _submit();
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
                              "계속하기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "회원가입✏️",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
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
      "당신의 계정 정보를 기입해주세요 :)",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String labelText;
  const _LabelText({
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$labelText',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

