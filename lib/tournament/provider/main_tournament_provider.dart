import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/tournament/model/params/tournament_result_params.dart';

import '../model/main_tournament/main_tournament_model.dart';
import '../repository/tournament_repository.dart';

final mainTournamentProvider = StateNotifierProvider.family<
    MainTournamentStateNotifier, List<MainTournamentModel>, String>(
  (ref, date) {
    final tournamentRepository = ref.watch(tournamentRepositoryProvider);
    final notifier = MainTournamentStateNotifier(
      tournamentRepository: tournamentRepository,
      date: date,
    );
    return notifier;
  },
);

class MainTournamentStateNotifier
    extends StateNotifier<List<MainTournamentModel>> {
  final TournamentRepository tournamentRepository;
  final String date;

  MainTournamentStateNotifier({
    required this.tournamentRepository,
    required this.date,
  }) : super([]) {
    getMainTournament();
  }

  getMainTournament() async {
    // 원래는 이 코드가 맞지만 데이터가 2023-06-12 밖에 없기 때문에 강제로 값을 넣어주어야함
    // final resp =
    //     await tournamentRepository.getTodayTournamentResult(date: date);
    final resp =
        await tournamentRepository.getTodayTournament(date: "2023-06-12");
    state = resp.data;
  }

  postScore(int tournamentPostId, int score) {
    state = state
        .map((e) => e.tournamentPostId == tournamentPostId
            ? e.copyWith(score: score)
            : e)
        .toList();
  }

  Future<bool> putScore() async {
    List<MainTournamentResultParams> mainTournamentResultParams = [];

    for (MainTournamentModel value in state) {
      String removePrefix = "https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/";
      String modifiedString = value.photo.replaceFirst(removePrefix, "");

      mainTournamentResultParams.add(
        MainTournamentResultParams(
          tournamentPostId: value.tournamentPostId,
          date: "2023-06-12",
          postId: value.postId,
          photo: modifiedString,
          memberId: value.memberId,
          score: value.score,
          tournamentType: value.tournamentType,
        ),
      );
    }

    final resp = await tournamentRepository.putTodayTournament(
        mainTournamentResultParams: mainTournamentResultParams);

    if (resp.response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  clearScore() {
    state.clear();
  }
}
