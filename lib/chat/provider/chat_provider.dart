import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_room_model.dart';
import 'package:howlook/chat/repository/chat_repository.dart';

final newChatProvider =
    StateNotifierProvider<NewChatStateNotifier, List<ChatRoomModel>>(
  (ref) {
    final chatRepository = ref.watch((chatRepositoryProvider));
    final notifier = NewChatStateNotifier(chatRepository: chatRepository);
    return notifier;
  },
);

class NewChatStateNotifier extends StateNotifier<List<ChatRoomModel>> {
  final ChatRepository chatRepository;

  NewChatStateNotifier({
    required this.chatRepository,
  }) : super([]) {
    getChatList();
  }

  Future<void> getChatList() async {
    final resp = await chatRepository.getChatList();
    state = resp.data;
  }
}