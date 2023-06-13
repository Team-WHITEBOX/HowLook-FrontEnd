import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/tournament/component/past_tournament_result_card.dart';
import 'package:intl/intl.dart';

import '../../common/layout/default_layout.dart';
import '../provider/main_tournament_result_provider.dart';

class PastTournamentScreen extends ConsumerStatefulWidget {
  const PastTournamentScreen({super.key});

  @override
  ConsumerState<PastTournamentScreen> createState() =>
      _PastTournamentScreenState();
}

class _PastTournamentScreenState extends ConsumerState<PastTournamentScreen> {
  String value = "";

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    return strToday;
  }

  @override
  Widget build(BuildContext context) {
    final resultData = ref.watch(mainTournamentResultProvider(getToday()));

    return DefaultLayout(
      title: '지난 토너먼트 결과 조회',
      appBarBackgroundColor: const Color(0xffEDF0F3),
      backgroundColor: const Color(0xffEDF0F3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2023, 12, 31),
                      currentTime: DateTime.now(),
                      locale: LocaleType.ko,
                      onConfirm: (date) {
                        setState(() {
                          value = DateFormat("yyyy-MM-dd").format(date);
                        });
                        ref
                            .read(mainTournamentResultProvider(value).notifier)
                            .getMainTournamentResult(value);
                      },
                    );
                  },
                  child: const Text(
                    "조회 하고자 하는 날짜를 선택 하세요",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "$value 토너먼트 결과",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "총 ${resultData.voteCount} 명이 투표해주셨습니다.",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: resultData.postDTOS.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PastTournamentResultCard.fromModel(
                                model: resultData.postDTOS[index]);
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(height: 2.0);
                          },
                        ),
                      ),
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
