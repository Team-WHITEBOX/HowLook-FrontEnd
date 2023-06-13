// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorFeedbackModel _$CreatorFeedbackModelFromJson(
        Map<String, dynamic> json) =>
    CreatorFeedbackModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CreatorFeedbackData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatorFeedbackModelToJson(
        CreatorFeedbackModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
