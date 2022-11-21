import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signup/first_signup_screen.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';

class ProfileChanging extends StatefulWidget {

  @override
  State<ProfileChanging> createState() => _ProfileChangeScreen();
}

class _ProfileChangeScreen extends State<ProfileChanging> {
  String mid = '';
  String mpw = '';
  String userpw = '';
  String name = '';
  String nickName = '';
  String phone = '';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    // Dio Connection
    final dio = Dio();
    // localhost
    final emulatorIP = "10.0.2.2:3000";
    final simulatorIP = "127.0.0.1:3000";
    final ip = Platform.isIOS ? simulatorIP : emulatorIP;
    // post 함수
    void _postData() async {
      final resp = await dio.post(
        'http://3.34.164.14:8080/account/join',
        data: {
          //'mid': widget.mid,
          //'mpw': widget.mpw,
          'nickName': nickName,
          'phone': phone,
          'height': height,
          'weight': weight,
        },
      );
      print(resp.data);
    };

    // validate
    final formkey = GlobalKey<FormState>();
    Future<void> _SettingList() async {
      if (formkey.currentState!.validate() == false) {
        return;
      } else {
        formkey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("회원정보가 수정되었습니다:)"),
            duration: Duration(seconds: 1),
          ),
        );
      }
      _postData();
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
                      _LabelText(
                        labelText: "닉네임",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "닉네임을 바꿔보세요",
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
                      ElevatedButton(
                        onPressed: () async {
                          _SettingList();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: Size(100, 50),
                        ),
                        child: Text(
                          "회원정보 수정 완료",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
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
      "회원정보 수정️",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.black,
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