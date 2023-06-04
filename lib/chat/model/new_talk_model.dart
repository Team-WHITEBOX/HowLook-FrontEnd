import 'package:json_annotation/json_annotation.dart';

part 'new_talk_model.g.dart';

@JsonSerializable()
class NewTalkModel {
  final String roodId;
  final String roomName;
  final int userCount;
  final bool enter;

  NewTalkModel({
    required this.roodId,
    required this.roomName,
    required this.userCount,
    required this.enter,
  });

  factory NewTalkModel.fromJson(Map<String, dynamic> json) =>
      _$NewTalkModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewTalkModelToJson(this);

}
