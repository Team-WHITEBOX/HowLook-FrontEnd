import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/const/colors.dart';
import '../../common/const/data.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../../profile/model/params/my_profile_params.dart';
import '../../profile/model/user_info/user_info_model.dart';
import '../../profile/repository/profile_repository.dart';
import '../model/feed_model.dart';
import '../model/feed_photo_dto.dart';
import '../provider/feed/main_feed_provider.dart';
import '../provider/reply/reply_provider.dart';
import '../repository/feed_repository.dart';
import '../view/feed_menu/main_feed_more_vert_screen.dart';
import '../view/reply/reply_home_screen.dart';

class DetailFeedCard extends ConsumerStatefulWidget {
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
  // 스크랩 여부
  bool? isScrapped;
  // 내용
  final String content;
  // 날짜
  final List<dynamic> regDate;
  // 날씨
  final int weather;
  // 온도
  final int temperature;

  DetailFeedCard({
    required this.userPostInfo,
    required this.postId,
    required this.photoDTOs,
    required this.photoCount,
    required this.likeCount,
    required this.likeCheck,
    required this.replyCount,
    this.isScrapped,
    required this.content,
    required this.regDate,
    required this.weather,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  factory DetailFeedCard.fromModel({
    required FeedModel model,
  }) {
    return DetailFeedCard(
      userPostInfo:
          model.userPostInfo,
      postId: model.postId,
      photoDTOs: model.photoDTOs,
      photoCount: model.photoCount,
      likeCount: model.likeCount,
      likeCheck: model.likeCheck,
      replyCount: model.replyCount,
      content: model.content,
      regDate: model.regDate,
      weather: model.weather,
      temperature: model.temperature,
      isScrapped: model.isScrapped,
    );
  }

  @override
  ConsumerState<DetailFeedCard> createState() => _DetailFeedCardState();
}

class _DetailFeedCardState extends ConsumerState<DetailFeedCard> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<int> bodyInfo = [widget.userPostInfo.memberHeight, widget.userPostInfo.memberWeight];
    final repo = ref.watch(feedRepositoryProvider);

    Future<bool> onLikeButtonTapped(bool likeCheck) async {
      if (!likeCheck) {
        // false -> true
        final code = await repo.postLike(widget.postId);
        if (code.response.statusCode == 200) {
          ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
          return !likeCheck;
        } else {
          return likeCheck;
        }
      } else {
        // true -> false
        final code = await repo.delLike(widget.postId);
        if (code.response.statusCode == 200) {
          ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
          return !likeCheck;
        } else {
          return likeCheck;
        }
      }
    }

    Future<bool> onScrapedButtonTapped(bool scrapCheck) async {
      if (!scrapCheck) {
        // false -> true
        final code = await repo.postScrap(widget.postId);
        if (code.response.statusCode == 200) {
          ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
          return !scrapCheck;
        } else {
          return scrapCheck;
        }
      } else {
        // true -> false
        final code = await repo.delScrap(widget.postId);
        if (code.response.statusCode == 200) {
          ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
          return !scrapCheck;
        } else {
          return scrapCheck;
        }
      }
    }

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
                    backgroundImage: widget.userPostInfo.profilePhoto != NULL_IMG_URI
                        ? ExtendedImage.network(
                            widget.userPostInfo.profilePhoto,
                            fit: BoxFit.cover,
                            cache: true,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return const CircularProgressIndicator(
                                      color: Colors.black);
                                case LoadState.completed:
                                  break;
                                case LoadState.failed:
                                  break;
                              }
                              return null;
                            },
                          ).image
                        : ExtendedImage.asset(
                            "asset/img/Profile/BaseProfile.JPG",
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return const CircularProgressIndicator(
                                      color: Colors.black);
                                  break;
                                case LoadState.completed:
                                  break;
                                case LoadState.failed:
                                  break;
                              }
                              return null;
                            },
                          ).image,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userPostInfo.memberId,
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
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: ExtendedImage.asset(
                      "asset/img/weather/weather_${widget.weather}.png",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("${widget.temperature}°C"),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      final storage = ref.watch(secureStorageProvider);
                      final userId = await storage.read(key: USERMID_KEY);

                      if (!mounted) return;
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MainFeedMoreVertScreen(
                            userId: userId,
                            memberId: widget.userPostInfo.memberId,
                            postId: widget.postId,
                            isScrapped: widget.isScrapped!,
                          );
                        },
                        elevation: 50,
                        enableDrag: true,
                        isDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 100,
                          maxHeight: 350,
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              )
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
                      widget.photoDTOs[index].path,
                      fit: BoxFit.cover,
                      cache: true,
                    );
                  },
                  itemCount: widget.photoCount,
                ),
              ),
              Positioned(
                bottom: 19,
                right: 18,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widget.photoCount,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    LikeButton(
                      isLiked: widget.likeCheck,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                        );
                      },
                      onTap: onLikeButtonTapped,
                      likeCount: widget.likeCount,
                      countDecoration: countDecoration,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final storage = ref.watch(secureStorageProvider);
                        final userId = await storage.read(key: USERMID_KEY);

                        MyProfileParams myProfileParams =
                            MyProfileParams(memberId: userId!);

                        final userData = await ref
                            .read(profileRepositoryProvider)
                            .getMyProfile(userId,
                                myProfileParams: myProfileParams);

                        ref
                            .read(replyProvider(widget.postId).notifier)
                            .paginate(postId: widget.postId, forceRefetch: true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReplyHomeScreen(
                              postId: widget.postId,
                              profilePhoto: userData.data.profilePhoto,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            const Icon(Icons.comment_rounded, size: 27),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 6, left: 8),
                              child: Center(
                                child: Text(
                                  '${widget.replyCount} 개',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    LikeButton(
                      isLiked: widget.isScrapped,
                      likeBuilder: (bool isScrapped) {
                        return Icon(
                          Icons.bookmark,
                          size: 28,
                          color: isScrapped ? Colors.black : Colors.grey,
                        );
                      },
                      onTap: onScrapedButtonTapped,
                    ),
                    const SizedBox(width: 5),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 22),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "${widget.regDate[0]}.${widget.regDate[1]}.${widget.regDate[2]}",
                style: const TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 22),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Text(
                    "|   ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.userPostInfo.memberId,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "   ${widget.content}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
