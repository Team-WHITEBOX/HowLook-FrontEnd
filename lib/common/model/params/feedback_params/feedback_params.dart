import 'package:json_annotation/json_annotation.dart';

part 'feedback_params.g.dart';

//CommentParams? commentParams = const CommentParams(),

@JsonSerializable()
class FeedbackParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final String? userId;

  const FeedbackParams({
    this.userId,
  });

  FeedbackParams copyWith({
    String? userId,
  }) {
    return FeedbackParams(
      userId: userId ?? this.userId,
    );
  }

  factory FeedbackParams.fromJson(Map<String, dynamic> json) =>
      _$FeedbackParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackParamsToJson(this);
}
