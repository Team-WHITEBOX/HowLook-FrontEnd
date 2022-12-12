import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/tournament/model/past_tournament_model.dart';
import 'package:howlook/tournament/component/past_tournament_card.dart';

class pastTournament extends StatefulWidget {
  const pastTournament({Key? key}) : super(key: key);

  @override
  State<pastTournament> createState() => _pastTournamentState();
}

class _pastTournamentState extends State<pastTournament> {
  ScrollController scrollController = ScrollController();
  String tournamentday = '';
  String postid = '';

  Future<Map<String, dynamic>> paginateLankTourna() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/tournament/post/${tournamentday}',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data['data'];
  }

  Future<Map<String, dynamic>> paginatePastTourna() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/tournament/getbyid?postId=${postid}',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '지난 랭킹 순위',
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context,
                  bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    collapsedHeight: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    pinned: true,
                    expandedHeight: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime(2022, 12, 31),
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.ko,
                                  onConfirm: (date) {
                                    tournamentday =
                                        DateFormat('yyyy-MM-dd').format(date);
                                    FutureBuilder<Map<String, dynamic>>(
                                      future: paginateLankTourna(),
                                      builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                        // 에러처리
                                        if (!snapshot.hasData) {
                                          print('error');
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                        // final item = snapshot.data!;
                                        // final pItem = PastTModel.fromJson(json: item);
                                        // return pastTournamentCard.fromModel(model: pItem);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "보고싶은 순위의 날짜를 선택하세요",
                                style: TextStyle(
                                  color: PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          // Center(
                          //   child: Container(
                          //       child: Text(
                          //         '총 n명이 참여했습니다.',
                          //         style: TextStyle(color: Colors.grey, fontSize: 15),
                          //       )),
                          // ),
                        ],
                      ),
                      background: const SizedBox(
                        child: ColoredBox(color: Colors.white),
                      ),
                    ),
                  ),
                ];
              },
              body: FutureBuilder<Map<String, dynamic>>(
                future: paginatePastTourna(),
                builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // 에러처리
                  if (!snapshot.hasData) {
                    print('error');
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  // final item = snapshot.data!;
                  // final pItem = PastTModel.fromJson(json: item);
                  // return pastTournamentCard.fromModel(model: pItem);
                },
              ), //ScoreScreen(),
            )));
  }

}