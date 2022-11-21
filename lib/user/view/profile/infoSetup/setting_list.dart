import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:howlook/user/view/profile/infoSetup/profile_change.dart';

class SettingList extends StatefulWidget {

  @override
  State<SettingList> createState() => _SettingList();
}

class _SettingList extends State<SettingList> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Howlook Setting',
        child: Container(
            child: Column(
              children: <Widget>[
                GestureDetector(
                 child:Container(
                  height: 50,
                  color: Color(0XFF6D9886),
                  child: Center(child: Text('프로필 수정'),),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileChanging()),
                  );
                },),
                Container(
                  height: 50,
                  color: Color(0XFF87B3A0),
                  child: Center(child: Text('고객센터'),),
                ),
                Container(
                  height: 50,
                  color: Color(0XFFA2CEBB),
                  child: Center(child: Text('알림설정'),),
                ),
                Container(
                  height: 50,
                  color: Color(0XFFBDEBD7),
                  child: Center(child: Text('로그아웃'),),
                ),
                Container(
                  height: 50,
                  color: Color(0XFFD9FFF3),
                  child: Center(child: Text('회원탈퇴'),),
                ),
              ],
            )
        )
    );
  }

}