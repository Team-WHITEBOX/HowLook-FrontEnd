import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/tournament/model/past_tournament_model.dart';
import 'package:howlook/tournament/component/past_tournament_card.dart';
import 'package:howlook/tournament/component/lanking_card.dart';

class pastTournament extends StatefulWidget {
  const pastTournament({Key? key}) : super(key: key);

  @override
  State<pastTournament> createState() => _pastTournamentState();
}

class _pastTournamentState extends State<pastTournament> {
  ScrollController scrollController = ScrollController();
  List<String> topRanks = ["🥇", "🥈", "🥉"];
  List<dynamic> list=[];
  String postid = '';
  String tournamentday='';

  Future<Map<String,dynamic>> paginateLankTourna(String tournamentday) async {
    //print(tournamentday);
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/tournament/post/$tournamentday',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    //
    // Future<List> paginateLankTourna(String tournamentday) async {
    //   //print(tournamentday);
    //   final dio = Dio();
    //   final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //   final resp = await dio.get(
    //     // MainFeed 관련 api IP주소 추가하기
    //     'http://$API_SERVICE_URI/tournament/post/$tournamentday',
    //     options: Options(
    //       headers: {
    //         'authorization': 'Bearer $accessToken',
    //       },
    //     ),
    //   );

      // list = (json.decode(resp.data['data'].toString()) as List)
      //     .map((data) => PastTModel.fromJson(json: resp.data['data']))
      //     .toList();
    // final pItem = PastTModel.fromJson(json: item);
    // print("h$item");
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    // print(int.parse(resp.data['data']['lank_1']).toString());
    //print(list[0]['lank_1']);
    //print(resp.data['data']);
    //   print(list);
    // return list;//데이터 잘 옴
    return resp.data['data'];
  }
  //
  // Future<Map<String, dynamic>> paginatePastTourna() async {
  //   final dio = Dio();
  //   final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //   final resp = await dio.get(
  //     // MainFeed 관련 api IP주소 추가하기
  //     'http://$API_SERVICE_URI/tournament/getbyid?postId=${postid}',
  //     options: Options(
  //       headers: {
  //         'authorization': 'Bearer $accessToken',
  //       },
  //     ),
  //   );
  //   // 응답 데이터 중 data 값만 반환하여 사용하기!!
  //   return resp.data['data'];
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultLayout(
  //       title: '지난 랭킹 순위',
  //       child: FutureBuilder<Map<String, dynamic>>(
  //         future: paginateLankTourna(),
  //         builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
  //           // 에러처리
  //           if (!snapshot.hasData) {
  //             print('error');
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //           final item = snapshot.data!;
  //           final pItem = PastTModel.fromJson(json: item);
  //           return pastTournamentCard.fromModel(model: pItem);
  //         },
  //       ));
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '지난 랭킹 순위',
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      collapsedHeight: MediaQuery.of(context).size.width * 0.3,
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.width * 0.2,
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
                                      // String tournamentday =
                                      //     DateFormat('yyyy-MM-dd').format(date);
                                      // // print(tournamentday);
                                      // paginateLankTourna(tournamentday);
                                      tournamentday =
                                      DateFormat('yyyy-MM-dd').format(date);
                                      // print(tournamentday);
                                      //paginateLankTourna(tournamentday);
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
                            Center(
                              child: Container(
                                  child: Text(
                                '총 n명이 참여했습니다.',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              )),
                            ),
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
                  future: paginateLankTourna(tournamentday),
                  builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    // 에러처리
                    if (!snapshot.hasData) {
                      print('error8');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomScrollView(
                  shrinkWrap: true,
                  slivers: <Widget>[
                    SliverPadding(
                        padding: EdgeInsets.all(20.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: list.length,
                                (context, index) {
                                  final item = snapshot.data![index];
                                  final pItem = PastTModel.fromJson(json: item);
                                  return pastTournamentCard.fromModel(model: pItem, indexValue: index);
                              //return listCard(index);
                            },
                          ),
                        ))
                  ],
                );
                    print(snapshot.data);
                  },
                )
              //body: LankingView(),
    )));
  }
  //             body: CustomScrollView(
  //                 shrinkWrap: true,
  //                 slivers: <Widget>[
  //             SliverPadding(
  //             padding: EdgeInsets.all(20.0),
  //             sliver: FutureBuilder<List>(
  //               future: paginateLankTourna(tournamentday),
  //               builder: (_, AsyncSnapshot<List> snapshot) {
  //                 // 에러처리
  //                 if (!snapshot.hasData) {
  //                   print('error');
  //                   return Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 }
  //                 return SliverList(
  //                     delegate: SliverChildBuilderDelegate(
  //                       childCount: snapshot.data!.length,
  //                         (context,index){
  //                           final item = snapshot.data![index];
  //                           final pItem = PastTModel.fromJson(json: item);
  //                           return pastTournamentCard.fromModel(model: pItem);
  //                         }
  //                     )
  //                 );},
  //             ),
  //           )]))));
  // }
  Widget LankingView() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: list.length,
                    (context, index) {
                  return listCard(index);
                },
              ),
            ))
      ],
    );
  }


  // class PostDTOS {
  // // 포스트 아이디
  // final int feed_id;
  // // 이미지 경로
  // final String photo;
  //
  // final String member_id;
  //
  Widget listCard(int index) {
    //int index = widget.postDTOS.length;
    return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFD07AFF),
              Color(0xFFa6ceff),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFa6ceff),
                        Color(0xFFD07AFF),
                      ]),
                  borderRadius: BorderRadius.circular(500),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 14,
                  backgroundImage: NetworkImage('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${list[index].photo}'),
                )),

            const SizedBox(width: 10.0),
            Text(
              '${index+1} 위.', // 원하는 형태로 조합
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              ' ${list[index].member_id}', // 원하는 형태로 조합
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                index < 3 ? topRanks[index] + ' ' : ' ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
    );
  }
}
