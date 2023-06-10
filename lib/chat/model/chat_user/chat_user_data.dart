import 'package:howlook/chat/model/chat_room/chat_room_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_user_data.g.dart';

@JsonSerializable()
class ChatUserData {
  final List<String> data;

  ChatUserData({
    required this.data,
  });

  ChatUserData copyWith({
    List<String>? data,
  }) {
    return ChatUserData(
      data: data ?? this.data,

    );
  }

  factory ChatUserData.fromJson(Map<String, dynamic> json) =>
      _$ChatUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserDataToJson(this);
}
