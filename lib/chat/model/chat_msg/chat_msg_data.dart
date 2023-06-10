import 'package:json_annotation/json_annotation.dart';

import 'chat_msg_model.dart';

part 'chat_msg_data.g.dart';

@JsonSerializable()
class ChatMsgData {
  final List<MsgModel> data;

  ChatMsgData({
    required this.data,
  });

  ChatMsgData copyWith({
    List<MsgModel>? data,
  }) {
    return ChatMsgData(
      data: data ?? this.data
    );
  }

  factory ChatMsgData.fromJson(Map<String, dynamic> json) =>
      _$ChatMsgDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMsgDataToJson(this);
}
