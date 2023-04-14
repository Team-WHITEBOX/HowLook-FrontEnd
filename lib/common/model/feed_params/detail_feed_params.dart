import 'package:json_annotation/json_annotation.dart';

part 'detail_feed_params.g.dart';

@JsonSerializable()
class DetailFeedParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final int? postId;

  const DetailFeedParams({
    this.postId,
  });

  DetailFeedParams copyWith({
    int? postId,
  }) {
    return DetailFeedParams(
      postId: postId ?? this.postId,
    );
  }

  factory DetailFeedParams.fromJson(Map<String, dynamic> json) =>
      _$DetailFeedParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailFeedParamsToJson(this);
}
