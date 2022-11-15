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
    // Dio Connection
    final dio = Dio();
    // localhost
    final emulatorIP = "10.0.2.2:3000";
    final simulatorIP = "127.0.0.1:3000";
    final ip = Platform.isIOS ? simulatorIP : emulatorIP;
    void _postData() async {
      final resp = await dio.post(
        'http://3.34.164.14:8080/member/join',
        data: {
          'mid': mid,
          'mpw': mpw,
          'name': name,
          'nickName': nickName,
          'phone': phone,
          'height': height,
          'weight': weight,
          'birthDay': birthDay,
          'gender': "M",
        },
      );
    };

    // validate
    final formkey = GlobalKey<FormState>();
    Future<void> _submit() async {
      if (formkey.currentState!.validate() == false) {
        return;
      } else {
        formkey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("가입이 완료되었습니다.!"),
            duration: Duration(seconds: 1),
          ),
        );
        // 각 텍스트 필드에 맞게 검증 완료되면 통신 시도
        _postData();
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
                        height: 60.0,
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
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "이름",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "이름을 입력해주세요",
                        onChanged: (String value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value!.length < 2) {
                            return "이름은 2자보다 짧을 수 없어요 :(";
                          }
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "별명",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "별명을 입력해주세요",
                        onChanged: (String value) {
                          nickName = value;
                        },
                        validator: (value) {
                          if (value!.length < 1) {
                            return "별명은 1자보다 짧을 수 없어요 :(";
                          } else if (value!.length > 9) {
                            return "별명은 10자보다 길 수 없어요 :(";
                          }
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "휴대폰 번호",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "휴대폰 번호를 입력해주세요",
                        onChanged: (String value) {
                          phone = value;
                        },
                        validator: (value) {
                          if (value!.length < 11) {
                            return "휴대폰 번호는 11자 이상입니다 :(";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "키",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "키를 입력해주세요",
                        onChanged: (String value) {
                          height = int.parse(value);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),

                      _LabelText(
                        labelText: "몸무게",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "몸무게를 입력해주세요",
                        onChanged: (String value) {
                          weight = int.parse(value);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
                            //_postData();
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: PRIMARY_COLOR,
                          ),
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
      "당신의 정보를 기입해주세요 :)",
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
