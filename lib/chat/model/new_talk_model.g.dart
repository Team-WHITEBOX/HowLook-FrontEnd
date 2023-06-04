// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_talk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTalkModel _$NewTalkModelFromJson(Map<String, dynamic> json) => NewTalkModel(
      roodId: json['roodId'] as String,
      roomName: json['roomName'] as String,
      userCount: json['userCount'] as int,
      enter: json['enter'] as bool,
    );

Map<String, dynamic> _$NewTalkModelToJson(NewTalkModel instance) =>
    <String, dynamic>{
      'roodId': instance.roodId,
      'roomName': instance.roomName,
      'userCount': instance.userCount,
      'enter': instance.enter,
    };
