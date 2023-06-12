// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_review_model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorReviewModelData _$CreatorReviewModelDataFromJson(
        Map<String, dynamic> json) =>
    CreatorReviewModelData(
      creatorEvalId: json['creatorEvalId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
      hasMore: json['hasMore'] as int,
    );

Map<String, dynamic> _$CreatorReviewModelDataToJson(
        CreatorReviewModelData instance) =>
    <String, dynamic>{
      'creatorEvalId': instance.creatorEvalId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
      'hasMore': instance.hasMore,
    };
