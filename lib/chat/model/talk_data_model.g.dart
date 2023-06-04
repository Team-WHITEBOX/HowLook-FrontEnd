// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalkDataModel _$TalkDataModelFromJson(Map<String, dynamic> json) =>
    TalkDataModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => NewTalkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TalkDataModelToJson(TalkDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
