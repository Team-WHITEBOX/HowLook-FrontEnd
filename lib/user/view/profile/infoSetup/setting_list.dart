import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/profile/infoSetup/profile_change.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/splash_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingList extends StatefulWidget {
  @override
  State<SettingList> createState() => _SettingList();
}

class _SettingList extends State<SettingList> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Howlook Setting',
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ListTile(
              leading: const Icon(MdiIcons.accountDetails,color: Colors.black,),
              title: const Text('프로필 수정'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileChanging()),
                );
              },
            ),
            ListTile(
              leading: const Icon(MdiIcons.headphones,color: Colors.black,),
              title: const Text('고객센터'),
              // trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(MdiIcons.bellRing,color: Colors.black,),
              title: const Text('알림설정'),
              // trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(MdiIcons.logout,color: Colors.black,),
              title: const Text('로그아웃'),
              // trailing: const Icon(Icons.navigate_next),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(MdiIcons.delete,color: Colors.black,),
              title: const Text('회원탈퇴'),
              // trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
          ],
        ),
    );
  }
}
