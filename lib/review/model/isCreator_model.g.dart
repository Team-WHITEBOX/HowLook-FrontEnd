// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isCreator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsCreatorModel _$IsCreatorModelFromJson(Map<String, dynamic> json) =>
    IsCreatorModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] as bool,
    );

Map<String, dynamic> _$IsCreatorModelToJson(IsCreatorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
