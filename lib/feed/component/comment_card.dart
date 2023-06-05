import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/model/comment_model.dart';
import 'package:howlook/feed/repository/comment_repository.dart';
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

  const CommentCard({
    required this.parentId,
    required this.profilePhoto,
    required this.content,
    required this.postId,
    required this.replyId,
    required this.nickName,
    required this.likeCount,
    required this.likeCheck,
    Key? key,
  }) : super(key: key);

  factory CommentCard.fromModel({
    required CommentModel model,
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
  Future<bool> onLikeButtonTapped(bool likeCheck, int replyId) async {
    final repo = ref.watch(commentRepositoryProvider);

    if (likeCheck) {
      final code = await repo.replyPostLike(ReplyId: replyId);
      return code.response.statusCode == 200 ? true : false;
    } else {
      final code = await repo.replyPostLike(ReplyId: replyId);
      return code.response.statusCode == 200 ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.content.length < 50 ? 50 : 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
            backgroundImage: widget.profilePhoto != NULL_IMG_URI
                ? ExtendedImage.network(
                    widget.profilePhoto,
                    fit: BoxFit.cover,
                    cache: true,
                  ).image
                : Image.asset('asset/img/Profile/BaseProfile.JPG').image,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 2),
                Text(
                  widget.nickName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Text(
                  widget.content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
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
              } else {
                result = Text(
                  "",
                  style: TextStyle(color: color),
                );
              }
              return result;
            },
          ),
        ],
      ),
    );
  }
}
