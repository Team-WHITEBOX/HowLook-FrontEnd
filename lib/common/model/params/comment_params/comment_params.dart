import 'package:json_annotation/json_annotation.dart';

part 'comment_params.g.dart';

@JsonSerializable()
class CommentParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final int? page;
  final int? size;

  const CommentParams({
    this.page,
    this.size,
  });

  CommentParams copyWith({
    int? page,
    int? size,
  }) {
    return CommentParams(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  factory CommentParams.fromJson(Map<String, dynamic> json) =>
      _$CommentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentParamsToJson(this);
}
