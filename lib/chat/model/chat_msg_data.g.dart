// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_msg_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMsgData _$ChatMsgDataFromJson(Map<String, dynamic> json) => ChatMsgData(
      data: (json['data'] as List<dynamic>)
          .map((e) => MsgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMsgDataToJson(ChatMsgData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
