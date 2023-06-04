// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      roodId: json['roodId'] as String,
      roomName: json['roomName'] as String,
      userCount: json['userCount'] as int,
      enter: json['enter'] as bool,
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'roodId': instance.roodId,
      'roomName': instance.roomName,
      'userCount': instance.userCount,
      'enter': instance.enter,
    };
