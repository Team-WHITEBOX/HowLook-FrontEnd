import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedCard extends StatelessWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지
  final List<String> photoPaths;
  // 이미지 갯수
  final int photoCnt;

  const MainFeedCard(
      {required this.userPostInfo,
      required this.npostId,
      required this.photoPaths,
      required this.photoCnt,
      Key? key})
      : super(key: key);

  factory MainFeedCard.fromModel({
    required MainFeedModel model,
  }) {
    return MainFeedCard(
      userPostInfo: model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      npostId: model.npostId,
      photoPaths: List<String>.from(model.photoPaths),
      photoCnt: model.photoCnt,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    List<String> list = [
      'asset/img/Profile/HL1.JPG',
      'asset/img/Profile/HL2.JPG',
      'asset/img/Profile/HL3.JPG',
    ];

    List<int> bodyinfo = [
      userPostInfo.memberHeight,
      userPostInfo.memberWeight
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: Image.asset(
                    list[0],
                    fit: BoxFit.cover,
                  ).image,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userPostInfo.memberId,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bodyinfo.join(' · '),
                      style: TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //child: Image.network(images[index], fit: BoxFit.cover,),
                    child: Image.asset(
                      list[index],
                      fit: BoxFit.cover,
                    ),
                    // -> 네트워크로 수정하기
                  );
                },
                itemCount: 3, // -> PhotoCnt로 수정
              ),
            ),
            Positioned(
              bottom: 19,
              right: 18,
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                    spacing: 5.0,
                    radius: 14.0,
                    dotWidth: 9.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey,
                    activeDotColor: PRIMARY_COLOR),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
