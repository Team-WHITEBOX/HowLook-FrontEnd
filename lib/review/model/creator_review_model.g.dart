// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorReviewModel _$CreatorReviewModelFromJson(Map<String, dynamic> json) =>
    CreatorReviewModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data:
          CreatorReviewModelData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatorReviewModelToJson(CreatorReviewModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
