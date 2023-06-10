import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/chat_msg/chat_msg_model.dart';
import '../repository/chat_repository.dart';

final chatMsgsProvider =
StateNotifierProvider.family<ChatMsgsStateNotifier, List<MsgModel>, String>(
      (ref, roomId) {
    final chatRepository = ref.watch((chatRepositoryProvider));
    final notifier = ChatMsgsStateNotifier(roomId: roomId, chatRepository: chatRepository);
    return notifier;
  },
);

class ChatMsgsStateNotifier extends StateNotifier<List<MsgModel>> {
  final String roomId;
  final ChatRepository chatRepository;

  ChatMsgsStateNotifier({
    required this.roomId,
    required this.chatRepository,
  }) : super([]) {
    getChatMsgList();
  }

  getChatMsgList() async {
    final resp = await chatRepository.getChatList(roomId);
    state = resp.data;
  }

  appendMsg(MsgModel msgModel) {
    state = [...state, msgModel];
  }

  clearMsg() {
    state.clear();
  }
}
