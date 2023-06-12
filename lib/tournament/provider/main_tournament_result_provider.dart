import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/main_tournament/main_tournament_model.dart';
import '../repository/tournament_repository.dart';

final mainTournamentResultProvider = StateNotifierProvider.family<
    MainTournamentResultStateNotifier, List<MainTournamentModel>, String>(
  (ref, date) {
    final tournamentRepository = ref.watch(tournamentRepositoryProvider);
    final notifier = MainTournamentResultStateNotifier(
      tournamentRepository: tournamentRepository,
      date: date,
    );
    return notifier;
  },
);

class MainTournamentResultStateNotifier
    extends StateNotifier<List<MainTournamentModel>> {
  final TournamentRepository tournamentRepository;
  final String date;

  MainTournamentResultStateNotifier({
    required this.tournamentRepository,
    required this.date,
  }) : super([]) {
    getMainTournamentResult();
  }

  getMainTournamentResult() async {
    // 원래는 이 코드가 맞지만 데이터가 2023-06-12 밖에 없기 때문에 강제로 값을 넣어주어야함
    // final resp =
    //     await tournamentRepository.getTodayTournamentResult(date: date);
    final resp =
    await tournamentRepository.getTodayTournamentResult(date: "2023-06-12");
    state = resp.data.postDTOS;
  }
}
