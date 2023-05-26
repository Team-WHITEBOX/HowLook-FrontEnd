import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/user/settingList/setting_list.dart';

class ProfileChangeCard extends StatefulWidget {
  const ProfileChangeCard({Key? key}) : super(key: key);

  @override
  State<ProfileChangeCard> createState() => _ProfileChangeCardState();
}

class _ProfileChangeCardState extends State<ProfileChangeCard> {
  String memberId = '';
  String memberPassword = '';
  String userpw = '';
  String name = '';
  String nickName = '';
  String phone = '';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {


    return DefaultLayout(
        title: '',
        child: Form(
          // key: formkey,
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
                        label: "닉네임",
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
                        label: "키",
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
                        label: "몸무게",
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
                        label: "휴대폰 번호",
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
                          SettingList();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: Size(100, 50),
                        ),
                        child: const Text(
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