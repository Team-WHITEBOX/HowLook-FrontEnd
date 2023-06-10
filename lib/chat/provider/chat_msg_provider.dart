import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/chat_msg/chat_msg_model.dart';

final chatMsgProvider = StateNotifierProvider<ChatMsgStateNotifier, MsgModel>(
  (ref) {
    final notifier = ChatMsgStateNotifier();
    return notifier;
  },
);

class ChatMsgStateNotifier extends StateNotifier<MsgModel> {
  ChatMsgStateNotifier()
      : super(
          MsgModel(
            type: "TALK",
            roomId: "",
            sender: "",
            message: "",
          ),
        );

  enterMessage(String message) {
    state = state.copyWith(
      message: message,
    );
  }

  clear() {
    state = MsgModel(
      type: "",
      roomId: "",
      sender: "",
      message: "",
    );
  }
}
