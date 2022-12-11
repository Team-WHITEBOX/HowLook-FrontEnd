import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/view/main_feed_more_vert_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedCard extends StatelessWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;

  const MainFeedCard(
      {required this.userPostInfo,
        required this.npostId,
        required this.photoDTOs,
        required this.photoCnt,
      Key? key})
      : super(key: key);

  factory MainFeedCard.fromModel({
    required MainFeedModel model,
  }) {
    return MainFeedCard(
      userPostInfo: model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      npostId: model.npostId,
      photoDTOs: model.photoDTOs,
      photoCnt: model.photoCnt,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();


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
                  backgroundImage: Image.network(
                    'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${userPostInfo.profilePhoto}',
                    //'asset/img/Profile/HL1.JPG',
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
              onPressed: () async {
                String? userid = await storage.read(key: USERMID_KEY);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MainFeedMoreVertScreen(
                      userId: userid,
                      memberId: userPostInfo.memberId,
                      npostId: npostId,
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
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
                    child: Image.network(
                      'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${photoDTOs[index].path}',
                      //'asset/img/Profile/HL1.JPG',
                      fit: BoxFit.cover,
                    ),
                    // -> 네트워크로 수정하기
                  );
                },
                itemCount: photoCnt, // -> PhotoCnt로 수정
              ),
            ),
            Positioned(
              bottom: 19,
              right: 18,
              child: SmoothPageIndicator(
                controller: _controller,
                count: photoCnt,
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
