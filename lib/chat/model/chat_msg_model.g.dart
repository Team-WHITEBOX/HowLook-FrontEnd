// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_msg_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MsgModel _$MsgModelFromJson(Map<String, dynamic> json) => MsgModel(
      type: json['type'] as String,
      roomId: json['roomId'] as String,
      sender: json['sender'] as String,
      message: json['message'] as String,
      time: (json['time'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MsgModelToJson(MsgModel instance) => <String, dynamic>{
      'type': instance.type,
      'roomId': instance.roomId,
      'sender': instance.sender,
      'message': instance.message,
      'time': instance.time,
    };
