import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final int? page;

  const PaginationParams({
    this.page,
  });

  PaginationParams copyWith({
    int? page,
  }) {
    return PaginationParams(
      page: page ?? this.page,
    );
   }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
