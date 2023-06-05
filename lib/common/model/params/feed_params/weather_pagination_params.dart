import 'package:json_annotation/json_annotation.dart';

part 'weather_pagination_params.g.dart';

@JsonSerializable()
class WeatherPaginationParams {
  final int? page;
  final double? latitude;
  final double? longitude;

  const WeatherPaginationParams({
    this.page,
    this.latitude,
    this.longitude,
  });

  WeatherPaginationParams copyWith({
    int? page,
    double? latitude,
    double? longitude,
  }) {
    return WeatherPaginationParams(
      page: page ?? this.page,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory WeatherPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$WeatherPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherPaginationParamsToJson(this);
}
