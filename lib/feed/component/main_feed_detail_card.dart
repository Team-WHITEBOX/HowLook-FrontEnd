import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/feed/component/main_feed_detail_comment.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedDetailCard extends StatelessWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지
  final List<String> photoPaths;
  // 이미지 갯수
  final int photoCnt;
  // 좋아요
  final int likeCount;
  // 댓글
  final int commentCount;
  // 내용
  final String content;

  const MainFeedDetailCard(
      {required this.userPostInfo,
      required this.npostId,
      required this.photoPaths,
      required this.photoCnt,
      required this.likeCount,
      required this.commentCount,
      required this.content,
      Key? key})
      : super(key: key);

  factory MainFeedDetailCard.fromModel({
    required MainFeedDetailModel model,
  }) {
    return MainFeedDetailCard(
      userPostInfo: model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      npostId: model.npostId,
      photoPaths: List<String>.from(model.photoPaths),
      photoCnt: model.photoCnt,
      likeCount: model.likeCount,
      commentCount: model.commentCount,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    // 임시로 리스트 주기
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
        Column(
          children: [
            const SizedBox(height: 10,),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          '2022.11.17',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w200,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      label: Text(''),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return MainFeedDetailComment();
                          },
                          backgroundColor: Colors.transparent,
                        );
                      },
                      icon: Icon(
                        Icons.comment,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size(10, 10),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 25,
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Text(
                            userPostInfo.memberId,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      TextButton.icon(
                        label: Text(''),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.black,
                        ),
                        style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        )
      ],
    );
  }
}
