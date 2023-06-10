// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomsDataModel _$ChatRoomsDataModelFromJson(Map<String, dynamic> json) =>
    ChatRoomsDataModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatRoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomsDataModelToJson(ChatRoomsDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
