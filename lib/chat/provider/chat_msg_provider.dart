import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_msg_model.dart';
import 'package:howlook/chat/repository/chat_repository.dart';

final chatMsgProvider =
StateNotifierProvider.family<ChatMsgStateNotifier, List<MsgModel>, String>(
      (ref, roomId) {
    final chatRepository = ref.watch((chatRepositoryProvider));
    final notifier = ChatMsgStateNotifier(roomId: roomId, chatRepository: chatRepository);
    return notifier;
  },
);

class ChatMsgStateNotifier extends StateNotifier<List<MsgModel>> {
  final String roomId;
  final ChatRepository chatRepository;

  ChatMsgStateNotifier({
    required this.roomId,
    required this.chatRepository,
  }) : super([]) {
    getChatMsgList();
  }

  getChatMsgList() async {
    print(roomId);
    final resp = await chatRepository.getChatList(roomId);

    print(resp.data[0].message);

    state = resp.data;
  }

  appendMsg(MsgModel msgModel) {
    state = [...state, msgModel];
  }
}
