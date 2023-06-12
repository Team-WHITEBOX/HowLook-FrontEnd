import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/main_tournament/main_tournament_model.dart';

class TournamentPhotoCard extends StatefulWidget {
  final List<MainTournamentModel> resultData;

  const TournamentPhotoCard({
    required this.resultData,
    super.key,
  });

  factory TournamentPhotoCard.fromModel({
    required List<MainTournamentModel> model,
  }) {
    return TournamentPhotoCard(resultData: model);
  }

  @override
  State<TournamentPhotoCard> createState() => _TournamentPhotoCardState();
}

class _TournamentPhotoCardState extends State<TournamentPhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ExtendedImage.network(
          widget.resultData[index].photo,
          cache: true,
          fit: BoxFit.cover,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        );
      },
      itemCount: widget.resultData.length,
      index: 0,
      autoplay: true,
      layout: SwiperLayout.TINDER,
      itemHeight: 380,
      itemWidth: 380,
    );
  }
}
