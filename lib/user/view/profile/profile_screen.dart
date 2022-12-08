import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/profile/my_feed.dart';
import 'package:howlook/user/view/profile/infoSetup/setting_list.dart';
import 'package:howlook/user/view/profile/my_scrap.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> images 
  = <String>[
    'asset/img/Profile/HL1.JPG', 
    'asset/img/Profile/HL2.JPG', 
    'asset/img/Profile/HL3.JPG', 
    'asset/img/Profile/HL4.JPG'];
  
  String nickName = '';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'My Look',
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column
            (children: [
              Stack (
              children: [
                Container(
                child:Column(
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 0.8,
                      child: Stack(
                        children: [
                          Container(
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
                                PageView.builder(
                                  itemBuilder: (BuildContext context, int index){
                                    return Container(
                                      child: Image.asset(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                },
                                ),
                              ],
                            ),
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
                                }, //설정 화면 이동
                                icon: Icon(Icons.bookmark_border_outlined),
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
                                }, //설정 화면 이동
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
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text( "닉네임",//"${nickName}",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(
                          "키cm 몸무게kg",//"${height}cm ${weight}kg",
                          style: TextStyle(color: Colors.grey,fontSize: 15,),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(
                          "#해시태그1 #해시태그2 #해시태그3",
                          style: TextStyle(color: Colors.grey,fontSize: 15,),
                        ),
                      ],
                    ),)
                  ],
                ),
                ),
                Positioned(
                    bottom: 60,
                    right: 20,
                    child: (
                      Container(
                        padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                                colors: [
                                  Color(0xFFD07AFF),
                                  Color(0xFFa6ceff),
                                ]),
                            borderRadius: BorderRadius.circular(500),
                          ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 6,
                          backgroundImage: AssetImage('asset/img/Profile/HL3.JPG'),
                      ))
                    ),
                ),

              ],
            ),
              const SizedBox(
                height: 24.0,
              ),
              // Container(
              //   child: DefaultTabController(
              //     length: 2, // length of tabs
              //     initialIndex: 0,
              //     child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              //       Container(
              //         child: TabBar(
              //           labelColor: Colors.purple,
              //           unselectedLabelColor: Colors.grey,
              //           tabs: [
              //             Tab(text: 'My Feed'),
              //             Tab(text: 'Scrap'),
              //             SizedBox(),
              //             SizedBox(),
              //           ],
              //           indicatorColor: Colors.purple,
              //           indicatorWeight: 2,
              //         ),
              //       ),
              //       Container(
              //           height: 400, //height of TabBarView
              //           decoration: BoxDecoration(
              //               border: Border(top: BorderSide(color: Colors.white, width: 0.5))
              //           ),
              //           child: TabBarView(children: <Widget>[
              //             TabBarView(
              //               children: [
              //                 Tab(child: MyFeed()),
              //                 Tab(child: MyScrap()),
              //               ],
              //             )
              //           ])
              //       )
              //     ],
              //     ),
              //   ),
              // )
            ],)
          ),
        ),
    );
  }
}
