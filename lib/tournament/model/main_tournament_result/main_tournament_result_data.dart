import 'package:json_annotation/json_annotation.dart';

import 'main_tournament_result_model.dart';

part 'main_tournament_result_data.g.dart';

@JsonSerializable()
class MainTournamentResultData {
  final MainTournamentResultModel data;

  MainTournamentResultData({
    required this.data,
  });

  factory MainTournamentResultData.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentResultDataFromJson(json);
}
