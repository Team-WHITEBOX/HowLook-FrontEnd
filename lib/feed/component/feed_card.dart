import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/model/feed_photo_dto.dart';
import 'package:howlook/feed/model/userinfo_model.dart';
import 'package:howlook/feed/view/main_feed_more_vert_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeedCard extends ConsumerWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int postId;
  // 이미지
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCount;
  // 좋아요 갯수
  final int likeCount;
  // 본인 좋아요 체크 여부
  final bool likeCheck;
  // 댓글
  final int replyCount;
  // 내용
  final String content;
  // 날짜
  final List<dynamic> regDate;

  const FeedCard(
      {required this.userPostInfo,
      required this.postId,
      required this.photoDTOs,
      required this.photoCount,
      required this.likeCount,
      required this.likeCheck,
      required this.replyCount,
      required this.content,
      required this.regDate,
      Key? key})
      : super(key: key);

  factory FeedCard.fromModel({
    required FeedModel model,
  }) {
    return FeedCard(
      userPostInfo:
          model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      postId: model.postId,
      photoDTOs: model.photoDTOs,
      photoCount: model.photoCount,
      likeCount: model.likeCount,
      likeCheck: model.likeCheck,
      replyCount: model.replyCount,
      content: model.content,
      regDate: model.regDate,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController _controller = PageController();
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
                  backgroundImage: userPostInfo.profilePhoto != NULL_IMG_URI
                      ? ExtendedImage.network(
                          '${userPostInfo.profilePhoto}',
                          fit: BoxFit.cover,
                          cache: true,
                        ).image
                      : null,
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
                final storage = ref.read(secureStorageProvider);
                String? userid = await storage.read(key: USERMID_KEY);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MainFeedMoreVertScreen(
                      userId: userid,
                      memberId: userPostInfo.memberId,
                      postId: postId,
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
                    child: ExtendedImage.network(
                      '${photoDTOs[index].path}',
                      fit: BoxFit.cover,
                      cache: true,
                    ),
                  );
                },
                itemCount: photoCount,
              ),
            ),
            Positioned(
              bottom: 19,
              right: 18,
              child: SmoothPageIndicator(
                controller: _controller,
                count: photoCount,
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
