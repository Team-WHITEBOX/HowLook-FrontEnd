// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPaginationParams _$CategoryPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    CategoryPaginationParams(
      page: json['page'] as int?,
      size: json['size'] as int?,
      hashtagDTOAmekaji: json['hashtagDTOAmekaji'] as bool?,
      hashtagDTOCasual: json['hashtagDTOCasual'] as bool?,
      hashtagDTOGuitar: json['hashtagDTOGuitar'] as bool?,
      hashtagDTOMinimal: json['hashtagDTOMinimal'] as bool?,
      hashtagDTOSporty: json['hashtagDTOSporty'] as bool?,
      hashtagDTOStreet: json['hashtagDTOStreet'] as bool?,
      gender: json['gender'] as String?,
      heightHigh: json['heightHigh'] as int?,
      heightLow: json['heightLow'] as int?,
      weightHigh: json['weightHigh'] as int?,
      weightLow: json['weightLow'] as int?,
    );

Map<String, dynamic> _$CategoryPaginationParamsToJson(
        CategoryPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'hashtagDTOAmekaji': instance.hashtagDTOAmekaji,
      'hashtagDTOCasual': instance.hashtagDTOCasual,
      'hashtagDTOGuitar': instance.hashtagDTOGuitar,
      'hashtagDTOMinimal': instance.hashtagDTOMinimal,
      'hashtagDTOSporty': instance.hashtagDTOSporty,
      'hashtagDTOStreet': instance.hashtagDTOStreet,
      'heightHigh': instance.heightHigh,
      'heightLow': instance.heightLow,
      'weightHigh': instance.weightHigh,
      'weightLow': instance.weightLow,
      'gender': instance.gender,
    };
