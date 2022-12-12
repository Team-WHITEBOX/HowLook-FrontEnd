import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/user/view/profile/view/my_feed.dart';
import 'package:howlook/user/view/profile/infoSetup/setting_list.dart';
import 'package:howlook/user/view/profile/view/my_scrap.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';
import 'package:howlook/user/view/profile/model/other_profile_model.dart';

class OtherProfileCard extends StatelessWidget {
  // 아이디
  final String memberId;
  // 닉네임
  final String memberNickName;
  // 키
  final int memberHeight;
  // 몸무게
  final int memberWeight;
  // 포토아이디
  final String profilePhoto;

  final bool me;

  final int memberFeedCnt;

  final List<MemberFeeds> memberFeeds;

  const OtherProfileCard(
      {required this.memberId,
        required this.memberNickName,
        required this.memberHeight,
        required this.memberWeight,
        required this.profilePhoto,
        required this.me,
        required this.memberFeedCnt,
        required this.memberFeeds,
        Key? key})
      : super(key: key);

  factory OtherProfileCard.fromModel({
    required OtherProfileModel model,
  }) {
    return OtherProfileCard(
      memberId: model.memberId,
      memberNickName: model.memberNickName,
      memberHeight: model.memberHeight,
      memberWeight: model.memberWeight,
      profilePhoto: model.profilePhoto,
      me: model.me,
      memberFeedCnt: model.memberFeedCnt,
      memberFeeds: model.memberFeeds,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();

    return Column(
      children: [
        Stack(
          children: [
            Container(
              child: Column(
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
                                    )),
                              ),
                              PageView.builder(
                                controller: _controller,
                                itemBuilder: (BuildContext context, int index) {
                                  // return Container(
                                  //   child: Image.network(
                                  //     'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberFeeds[index].mainPhotoPath}',
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // );
                                  return InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => MainFeedDetailScreen(
                                          npostId: memberFeeds[index].npostId,
                                        ),
                                      ));
                                    },
                                    child: Image.network(
                                      'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberFeeds[index].mainPhotoPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                itemCount: memberFeeds.length,  // memberFeedCnt, // -> PhotoCnt로 수정
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // IconButton(
                            //   onPressed: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (_) => MyScrap(),
                            //       ),
                            //     );
                            //   }, //설정 화면 이동
                            //   icon: Icon(Icons.bookmark_border_outlined),
                            //   iconSize: 30,
                            //   color: Colors.white,
                            // ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MyFeed(
                                      usermid: memberId,
                                    ),
                                  ),
                                );
                              }, //설정 화면 이동
                              icon: Icon(Icons.auto_awesome_motion_outlined),
                              iconSize: 30,
                              color: Colors.white,
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (_) => SettingList(),
                            //       ),
                            //     );
                            //   }, //설정 화면 이동
                            //   icon: Icon(Icons.settings),
                            //   iconSize: 30,
                            //   color: Colors.white,
                            // ),
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
                        Text(
                          "${memberNickName}", //"${nickName}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "${memberHeight}cm ${memberWeight}kg", //"${height}cm ${weight}kg",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        // Text(
                        //   "#해시태그1 #해시태그2 #해시태그3",
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 15,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              right: 20,
              child: (Container(
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
                    backgroundImage: NetworkImage(
                      'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${profilePhoto}',
                    ),
                  )
              )),
            ),
          ],
        ),
      ],
    );
  }
}
