import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/data_utils.dart';

part 'main_tournament_model.g.dart';

@JsonSerializable()
class MainTournamentModel {
  final int tournamentPostId;
  final List<int> date;
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String photo;
  final String memberId;
  int score;
  final String tournamentType;

  MainTournamentModel({
    required this.tournamentPostId,
    required this.date,
    required this.postId,
    required this.photo,
    required this.memberId,
    required this.score,
    required this.tournamentType,
  });

  MainTournamentModel copyWith({
    int? tournamentPostId,
    List<int>? date,
    int? postId,
    String? photo,
    String? memberId,
    int? score,
    String? tournamentType,
  }) {
    return MainTournamentModel(
      tournamentPostId: tournamentPostId ?? this.tournamentPostId,
      date: date ?? this.date,
      postId: postId ?? this.postId,
      photo: photo ?? this.photo,
      memberId: memberId ?? this.memberId,
      score: score ?? this.score,
      tournamentType: tournamentType ?? this.tournamentType,
    );
  }

  factory MainTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$MainTournamentModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainTournamentModelToJson(this);
}
