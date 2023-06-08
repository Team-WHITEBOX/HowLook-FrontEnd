import 'package:json_annotation/json_annotation.dart';

part 'chat_room_model.g.dart';

@JsonSerializable()
class ChatRoomModel {
  final String roomId;
  final String roomName;
  final int userCount;
  final bool enter;

  ChatRoomModel({
    required this.roomId,
    required this.roomName,
    required this.userCount,
    required this.enter,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);

}
