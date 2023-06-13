import 'package:flutter/material.dart';
import 'package:howlook/tournament/model/main_tournament/main_tournament_model.dart';

class PastTournamentResultCard extends StatelessWidget {
  final int tournamentPostId;
  final List<int> date;
  final int postId;
  final String photo;
  final String memberId;
  final int score;
  final String tournamentType;

  const PastTournamentResultCard({
    required this.tournamentPostId,
    required this.date,
    required this.postId,
    required this.photo,
    required this.memberId,
    required this.score,
    required this.tournamentType,
    super.key,
  });

  factory PastTournamentResultCard.fromModel({
    required MainTournamentModel model,
  }) {
    return PastTournamentResultCard(
      tournamentPostId: model.tournamentPostId,
      date: model.date,
      postId: model.postId,
      photo: model.photo,
      memberId: model.memberId,
      score: model.score,
      tournamentType: model.tournamentType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 80,
        width: 100,
        color: Colors.red,
        child: Text("hi"),
      ),
    );
  }
}
