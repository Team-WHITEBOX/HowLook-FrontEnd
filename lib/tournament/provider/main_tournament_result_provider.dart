import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/main_tournament/main_tournament_model.dart';
import '../model/main_tournament_result/main_tournament_result_model.dart';
import '../repository/tournament_repository.dart';

final mainTournamentResultProvider = StateNotifierProvider.family<
    MainTournamentResultStateNotifier, MainTournamentResultModel, String>(
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
    extends StateNotifier<MainTournamentResultModel> {
  final TournamentRepository tournamentRepository;
  final String date;

  MainTournamentResultStateNotifier({
    required this.tournamentRepository,
    required this.date,
  }) : super(
          MainTournamentResultModel(
              tournamentHistoryId: -1, date: [], postDTOS: [], voteCount: -1),
        ) {
    getMainTournamentResult(date);
  }

  getMainTournamentResult(String date) async {
    // 원래는 이 코드가 맞지만 데이터가 2023-06-12 밖에 없기 때문에 강제로 값을 넣어주어야함
    // final resp =
    //     await tournamentRepository.getTodayTournamentResult(date: date);
    final resp =
        await tournamentRepository.getTodayTournamentResult(date: "2023-06-12");
    state = resp.data;
  }
}
