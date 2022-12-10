import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:intl/intl.dart';

class pastTournament extends StatefulWidget {
  const pastTournament({Key? key}) : super(key: key);

  @override
  State<pastTournament> createState() => _pastTournamentState();
}

class _pastTournamentState extends State<pastTournament> {
  ScrollController scrollController = ScrollController();

  final List<String> images = <String>[ //토너먼트 사진
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  final List<String> name = <String>[
    '강아지는멍멍',
    '고양이는야옹',
    '곰은우어어',
    '호랑이는냠냠',
  ];

  List<String> topRanks = ["🥇", "🥈", "🥉"];
  String tournamentday = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '지난 랭킹 순위',
        child: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                                 tournamentday = DateFormat('yyyy-MM-dd').format(date);
                                 Text( //랜킹날짜 안내글 어떻게하지...
                                     '${tournamentday} 랭킹 결과',
                                     style: TextStyle(
                                       color: Colors.grey,)
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
                      Center(
                        child: Container(
                            child: Text(
                              '총 n명이 참여했습니다.',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
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
              body: LankingView(), //ScoreScreen(),
        )));
  }

  Widget LankingView() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(20.0),
          sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: images.length,
                (context, index) {
              return listCard(index);
            },
          ),
        ))
      ],
    );
  }


  Widget listCard(int index) {
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
                  backgroundImage: AssetImage(images[index]),
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
              ' ${name[index]}', // 원하는 형태로 조합
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
