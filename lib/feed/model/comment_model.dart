import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  // 댓글 아이디
  final int replyId;
  // 포스트 아이디
  final int postId;
  // 댓글 내용
  final String content;
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
  final bool likeCheck;

  CommentModel({
    required this.replyId,
    required this.postId,
    required this.content,
    required this.parentId,
    required this.likeCount,
    required this.nickName,
    required this.profilePhoto,
    required this.likeCheck,
  });

  CommentModel copyWith({
    int? replyId,
    int? postId,
    String? content,
    int? parentId,
    int? likeCount,
    String? nickName,
    String? profilePhoto,
    bool? likeCheck,
  }) {
    return CommentModel(
      replyId: replyId ?? this.replyId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      parentId: parentId ?? this.parentId,
      likeCount: likeCount ?? this.likeCount,
      nickName: nickName ?? this.nickName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      likeCheck: likeCheck ?? this.likeCheck,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
