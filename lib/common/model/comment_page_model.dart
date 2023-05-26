import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_page_model.g.dart';

@JsonSerializable()
class CommentPageModel {
  final int replyId;
  final int postId;
  final String content;
  final int parentId;
  final int likeCount;
  final String nickName;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String profilePhoto;
  final bool likeCheck;

  CommentPageModel({
    required this.replyId,
    required this.postId,
    required this.content,
    required this.parentId,
    required this.likeCount,
    required this.nickName,
    required this.profilePhoto,
    required this.likeCheck,
  });

  CommentPageModel copyWith({
    int? replyId,
    int? postId,
    String? content,
    int? parentId,
    int? likeCount,
    String? nickName,
    String? profilePhoto,
    bool? likeCheck,
  }) {
    return CommentPageModel(
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

  factory CommentPageModel.fromJson(Map<String, dynamic> json) =>
      _$CommentPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPageModelToJson(this);
}
