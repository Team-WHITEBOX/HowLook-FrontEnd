// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: ReviewModelData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
