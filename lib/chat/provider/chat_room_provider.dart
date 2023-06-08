import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_room_model.dart';
import 'package:howlook/chat/repository/chat_repository.dart';

final chatRoomProvider =
    StateNotifierProvider<ChatRoomStateNotifier, List<ChatRoomModel>>(
  (ref) {
    final chatRepository = ref.watch((chatRepositoryProvider));
    final notifier = ChatRoomStateNotifier(chatRepository: chatRepository);
    return notifier;
  },
);

class ChatRoomStateNotifier extends StateNotifier<List<ChatRoomModel>> {
  final ChatRepository chatRepository;

  ChatRoomStateNotifier({
    required this.chatRepository,
  }) : super([]) {
    getChatRoomList();
  }

  Future<void> getChatRoomList() async {
    final resp = await chatRepository.getRoomList();
    state = resp.data;
  }

  List<ChatRoomModel?> getParticipateRoom() {
    List<ChatRoomModel?> participateRoom = [];

    return participateRoom = state.map((room) {
      return room.enter ? room : null;
    }).toList();
  }

  List<ChatRoomModel?> getNonParticipateRoom() {
    List<ChatRoomModel?> participateRoom = [];

    return participateRoom = state.map((room) {
      return room.enter ? null : room;
    }).toList();
  }
}
