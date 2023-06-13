import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import '../../common/const/data.dart';
import '../../feed/view/feed_detail/feed_detail_screen.dart';
import '../model/profile/member_posts.dart';
import '../model/profile/profile_model.dart';
import '../view/profile/my_feed_screen.dart';
import '../view/profile/my_scrap.dart';
import '../view/setting/setting_list.dart';

class MainProfileCard extends StatelessWidget {
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

  final int memberPostCount;

  final List<MemberPosts> memberPosts;

  const MainProfileCard({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
    required this.memberPostCount,
    required this.memberPosts,
    Key? key,
  }) : super(key: key);

  factory MainProfileCard.fromModel({
    required ProfileModel model,
  }) {
    return MainProfileCard(
      memberId: model.memberId,
      memberNickName: model.memberNickName,
      memberHeight: model.memberHeight,
      memberWeight: model.memberWeight,
      profilePhoto: model.profilePhoto,
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
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.8,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.grey,
                                ],
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                          PageView.builder(
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FeedDetailScreen(
                                        postId: memberPosts[index].postId,
                                      ),
                                    ),
                                  );
                                },
                                child: ExtendedImage.network(
                                  memberPosts[index].mainPhotoPath,
                                  cache: true,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            itemCount: memberPostCount,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MyScrap(
                                    memberId: memberId,
                                  ),
                                ),
                              );
                            }, //설정 화면 이동
                            icon: const Icon(Icons.bookmark_border_outlined),
                            iconSize: 30,
                            color: Colors.white,
                          ),
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
                            icon: const Icon(
                                Icons.auto_awesome_motion_outlined),
                            iconSize: 30,
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SettingScreen(memberId: memberId),
                                ),
                              );
                            }, //설정 화면 이동
                            icon: const Icon(Icons.settings),
                            iconSize: 30,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        memberNickName,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "${memberHeight}cm ${memberWeight}kg",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 60,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(500),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 6,
                  backgroundImage: profilePhoto != NULL_IMG_URI
                      ? ExtendedImage.network(
                          profilePhoto,
                          fit: BoxFit.cover,
                          cache: true,
                        ).image
                      : Image.asset('asset/img/Profile/BaseProfile.JPG').image,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
