import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../model/main_tournament/main_tournament_model.dart';

class TournamentSelectedCard extends StatefulWidget {
  final MainTournamentModel data;

  const TournamentSelectedCard({
    required this.data,
    super.key,
  });

  factory TournamentSelectedCard.fromModel({
    required MainTournamentModel model,
  }) {
    return TournamentSelectedCard(data: model);
  }

  @override
  State<TournamentSelectedCard> createState() => _TournamentSelectedCardState();
}

class _TournamentSelectedCardState extends State<TournamentSelectedCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExtendedImage.network(
        widget.data.photo,
        cache: true,
        fit: BoxFit.cover,
        shape: BoxShape.rectangle,
        width: MediaQuery.of(context).size.width * 0.9,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
