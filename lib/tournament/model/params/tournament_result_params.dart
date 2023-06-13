import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/data_utils.dart';

part 'tournament_result_params.g.dart';

@JsonSerializable()
class MainTournamentResultParams {
  final int tournamentPostId;
  final String date;
  final int postId;
  final String photo;
  final String memberId;
  final int score;
  final String tournamentType;

  MainTournamentResultParams({
    required this.tournamentPostId,
    required this.date,
    required this.postId,
    required this.photo,
    required this.memberId,
    required this.score,
    required this.tournamentType,
  });

  MainTournamentResultParams copyWith({
    int? tournamentPostId,
    String? date,
    int? postId,
    String? photo,
    String? memberId,
    int? score,
    String? tournamentType,
  }) {
    return MainTournamentResultParams(
      tournamentPostId: tournamentPostId ?? this.tournamentPostId,
      date: date ?? this.date,
      postId: postId ?? this.postId,
      photo: photo ?? this.photo,
      memberId: memberId ?? this.memberId,
      score: score ?? this.score,
      tournamentType: tournamentType ?? this.tournamentType,
    );
  }

  factory MainTournamentResultParams.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentResultParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MainTournamentResultParamsToJson(this);
}
