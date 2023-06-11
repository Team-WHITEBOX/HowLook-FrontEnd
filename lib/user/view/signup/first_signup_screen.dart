import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/component/cust_textform_filed.dart';
import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../provider/sign_up_provider.dart';
import '../../repository/sign_up_repository.dart';
import 'second_signup_screen.dart';

class FirstSignUpScreen extends ConsumerStatefulWidget {
  const FirstSignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FirstSignUpScreen> createState() => _FirstSignUpScreenState();
}

class _FirstSignUpScreenState extends ConsumerState<FirstSignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  bool _isValid() {
    final newMember = ref.watch(signUpProvider);

    return (newMember.memberId!.isNotEmpty &&
            newMember.memberPassword!.isNotEmpty &&
            newMember.memberPasswordCheck!.isNotEmpty)
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    final newMember = ref.watch(signUpProvider);
    final idCheck = ref.watch(idCheckProvider);

    return DefaultLayout(
      title: '',
      leading: IconButton(
        onPressed: () {
          ref.read(signUpProvider.notifier).addMemberId(memberId: "");
          ref
              .read(signUpProvider.notifier)
              .addMemberPassword(memberPassword: "");
          ref
              .read(signUpProvider.notifier)
              .addMemberPasswordCheck(memberPasswordCheck: "");
          ref.read(idCheckProvider.notifier).update((state) => false);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
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
                  PageTitle(),
                  const SizedBox(height: 16.0),
                  PageSubTitle(),
                  const SizedBox(height: 40.0),
                  PageLabelText("계정"),
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        onSaved: (value) {},
                        onChanged: (value) {
                          ref
                              .read(signUpProvider.notifier)
                              .addMemberId(memberId: value);
                          ref
                              .read(idCheckProvider.notifier)
                              .update((state) => false);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (isValidId(value.toString())) {
                            return null;
                          } else {
                            return "잘못된 아이디 형식입니다 :(";
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 2,
                            right: 20,
                            bottom: 10,
                            top: 10,
                          ),
                          hintText: "아이디를 입력해주세요",
                          helperText: "소문자, 숫자 포함 5자 이상 15자 이내로 입력하세요.",
                          fillColor: Colors.black,
                          hintStyle:
                              TextStyle(color: Colors.black45, fontSize: 14.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: INPUT_BORDER_COLOR, width: 1.5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: INPUT_BORDER_COLOR,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 1,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (newMember.memberId!.length > 4) {
                              final code = await ref
                                  .read(signUpRepositoryProvider)
                                  .idCheck(memberId: newMember.memberId!);
                              if (code.data) {
                                ref
                                    .read(idCheckProvider.notifier)
                                    .update((state) => true);
                                if (!mounted) return;
                                showOkAlertDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    title: "아이디 사용 가능",
                                    message: "해당 아이디는 사용 가능합니다.");
                              } else {
                                if (!mounted) return;
                                showOkAlertDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    title: "아이디 사용 불가능",
                                    message: "해당 아이디는 사용이 불가능합니다.");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: newMember.memberId!.length > 4 && idCheck
                                ? Colors.black
                                : Colors.grey,
                          ),
                          child: const Text(
                            "중복 확인",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  PageLabelText("비밀번호"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "비밀번호를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
                          .addMemberPassword(memberPassword: value);
                    },
                    validator: (value) {
                      if (isValidPwFormat(value.toString())) {
                        return null;
                      } else {
                        return "잘못된 비밀번호 형식입니다 :(";
                      }
                    },
                    obscureText: true,
                    helperText: "소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24.0),
                  PageLabelText("비밀번호 확인"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "비밀번호를 한번 더 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
                          .addMemberPasswordCheck(memberPasswordCheck: value);
                    },
                    validator: (value) {
                      if (value.toString() != newMember.memberPassword) {
                        return "비밀번호를 한번 더 확인해주세요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                  const SizedBox(height: 48.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_isValid()) {
                        if (!idCheck) {
                          if (!mounted) return;
                          showOkAlertDialog(
                              context: context,
                              barrierDismissible: false,
                              title: "아이디 중복 확인",
                              message: "아이디 중복 확인을 먼저 해주세요");
                        } else if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  const SecondSignupScreen(isSocial: false),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid() ? Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(120, 50),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidId(String memberId) {
    return RegExp(r'^[a-z0-9]{5,15}$').hasMatch(memberId);
  }

  bool isValidPwFormat(String memberPassword) {
    return RegExp(r'^[a-z0-9]{8,15}$').hasMatch(memberPassword);
  }
}

Widget PageTitle({
  String? title,
}) {
  return Text(
    title ?? "회원가입✏️",
    style: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

Widget PageSubTitle({
  String? subTitle,
}) {
  return Text(
    subTitle ?? "당신의 정보를 기입해주세요 :)",
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w100,
      color: BODY_TEXT_COLOR,
    ),
  );
}

Widget PageLabelText(String labelText) {
  return Text(
    labelText,
    textAlign: TextAlign.left,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}
