import 'package:json_annotation/json_annotation.dart';

part 'chat_list_params.g.dart';

@JsonSerializable()
class ChatListParams {
  // API 쿼리 파라미터에 들어가는 데이터 값 정의
  final String? roomId;

  const ChatListParams({
    this.roomId,
  });

  ChatListParams copyWith({
    String? roomId
  }) {
    return ChatListParams(
      roomId: roomId ?? this.roomId
    );
  }

  factory ChatListParams.fromJson(Map<String, dynamic> json) =>
      _$ChatListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatListParamsToJson(this);
}
