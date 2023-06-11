// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainReviewModel _$MainReviewModelFromJson(Map<String, dynamic> json) =>
    MainReviewModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] as int,
    );

Map<String, dynamic> _$MainReviewModelToJson(MainReviewModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
