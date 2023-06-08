// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalFeedbackModel _$NormalFeedbackModelFromJson(Map<String, dynamic> json) =>
    NormalFeedbackModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => NormalFeedbackData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NormalFeedbackModelToJson(
        NormalFeedbackModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
