// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_feedback_model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalFeedbackData _$NormalFeedbackDataFromJson(Map<String, dynamic> json) =>
    NormalFeedbackData(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
    );

Map<String, dynamic> _$NormalFeedbackDataToJson(NormalFeedbackData instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
    };
