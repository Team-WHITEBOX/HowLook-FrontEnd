import 'package:json_annotation/json_annotation.dart';

import 'main_tournament_model.dart';

part 'main_tournament_data.g.dart';

@JsonSerializable()
class MainTournamentData {
  final List<MainTournamentModel> data;

  MainTournamentData({
    required this.data,
  });

  factory MainTournamentData.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentDataFromJson(json);
}
