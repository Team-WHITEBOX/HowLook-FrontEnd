import 'package:json_annotation/json_annotation.dart';

part 'post_reply_params.g.dart';

@JsonSerializable()
class PostReplyParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final String? content;
  final int parentId = 0;
  final int? postId;

  const PostReplyParams({
    required this.content,
    required this.postId,
  });

  PostReplyParams copyWith({
    String? content,
    int? postId,
  }) {
    return PostReplyParams(
      content: content ?? this.content,
      postId: postId ?? this.postId,
    );
  }

  factory PostReplyParams.fromJson(Map<String, dynamic> json) =>
      _$PostReplyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PostReplyParamsToJson(this);
}
