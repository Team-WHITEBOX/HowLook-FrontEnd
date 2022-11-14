import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String mid = '';
  String mpw = '';
  String mpw_check = '';
  String name = '';
  String nickName = '';
  String phone = '';
  int height = 0;
  int weight = 0;
  String birthDay = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    // localhost
    final emulatorIP = "10.0.2.2:3000";
    final simulatorIP = "127.0.0.1:3000";
    final ip = Platform.isIOS ? simulatorIP : emulatorIP;

    return DefaultLayout(
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 상단 텍스트
                    const SizedBox(
                      height: 32.0,
                    ),
                    _Title(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _SubTitle(),
                    const SizedBox(
                      height: 60.0,
                    ),

                    // 필요한 정보 받은 텍스트 폼 필드 나열
                    CustomTextFormField(
                      hintText: "아이디를 입력해주세요",
                      onChanged: (String value) {
                        mid = value;
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "비밀번호를 입력해주세요",
                      onChanged: (String value) {
                        mpw = value;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "비밀번호를 한번 더 입력해주세요",
                      onChanged: (String value) {
                        mpw_check = value;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "이름을 입력해주세요",
                      onChanged: (String value) {
                        name = value;
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "별명을 입력해주세요",
                      onChanged: (String value) {
                        nickName = value;
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "휴대폰 번호를 입력해주세요",
                      onChanged: (String value) {
                        phone = value;
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "키를 입력해주세요",
                      onChanged: (String value) {
                        height = int.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomTextFormField(
                      hintText: "몸무게를 입력해주세요",
                      onChanged: (String value) {
                        weight = int.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime(2022, 12, 31),
                            currentTime: DateTime.now(),
                            locale: LocaleType.ko,
                            onConfirm: (date) {
                                birthDay = DateFormat('yyyy-MM-dd').format(date);
                            },
                        );
                      },
                      child: Text("날짜를 선택해주세요 :)"),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final resp = await dio.post(
                            'http://$ip/auth/login',
                            options: Options(
                              headers: {
                                'authorization': 'Bearer $ACCESS_TOKEN_KEY',
                              },
                            ),
                            data: {
                              'mid': mid,
                              'mpw': mpw,
                              'name': name,
                              'nickName': nickName,
                              'phone': phone,
                              'height': height,
                              'weight': weight,
                              'birthDay': birthDay
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                        ),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RootTab(),
                          ),
                        );
                      },
                      child: Text(
                        "취소",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
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
      "당신의 정보를 기입해주세요 :)",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
