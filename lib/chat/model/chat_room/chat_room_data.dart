import 'package:howlook/chat/model/chat_room/chat_room_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room_data.g.dart';

@JsonSerializable()
class ChatRoomsDataModel {
  final List<ChatRoomModel> data;

  ChatRoomsDataModel({
    required this.data,
  });

  ChatRoomsDataModel copyWith({
    List<ChatRoomModel>? data,
  }) {
    return ChatRoomsDataModel(
      data: data ?? this.data,

    );
  }

  factory ChatRoomsDataModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomsDataModelToJson(this);
}
