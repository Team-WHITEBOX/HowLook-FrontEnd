import 'package:json_annotation/json_annotation.dart';

part 'comment_params.g.dart';

@JsonSerializable()
class CommentParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final int? postId;

  const CommentParams({
    this.postId,
  });

  CommentParams copyWith({
    int? postId,
  }) {
    return CommentParams(
      postId: postId ?? this.postId,
    );
  }

  factory CommentParams.fromJson(Map<String, dynamic> json) =>
      _$CommentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentParamsToJson(this);
}
