// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorDataModel _$CreatorDataModelFromJson(Map<String, dynamic> json) =>
    CreatorDataModel(
      creatorEvalId: json['creatorEvalId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
    );

Map<String, dynamic> _$CreatorDataModelToJson(CreatorDataModel instance) =>
    <String, dynamic>{
      'creatorEvalId': instance.creatorEvalId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
    };
