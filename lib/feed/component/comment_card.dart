import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/model/reply_model.dart';
import 'package:howlook/feed/repository/reply_repository.dart';
import 'package:like_button/like_button.dart';

import '../provider/reply/reply_provider.dart';

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
    required ReplyModel model,
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(replyRepositoryProvider);

    Future<bool> onLikeButtonTapped(bool likeCheck) async {
      if (likeCheck) {
        // false -> true
        final code = await repo.delPostLike(widget.replyId);
        return code.response.statusCode == 200 ? !likeCheck : likeCheck;
      } else {
        // true -> false
        final code = await repo.replyPostLike(widget.replyId);
        return code.response.statusCode == 200 ? !likeCheck : likeCheck;
      }
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text(
                "댓글 삭제하기",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Center(
                    child: Text(
                      "해당 댓글을 삭제하시겠습니까?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        final code = await ref
                            .read(replyRepositoryProvider)
                            .deleteReply(widget.replyId, id: widget.replyId);

                        if (code.response.statusCode == 200) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("댓글이 삭제되었습니다."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          ref
                              .read(replyProvider(widget.postId).notifier)
                              .paginate(postId: widget.postId, forceRefetch: true);
                        }
                      },
                      child: const Text(
                        "댓글 삭제하기",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "취소",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Container(
        color: Colors.white,
        height: widget.content.length < 50 ? 50 : widget.content.length * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Container(),
              ],
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
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    widget.content,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            LikeButton(
              isLiked: widget.likeCheck,
              countPostion: CountPostion.bottom,
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                );
              },
              likeCount: widget.likeCount,
              onTap: onLikeButtonTapped,
            ),
          ],
        ),
      ),
    );
  }
}
