import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/tournament/provider/main_tournament_result_provider.dart';
import 'package:intl/intl.dart';

import '../../common/layout/default_layout.dart';
import '../component/tournament_photo_card.dart';
import '../provider/main_tournament_provider.dart';
import 'main_tournament.dart';
import 'past_tournament_screen.dart';

class MainTournamentScreen extends ConsumerStatefulWidget {
  const MainTournamentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainTournamentScreen> createState() =>
      _MainTournamentScreenState();
}

class _MainTournamentScreenState extends ConsumerState<MainTournamentScreen> {
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    return strToday;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tournamentData = ref.watch(mainTournamentProvider(getToday()));

    return DefaultLayout(
      title: 'Tournament',
      appBarBackgroundColor: const Color(0xffEDF0F3),
      backgroundColor: const Color(0xffEDF0F3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    "오늘의 토너먼트가 진행되고 있어요!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () async {
                    await ref
                        .read(mainTournamentProvider(getToday()).notifier)
                        .getMainTournament();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TournamentScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "참여하러가기 Click!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "토너먼트 결과",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "현재 진행 중",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const PastTournamentScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "과거 토너먼트 결과",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TournamentPhotoCard.fromModel(model: tournamentData),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
