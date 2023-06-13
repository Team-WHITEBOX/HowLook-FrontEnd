// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorResultModel _$CreatorResultModelFromJson(Map<String, dynamic> json) =>
    CreatorResultModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => CreatorResultData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatorResultModelToJson(CreatorResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
