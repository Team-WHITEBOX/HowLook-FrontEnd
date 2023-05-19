import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/signin/intro_screen.dart';
import 'package:howlook/user/view/signup/first_signup_screen.dart';
import 'package:intl/intl.dart';
import 'package:howlook/user/model/signup_model.dart';
import 'package:howlook/user/provider/signup_provider.dart';
import 'package:howlook/user/repository/signup_repository.dart';

class SecondSignupScreen extends ConsumerStatefulWidget {
  const SecondSignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends ConsumerState<SecondSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final newMember = ref.watch(SignupProvider);

    SignupRepository repos = ref.read(signupRepositoryProvider);
    // Dio Connection
    final dio = Dio();

    void postData() async {
      final storage = ref.read(secureStorageProvider);
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      final resp = await dio.put(
        'http://$API_SERVICE_URI/member/socialedit',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
        data: {
          'memberBirthDay': newMember[0].birthDay,
          'memberHeight': newMember[0].height,
          'memberName': newMember[0].name,
          'memberNickName': newMember[0].nickName,
          'memberPhone': newMember[0].phone,
          'memberWeight': newMember[0].weight,
        },
      );
    }

    // validate
    final formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      // 각 텍스트필드 조건 검사
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        formKey.currentState!.save();
        // 가입 완료 알림
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("가입이 완료되었어요 :)"),
            duration: Duration(seconds: 1),
          ),
        );
      }
      // 소셜 회원가입이 아닐 때 바로 가입 진행
      if (newMember[0].memberId != null)
        repos.postData(signupModel: newMember[0]);
      // 소셜 로그인일 때,
      else {
        postData();
        ref.watch(SignupProvider.notifier).outputSignupModel();
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => IntroScreen(),
        ),
        (route) => false,
      );
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
                  const PageTitle(),
                  const SizedBox(height: 16.0),
                  const PageSubTitle(),
                  const SizedBox(height: 40.0),
                  const PageLabelText(labelText: "이름"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "이름을 입력해주세요",
                    onSaved: (value) {
                      newMember[0].name = value;
                    },
                    validator: (value) {
                      if (value!.length < 2) {
                        return "이름은 2자보다 짧을 수 없어요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "별명"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "별명을 입력해주세요",
                    onSaved: (value) {
                      newMember[0].nickName = value;
                    },
                    validator: (value) {
                      if (value.length < 1) {
                        return "별명은 1자보다 짧을 수 없어요 :(";
                      } else if (value.length > 9) {
                        return "별명은 10자보다 길 수 없어요 :(";
                      }
                      return null;
                      // 닉네임 중복 조회
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "휴대폰 번호"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "(예시) 01012341234",
                    onSaved: (value) {
                      newMember[0].phone = value;
                    },
                    validator: (value) {
                      if (value!.length != 11) {
                        return "휴대폰 번호는 다시 입력해주세요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "키"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "키를 입력해주세요",
                    onSaved: (value) {
                      newMember[0].height = int.parse(value);
                    },
                    validator: (value) {
                      if (value.length != 1 ||
                          (int.parse(value) < 100 || int.parse(value) > 250)) {
                        return "100cm ~ 250cm의 범위 내로 입력해주세요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "몸무게"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "몸무게를 입력해주세요",
                    onSaved: (value) {
                      newMember[0].weight = int.parse(value);
                    },
                    validator: (value) {
                      if (value.length != 1 ||
                          (int.parse(value) < 10 || int.parse(value) > 150)) {
                        return "10kg ~ 150kg의 범위 내로 입력해주세요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "생일"),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(2022, 12, 31),
                        currentTime: DateTime.now(),
                        locale: LocaleType.ko,
                        onConfirm: (date) {
                          setState(() {
                            newMember[0].birthDay =
                                DateFormat("yyyy-MM-ddTHH:mm:ss.mmm")
                                    .format(date);
                          });
                        },
                      );
                    },
                    child: Text(
                      newMember[0].birthDay == null
                          ? "당신의 생일을 알려주세요 :)"
                          : newMember[0].birthDay!.substring(0, 10),
                      style: const TextStyle(color: BODY_TEXT_COLOR),
                    ),
                  ),
                  const SizedBox(height: 24.0),
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
                          submit(); // 제출
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => IntroScreen(),
                            ),
                            (route) => false,
                          );
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
                        "가입하기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
