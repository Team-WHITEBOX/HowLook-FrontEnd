// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_feedback_model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorFeedbackData _$CreatorFeedbackDataFromJson(Map<String, dynamic> json) =>
    CreatorFeedbackData(
      creatorEvalId: json['creatorEvalId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
    );

Map<String, dynamic> _$CreatorFeedbackDataToJson(
        CreatorFeedbackData instance) =>
    <String, dynamic>{
      'creatorEvalId': instance.creatorEvalId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
    };
