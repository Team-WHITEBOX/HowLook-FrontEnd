import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/new_talk_model.dart';
import 'package:howlook/chat/repository/talk_repository.dart';

final newTalkProvider =
    StateNotifierProvider<NewTalkStateNotifier, List<NewTalkModel>>(
  (ref) {
    final talkRepository = ref.watch((talkRepositoryProvider));
    final notifier = NewTalkStateNotifier(talkRepository: talkRepository);
    return notifier;
  },
);

class NewTalkStateNotifier extends StateNotifier<List<NewTalkModel>> {
  final TalkRepository talkRepository;

  NewTalkStateNotifier({
    required this.talkRepository,
  }) : super([]) {
    getTalkList();
  }

  Future<void> getTalkList() async {
    final resp = await talkRepository.getChatList();
    state = resp.data;
  }
}