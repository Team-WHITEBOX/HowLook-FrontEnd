import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_comment_model.g.dart';

@JsonSerializable()
class MainFeedCommentModel {
  // 댓글 아이디
  final int replyId;
  // 댓글 부모 아이디
  final int parentId;
  // 댓글 좋아요 수
  final int likeCount;
  // 댓글 작성자 닉네임
  final String nickName;
  // 댓글 작성자 프로필 사진
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String profilePhoto;
  // 댓글 내가 체크 여부
  final bool like_chk;
  // 댓글 내용
  final String contents;
  // 포스트 아이디
  final int npostId;

  MainFeedCommentModel({
    required this.replyId,
    required this.parentId,
    required this.likeCount,
    required this.nickName,
    required this.profilePhoto,
    required this.like_chk,
    required this.contents,
    required this.npostId,
  });

  factory MainFeedCommentModel.fromJson(Map<String, dynamic> json) =>
      _$MainFeedCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainFeedCommentModelToJson(this);
}
