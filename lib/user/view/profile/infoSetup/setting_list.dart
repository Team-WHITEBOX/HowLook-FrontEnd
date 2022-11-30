import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/profile/infoSetup/profile_change.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/splash_screen.dart';

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
              child: Container(
                height: 50,
                color: Colors.deepPurple.shade400,
                child: Center(
                  child: Text('프로필 수정'),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileChanging()),
                );
              },
            ),
            Container(
              height: 50,
              color: Colors.deepPurple.shade300,
              child: Center(
                child: Text('고객센터'),
              ),
            ),
            Container(
              height: 50,
              color: Colors.deepPurple.shade200,
              child: Center(
                child: Text('알림설정'),
              ),
            ),
            InkWell(
              onTap: () async {
                 await storage.delete(key: REFRESH_TOKEN_KEY);
                 await storage.delete(key: ACCESS_TOKEN_KEY);
                 Text('로그아웃히히');
              },
            // InkWell(
            //   onTap: () {
            //     Splash_Screen();
            //     Text('로그아웃히히');
            //   },
              child:Container(
                height: 50,
                color: Colors.deepPurple.shade100,
                child: Center(
                  child: Text('로그아웃'),
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.deepPurple.shade50,
              child: Center(
                child: Text('회원탈퇴'),
              ),
            ),
          ],
        )));
  }
}
