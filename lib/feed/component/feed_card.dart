import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/model/feed_photo_dto.dart';
import 'package:howlook/feed/model/feed_userinfo_model.dart';
import 'package:howlook/feed/repository/feed_repository.dart';
import 'package:howlook/feed/view/comment_screen.dart';
import 'package:howlook/feed/view/main_feed_more_vert_screen.dart';
import 'package:like_button/like_button.dart';
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
    PageController controller = PageController();
    List<int> bodyInfo = [userPostInfo.memberHeight, userPostInfo.memberWeight];
    final repo = ref.watch(feedRepositoryProvider);

    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 12.0),
                  CircleAvatar(
                    radius: 16.0,
                    backgroundImage: userPostInfo.profilePhoto != NULL_IMG_URI
                        ? ExtendedImage.network(
                      userPostInfo.profilePhoto,
                      fit: BoxFit.cover,
                      cache: true,
                    ).image
                        : ExtendedImage.asset(
                        "asset/img/Profile/BaseProfile.JPG")
                        .image,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userPostInfo.memberId,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        bodyInfo.join(' · '),
                        style: const TextStyle(
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
          const SizedBox(height: 8.0),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return ExtendedImage.network(
                      photoDTOs[index].path,
                      fit: BoxFit.cover,
                      cache: true,
                    );
                  },
                  itemCount: photoCount,
                ),
              ),
              Positioned(
                bottom: 19,
                right: 18,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: photoCount,
                  effect: const WormEffect(
                    spacing: 5.0,
                    radius: 14.0,
                    dotWidth: 9.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                    type: WormType.thinUnderground,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 6),
                LikeButton(
                  likeBuilder: (bool isLiked) {
                    likeCheck == true ? isLiked = true : isLiked = false;
                    return null;
                  },
                  likeCount: likeCount,
                  onTap: (isLiked) async {
                    if (likeCheck == true) {
                      final code = await repo.delLike(postId: postId);
                      return code.response.statusCode == 200 ? true : false;
                    } else {
                      final code = await repo.postLike(postId: postId);
                      return code.response.statusCode == 200 ? true : false;
                    }
                  },
                  countDecoration: countDecoration,
                ),
                CommentButton(context, postId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CommentButton(BuildContext context, int postId) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          enableDrag: false,
          isScrollControlled: true,
          barrierColor: Colors.black.withOpacity(0.8),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          builder: (BuildContext context) {
            return FeedCommentScreen(context, postId);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(
              Icons.comment_rounded,
              size: 27,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 8),
              child: Center(
                child: Text(
                  '$replyCount 개',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FeedCommentScreen(BuildContext context, int postId) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter subState) {
        return Container(
          height: MediaQuery.of(context).size.height / 2 + 200,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 8,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 36.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "댓글",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              CommentScreen(postId: postId),
            ],
          ),
        );
      },
    );
  }

  Widget? countDecoration(Widget count, int? likeCount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        " $likeCount 개",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}