import 'package:json_annotation/json_annotation.dart';

part 'chat_msg_model.g.dart';

@JsonSerializable()
class MsgModel {
  String type;
  final String roomId;
  String sender;
  String message;
  List<int>? time;

  MsgModel({
    required this.type,
    required this.roomId,
    required this.sender,
    required this.message,
    this.time,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) =>
      _$MsgModelFromJson(json);

  Map<String, dynamic> toJson() => _$MsgModelToJson(this);
}
