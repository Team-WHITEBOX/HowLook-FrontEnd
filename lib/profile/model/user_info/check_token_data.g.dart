// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTokenData _$CheckTokenDataFromJson(Map<String, dynamic> json) =>
    CheckTokenData(
      status: json['status'] as int,
      data: json['data'] as String,
    );

Map<String, dynamic> _$CheckTokenDataToJson(CheckTokenData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
