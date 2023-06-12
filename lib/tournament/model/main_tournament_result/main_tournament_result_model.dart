import 'package:json_annotation/json_annotation.dart';

import '../main_tournament/main_tournament_model.dart';

part 'main_tournament_result_model.g.dart';

@JsonSerializable()
class MainTournamentResultModel {
  final int tournamentHistoryId;
  final List<int> date;
  final List<MainTournamentModel> postDTOS;

  MainTournamentResultModel({
    required this.tournamentHistoryId,
    required this.date,
    required this.postDTOS,
  });

  MainTournamentResultModel copyWith({
    int? tournamentHistoryId,
    List<int>? date,
    List<MainTournamentModel>? postDTOS,
  }) {
    return MainTournamentResultModel(
      tournamentHistoryId: tournamentHistoryId ?? this.tournamentHistoryId,
      date: date ?? this.date,
      postDTOS: postDTOS ?? this.postDTOS,
    );
  }

  factory MainTournamentResultModel.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainTournamentResultModelToJson(this);
}
