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
  String inputMemberPasswordCheck = '';

  @override
  void initState() {
    super.initState();
    // ref.read(SignupProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final List<SignupModel> newMember = ref.watch(SignupProvider);

    // validate
    final formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      if (formKey.currentState!.validate() == false) {
        return;
      } else {
        formKey.currentState!.save();
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
        key: formKey,
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
                  const PageTitle(),
                  const SizedBox(height: 16.0),
                  const PageSubTitle(),
                  const SizedBox(height: 40.0),
                  const PageLabelText(labelText: "계정"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "아이디를 입력해주세요",
                    onSaved: (value) {
                      setState(() {
                        inputMemberId = value;
                      });
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.length < 5) {
                        return "아이디는 5자보다 짧을 수 없습니다 :(";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "비밀번호"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "비밀번호를 입력해주세요",
                    onSaved: (value) {
                      setState(() {
                        inputMemberPassword = value;
                      });
                    },
                    onChanged: (value) {
                      inputMemberPassword = value;
                    },
                    validator: (value) {
                      if (value.length < 8) {
                        return "비밀번호는 8자보다 짧을 수 없습니다 :(";
                      } else if (isValidPwFormat(value.toString()) == false) {
                        return "비밀번호는 문자와 숫자를 모두 포함해야합니다 :(";
                      }
                      return null;
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "비밀번호 확인"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "비밀번호를 한번 더 입력해주세요",
                    onSaved: (value) {
                      setState(() {
                        inputMemberPasswordCheck = value;
                      });
                    },
                    validator: (value) {
                      if (value.toString() != inputMemberPassword) {
                        return "비밀번호를 한번 더 확인해주세요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                  const SizedBox(height: 48.0),
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
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          ref.read(SignupProvider.notifier).addMemberAccount(
                            memberId: inputMemberId,
                            memberPassword: inputMemberPassword,
                          );
                          submit();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
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
          ),
        ),
      ),
    );
  }

  bool isValidPwFormat(String PasswordInput) {
    return RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(PasswordInput);
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "회원가입✏️",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class PageSubTitle extends StatelessWidget {
  const PageSubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "당신의 정보를 기입해주세요 :)",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

class PageLabelText extends StatelessWidget {
  final String labelText;
  const PageLabelText({
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
