// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPaginationParams _$CategoryPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    CategoryPaginationParams(
      page: json['page'] as int?,
      amekaji: json['amekaji'] as bool?,
      casual: json['casual'] as bool?,
      guitar: json['guitar'] as bool?,
      minimal: json['minimal'] as bool?,
      sporty: json['sporty'] as bool?,
      street: json['street'] as bool?,
      gender: json['gender'] as String?,
      heightHigh: (json['heightHigh'] as num?)?.toDouble(),
      heightLow: (json['heightLow'] as num?)?.toDouble(),
      weightHigh: (json['weightHigh'] as num?)?.toDouble(),
      weightLow: (json['weightLow'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CategoryPaginationParamsToJson(
        CategoryPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'amekaji': instance.amekaji,
      'casual': instance.casual,
      'guitar': instance.guitar,
      'minimal': instance.minimal,
      'sporty': instance.sporty,
      'street': instance.street,
      'heightHigh': instance.heightHigh,
      'heightLow': instance.heightLow,
      'weightHigh': instance.weightHigh,
      'weightLow': instance.weightLow,
      'gender': instance.gender,
    };
