import 'package:json_annotation/json_annotation.dart';

import '../main_tournament/main_tournament_model.dart';

part 'main_tournament_result_model.g.dart';

@JsonSerializable()
class MainTournamentResultModel {
  final int tournamentHistoryId;
  final List<int> date;
  final List<MainTournamentModel> postDTOS;
  final int voteCount;

  MainTournamentResultModel({
    required this.tournamentHistoryId,
    required this.date,
    required this.postDTOS,
    required this.voteCount,
  });

  MainTournamentResultModel copyWith({
    int? tournamentHistoryId,
    List<int>? date,
    List<MainTournamentModel>? postDTOS,
    int? voteCount,
  }) {
    return MainTournamentResultModel(
      tournamentHistoryId: tournamentHistoryId ?? this.tournamentHistoryId,
      date: date ?? this.date,
      postDTOS: postDTOS ?? this.postDTOS,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  factory MainTournamentResultModel.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainTournamentResultModelToJson(this);
}
