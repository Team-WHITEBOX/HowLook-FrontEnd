import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/userinfomodel.dart';
import 'package:howlook/feed/view/main_feed_more_vert_screen.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../view/comment_screen.dart';

class MainFeedDetailCard extends StatelessWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;
  // 좋아요 갯수
  final int likeCount;
  // 본인 좋아요 체크 여부
  final bool like_chk;
  // 댓글
  final int commentCount;
  // 내용
  final String content;
  // 날짜
  final List<dynamic> regDate;

  const MainFeedDetailCard(
      {required this.userPostInfo,
      required this.npostId,
      required this.photoDTOs,
      required this.photoCnt,
      required this.likeCount,
      required this.like_chk,
      required this.commentCount,
      required this.content,
      required this.regDate,
      Key? key})
      : super(key: key);

  factory MainFeedDetailCard.fromModel({
    required MainFeedDetailModel model,
  }) {
    return MainFeedDetailCard(
      userPostInfo:
          model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      npostId: model.npostId,
      photoDTOs: model.photoDTOs,
      photoCnt: model.photoCnt,
      likeCount: model.likeCount,
      like_chk: model.like_chk,
      commentCount: model.commentCount,
      content: model.content,
      regDate: model.regDate,
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
    // 게시글 좋아요
    Future<bool> onLikeButtonTapped(bool like_chk, int npostId) async {
      final dio = Dio();
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      if (like_chk == true) {
        final resp = await dio.delete(
          'http://$API_SERVICE_URI/feed/like?NPostId=$npostId',
          options: Options(
            headers: {
              'authorization': 'Bearer $accessToken',
            },
          ),
        );
        return Future.value(!like_chk);
      } else {
        final resp = await dio.post(
          'http://$API_SERVICE_URI/feed/like?NPostId=$npostId',
          options: Options(
            headers: {
              'authorization': 'Bearer $accessToken',
            },
          ),
        );
        return Future.value(!like_chk);
      }
    }
    // 게시글 날짜 등록
    String Date = '${regDate[0]}.${regDate[1]}.${regDate[2]}';
    // 바디 정보 리스트 화
    List<int> bodyinfo = [userPostInfo.memberHeight, userPostInfo.memberWeight];

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
                itemCount: photoCnt,
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
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      Date,
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
                        return FeedCommentScreen(
                          npostId: npostId,
                        );
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
            Row(
              children: [
                Container(
                  height: 70,
                  width: (MediaQuery.of(context).size.width),
                  // color: Colors.black,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -5,
                        child: Row(
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
                      ),
                      Positioned(
                        right: 13,
                        child: LikeButton(
                          isLiked: like_chk,
                          likeCount: likeCount,
                          countPostion: CountPostion.bottom,
                          onTap: (isLiked) {
                            return onLikeButtonTapped(isLiked, npostId);
                          },
                          likeBuilder: (isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 24,
                            );
                          },
                          countBuilder: (likeCount, isLiked, String text) {
                            var color = isLiked ? Colors.red : Colors.grey;
                            Widget result;
                            if (likeCount != 0) {
                              result = Text(text, style: TextStyle(color: color));
                            } else
                              result = Text(
                                "",
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        )
      ],
    );
  }
}
