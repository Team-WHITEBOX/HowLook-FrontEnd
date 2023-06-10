import 'package:json_annotation/json_annotation.dart';

part 'reply_params.g.dart';

@JsonSerializable()
class ReplyParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final int? page;
  final int? size;

  const ReplyParams({
    this.page,
    this.size,
  });

  ReplyParams copyWith({
    int? page,
    int? size,
  }) {
    return ReplyParams(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  factory ReplyParams.fromJson(Map<String, dynamic> json) =>
      _$ReplyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyParamsToJson(this);
}
