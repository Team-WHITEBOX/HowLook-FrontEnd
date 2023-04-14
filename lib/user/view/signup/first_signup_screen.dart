import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/user/model/signup_model.dart';
import 'package:howlook/user/provider/signup_provider.dart';

class FirstSignupScreen extends ConsumerStatefulWidget {
  const FirstSignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FirstSignupScreen> createState() => _FirstSignupScreenState();
}

class _FirstSignupScreenState extends ConsumerState<FirstSignupScreen> {
  String inputMemberId = '';
  String inputMemberPassword = '';
  String inputMemberPassword_check = '';

  @override
  Widget build(BuildContext context) {
    final List<SignupModel> newMember = ref.watch(SignupProvider);

    // validate
    final formkey = GlobalKey<FormState>();
    Future<void> _submit() async {
      if (formkey.currentState!.validate() == false) {
        return;
      } else {
        formkey.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SecondSignupScreen(),
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

                      CustomTextFormField(
                        hintText: "아이디를 입력해주세요",
                        onChanged: (String value) {
                          inputMemberId = value;
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length < 5) {
                            return "아이디는 5자보다 짧을 수 없습니다 :(";
                          }
                          //아이디 중복 조회
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
                          inputMemberPassword = value;
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "비밀번호는 8자보다 짧을 수 없습니다 :(";
                          } else if (isValidPwFormat(value.toString()) ==
                              false) {
                            return "비밀번호는 문자와 숫자를 모두 포함해야합니다 :(";
                          }
                        },
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
                          inputMemberPassword_check = value;
                        },
                        validator: (value) {
                          if (value!.toString() != inputMemberPassword) {
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
                            ref.read(SignupProvider.notifier).addMemberAccount(
                                memberId: inputMemberId,
                                memberPassword: inputMemberPassword);

                            print(newMember[0].memberId);
                            print(newMember[0].memberPassword);
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

  bool isValidPwFormat(String PasswordInput) {
    return RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$')
        .hasMatch(PasswordInput);
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
