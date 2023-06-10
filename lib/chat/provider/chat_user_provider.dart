import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/chat_repository.dart';

final chatUserProvider =
    StateNotifierProvider.family<ChatUserStateNotifier, List<String>, String>(
  (ref, roomId) {
    final chatRepository = ref.watch((chatRepositoryProvider));
    final notifier = ChatUserStateNotifier(chatRepository: chatRepository, roomId: roomId);
    return notifier;
  },
);

class ChatUserStateNotifier extends StateNotifier<List<String>> {
  final String roomId;
  final ChatRepository chatRepository;

  ChatUserStateNotifier({
    required this.roomId,
    required this.chatRepository,
  }) : super([]) {
    getChatUserList(roomId);
  }

  Future<void> getChatUserList(String roomId) async {
    final resp = await chatRepository.getUserList(roomId);
    state = resp.data;
  }
}
