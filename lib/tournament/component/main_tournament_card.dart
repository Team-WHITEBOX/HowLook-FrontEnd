import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:howlook/tournament/select/view/tournament_select_screen.dart';
import 'package:howlook/tournament/view/past_tournament_screen.dart';
import 'package:howlook/tournament/model/main_tournament_model.dart';

class tournamentScreenCard extends StatefulWidget {
  final int t_post_id;

  final int feed_id;

  final String photo;

  final int score;

  const tournamentScreenCard({
    Key? key,
      required this.t_post_id,
      required this.feed_id,
      required this.photo,
      required this.score,
    }) : super(key: key);

  factory tournamentScreenCard.fromModel({
    required MainTournaModel model,
  }) {
    return tournamentScreenCard(
      t_post_id: model.t_post_id,
      feed_id: model.feed_id,
      photo: model.photo,
      score: model.score,
    );
  }

  @override
  State<tournamentScreenCard> createState() => _tournamentScreenCardState();
}

class _tournamentScreenCardState extends State<tournamentScreenCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TournamentIng(),
          ),
        );
      },
      child: Image.network(
        'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.photo}',
        fit: BoxFit.cover,
      ),
    );
  }
}