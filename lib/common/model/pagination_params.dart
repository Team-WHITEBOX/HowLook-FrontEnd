import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? page;
  // final String? after;

  const PaginationParams({
    this.page,
    // this.after,
  });

  PaginationParams copyWith({
    // String? after,
    int? page,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      // after: after ?? this.after,
    );
   }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
