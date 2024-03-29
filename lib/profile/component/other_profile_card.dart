import 'package:flutter/material.dart';
import 'package:howlook/profile/view/profile/my_feed_screen.dart';
import 'package:howlook/feed/view/feed_detail/feed_detail_screen.dart';
import 'package:howlook/profile/model/other_profile_model.dart';
import 'package:extended_image/extended_image.dart';

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

  final int memberPostCount;

  final List<MemberPosts> memberPosts;

  const OtherProfileCard(
      {required this.memberId,
        required this.memberNickName,
        required this.memberHeight,
        required this.memberWeight,
        required this.profilePhoto,
        required this.me,
        required this.memberPostCount,
        required this.memberPosts,
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
      memberPostCount: model.memberPostCount,
      memberPosts: model.memberPosts,
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
                                        Colors.black,
                                        Colors.grey,
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
                                        builder: (_) => FeedDetailScreen(
                                          postId: memberPosts[index].postId,
                                        ),
                                      ));
                                    },
                                    child: Image.network(
                                      'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberPosts[index].mainPhotoPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                itemCount: memberPosts.length,  // memberFeedCnt, // -> PhotoCnt로 수정
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
                                    builder: (_) => MyFeedScreen(
                                      memberId: memberId,
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
                          Colors.grey,
                          Colors.white,
                        ]),
                    borderRadius: BorderRadius.circular(500),
                  ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 6,
                  backgroundImage: profilePhoto != null
                      ? ExtendedImage.network(
                    profilePhoto,
                    fit: BoxFit.cover,
                    cache: true,
                  ).image
                      : Image.asset('asset/img/Profile/BaseProfile.JPG').image,
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }
}
