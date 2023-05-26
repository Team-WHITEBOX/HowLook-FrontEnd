import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/model/comment_page_model.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/model/feed_comment_model.dart';
import 'package:like_button/like_button.dart';

class CommentCard extends ConsumerStatefulWidget {
  // 댓글 아이디
  final int replyId;
  // 댓글 부모 아이디
  final int parentId;
  // 댓글 좋아요 수
  final int likeCount;
  // 댓글 작성자 닉네임
  final String nickName;
  // 댓글 작성자 프로필 사진
  final String profilePhoto;
  // 댓글 내가 체크 여부
  final bool likeCheck;
  // 댓글 내용
  final String content;
  // 포스트 아이디
  final int postId;

  const CommentCard(
      {required this.parentId,
      required this.profilePhoto,
      required this.content,
      required this.postId,
      required this.replyId,
      required this.nickName,
      required this.likeCount,
      required this.likeCheck,
      Key? key})
      : super(key: key);

  factory CommentCard.fromModel({
    required CommentPageModel model,
  }) {
    return CommentCard(
      parentId: model.parentId,
      profilePhoto: model.profilePhoto,
      content: model.content,
      postId: model.postId,
      replyId: model.replyId,
      nickName: model.nickName,
      likeCount: model.likeCount,
      likeCheck: model.likeCheck,
    );
  }

  @override
  ConsumerState<CommentCard> createState() => _FeedCommentCardState();
}

class _FeedCommentCardState extends ConsumerState<CommentCard> {
  Future<bool> onLikeButtonTapped(bool like_chk, int replyId) async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (like_chk == true) {
      final resp = await dio.delete(
        'http://$API_SERVICE_URI/replies/like?ReplyId=$replyId',
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
      );
      return Future.value(!like_chk);
    } else {
      final resp = await dio.post(
        'http://$API_SERVICE_URI/replies/like?ReplyId=$replyId',
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
      );
      return Future.value(!like_chk);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: widget.profilePhoto != NULL_IMG_URI
                      ? ExtendedImage.network(
                          '${widget.profilePhoto}',
                          fit: BoxFit.cover,
                          cache: true,
                        ).image
                      : Image.asset('asset/img/Profile/BaseProfile.JPG').image,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nickName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(widget.content),
                  ],
                ),
              ],
            ),
            LikeButton(
              isLiked: widget.likeCheck,
              likeCount: widget.likeCount,
              countPostion: CountPostion.bottom,
              onTap: (isLiked) {
                return onLikeButtonTapped(isLiked, widget.replyId);
              },
              likeBuilder: (isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                  size: 20,
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
          ]),
        );
      }),
    );
  }
}
