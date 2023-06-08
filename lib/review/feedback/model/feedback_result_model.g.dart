// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBResultModel _$FBResultModelFromJson(Map<String, dynamic> json) =>
    FBResultModel(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
      maleScore: (json['maleScore'] as num).toDouble(),
      femaleScore: (json['femaleScore'] as num).toDouble(),
    );

Map<String, dynamic> _$FBResultModelToJson(FBResultModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
      'maleScore': instance.maleScore,
      'femaleScore': instance.femaleScore,
    };
