import 'package:json_annotation/json_annotation.dart';

part 'near_pagination_params.g.dart';

@JsonSerializable()
class NearPaginationParams {
  final int? page;
  final double? latitude;
  final double? longitude;

  const NearPaginationParams({
    this.page,
    this.latitude,
    this.longitude,
  });

  NearPaginationParams copyWith({
    int? page,
    double? latitude,
    double? longitude,
  }) {
    return NearPaginationParams(
      page: page ?? this.page,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory NearPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$NearPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$NearPaginationParamsToJson(this);
}
