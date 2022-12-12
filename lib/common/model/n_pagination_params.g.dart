// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'n_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearPaginationParams _$NearPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    NearPaginationParams(
      page: json['page'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NearPaginationParamsToJson(
        NearPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
