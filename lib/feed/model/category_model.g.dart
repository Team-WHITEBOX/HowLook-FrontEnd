// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      gender: json['gender'] as String,
      hashtagDTOMinimal: json['hashtagDTOMinimal'] as bool,
      hashtagDTOCasual: json['hashtagDTOCasual'] as bool,
      hashtagDTOStreet: json['hashtagDTOStreet'] as bool,
      hashtagDTOAmekaji: json['hashtagDTOAmekaji'] as bool,
      hashtagDTOSporty: json['hashtagDTOSporty'] as bool,
      hashtagDTOGuitar: json['hashtagDTOGuitar'] as bool,
      weightLow: json['weightLow'] as int,
      weightHigh: json['weightHigh'] as int,
      heightLow: json['heightLow'] as int,
      heightHigh: json['heightHigh'] as int,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'hashtagDTOMinimal': instance.hashtagDTOMinimal,
      'hashtagDTOCasual': instance.hashtagDTOCasual,
      'hashtagDTOStreet': instance.hashtagDTOStreet,
      'hashtagDTOAmekaji': instance.hashtagDTOAmekaji,
      'hashtagDTOSporty': instance.hashtagDTOSporty,
      'hashtagDTOGuitar': instance.hashtagDTOGuitar,
      'heightLow': instance.heightLow,
      'heightHigh': instance.heightHigh,
      'weightLow': instance.weightLow,
      'weightHigh': instance.weightHigh,
    };
