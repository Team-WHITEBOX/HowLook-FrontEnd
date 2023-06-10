// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherPaginationParams _$WeatherPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    WeatherPaginationParams(
      page: json['page'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherPaginationParamsToJson(
        WeatherPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
