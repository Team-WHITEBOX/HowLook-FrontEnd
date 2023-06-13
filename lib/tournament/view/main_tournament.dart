import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../common/layout/default_layout.dart';
import '../component/tournament_selected_card.dart';
import '../provider/main_tournament_provider.dart';

class TournamentScreen extends ConsumerStatefulWidget {
  const TournamentScreen({super.key});

  @override
  ConsumerState<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends ConsumerState<TournamentScreen> {
  final AppinioSwiperController controller = AppinioSwiperController();

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    return strToday;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tournamentData = ref.watch(mainTournamentProvider(getToday()));

    _swipe(int index, AppinioSwiperDirection direction) {
      if (direction.name == 'right') {
        ref
            .read(mainTournamentProvider("2023-06-12").notifier)
            .postScore(tournamentData[index - 1].tournamentPostId, 1);
      } else {
        ref
            .read(mainTournamentProvider("2023-06-12").notifier)
            .postScore(tournamentData[index - 1].tournamentPostId, 0);
      }
    }

    Future<void> _onEnd() async {
      log("end reached!");
      final result = await ref
          .read(mainTournamentProvider("2023-06-12").notifier)
          .putScore();

      if (result) {
        Navigator.pop(context);
      } else {
        print("");
      }
    }

    return DefaultLayout(
      title: "오늘의 토너먼트",
      appBarBackgroundColor: const Color(0xffEDF0F3),
      backgroundColor: const Color(0xffEDF0F3),
      leading: IconButton(
        onPressed: () async {
          await ref.read(mainTournamentProvider(getToday()).notifier).clearScore();
          await ref.read(mainTournamentProvider(getToday()).notifier).getMainTournament();
          if (!mounted) return;
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: AppinioSwiper(
                    unlimitedUnswipe: true,
                    controller: controller,
                    swipeOptions: AppinioSwipeOptions.horizontal,
                    cardsCount: tournamentData.length,
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 60,
                      top: 40,
                      bottom: 180,
                    ),
                    onSwipe: _swipe,
                    onEnd: _onEnd,
                    cardsBuilder: (BuildContext context, int index) {
                      return TournamentSelectedCard.fromModel(
                          model: tournamentData[index]);
                    },
                  ),
                ),
                Positioned(
                  bottom: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      swipeLeftButton(controller),
                      const SizedBox(width: 40),
                      swipeRightButton(controller),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget swipeLeftButton(AppinioSwiperController controller) {
    return GestureDetector(
      onTap: () {
        controller.swipeLeft();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 6.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: const Icon(Icons.close, size: 36, color: Colors.white),
      ),
    );
  }

  Widget swipeRightButton(AppinioSwiperController controller) {
    return GestureDetector(
      onTap: () {
        controller.swipeRight();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 6.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: const Icon(Icons.check, size: 36, color: Colors.white),
      ),
    );
  }
}
