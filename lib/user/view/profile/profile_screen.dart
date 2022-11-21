import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/profile/my_feed.dart';
import 'package:howlook/user/view/profile/infoSetup/setting_list.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:howlook/user/view/profile/my_scrap.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String nickName = '';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack (
              children: [
                Container(
                child:Column(
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 0.8,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    PRIMARY_COLOR,
                                    Color.fromRGBO(0, 32, 19, 1)
                                  ],
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter,
                                )
                            ),
                          ),
                          PageView(
                            children: [
                              Image.asset('asset/img/Profile/HL1.JPG', fit: BoxFit.cover,),
                              Image.asset('asset/img/Profile/HL2.JPG', fit: BoxFit.cover,),
                              Image.asset('asset/img/Profile/HL3.JPG', fit: BoxFit.cover,),
                              Image.asset('asset/img/Profile/HL4.JPG', fit: BoxFit.cover,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MyScrap(),
                                    ),
                                  );
                                }, //스크랩 화면 이동
                                icon: Icon(Icons.bookmark_border),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MyFeed(),
                                    ),
                                  );
                                }, //피드모음 이동
                                icon: Icon(Icons.auto_awesome_motion_outlined),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => SettingList(),
                                    ),
                                  );
                                }, //설정 화면 이동
                                icon: Icon(Icons.settings),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text( "닉네임",//"${nickName}",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),
                        ),
                        Text(
                          "키cm 몸무게kg",//"${height}cm ${weight}kg",
                          style: TextStyle(fontSize: 20,),
                        ),
                        Text(
                          "해시태그",
                          style: TextStyle(fontSize: 15,),
                        ),
                      ],
                    ),
                  ],
                ),
                ),
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: (
                      Container(
                        padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                                colors: [
                                  Color(0xFF1D002D),
                                  Color(0xFF603674),
                                  Color(0xFFa17fe0)
                                ]),
                            borderRadius: BorderRadius.circular(500),
                          ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('asset/img/Profile/HL3.JPG'),
                      ))
                    ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
