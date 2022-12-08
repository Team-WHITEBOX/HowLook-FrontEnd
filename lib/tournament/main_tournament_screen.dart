import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:howlook/tournament/select/tournament_select_screen.dart';
import 'package:howlook/tournament/past_tournament_screen.dart';

class tournamentScreen extends StatefulWidget {
  const tournamentScreen({Key? key}) : super(key: key);

  @override
  State<tournamentScreen> createState() => _tournamentScreenState();
}

class _tournamentScreenState extends State<tournamentScreen> {
  final List<String> images = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Tournament',
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    collapsedHeight: MediaQuery.of(context).size.width * 0.4,
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.width * 0.4,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          Center(
                            child: Container(
                                child: Text(
                              '오늘의 토너먼트가 진행중입니다!',
                              style: TextStyle(color: Colors.grey),
                            )),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
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
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  minimumSize: Size(200, 50),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => TournamentIng(),
                                    ),
                                  );
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "참여하러가기 Click!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ))),
                          )
                        ],
                      ),
                      background: const SizedBox(
                        child: ColoredBox(color: Colors.white),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 0.0, right: 0.0, bottom: 0.0),
                    child: Text(
                      '토너먼트 결과',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CardView(),
                ],
              ))),
        ));
  }

  // Widget CardView() {
  //   return Center(
  //     child: Card(
  //         shape: RoundedRectangleBorder(
  //           //모서리를 둥글게 하기 위해 사용
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         elevation: 4.0, //그림자 깊이
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 15.0, top: 0.0, right: 0.0, bottom: 0.0),
  //                   child: Text('현재 진행중'),
  //                 ),
  //                 Padding(
  //                     padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 15.0, bottom: 0.0),
  //                     child: TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).push(
  //                           MaterialPageRoute(
  //                             builder: (_) => pastTournament(),
  //                           ),
  //                         );
  //                       },
  //                       child: Text('과거 랭킹 결과', style: TextStyle(color: PRIMARY_COLOR),)))
  //               ],
  //             ),
  //             TournamentFeed(),
  //           ],
  //         )),
  //   );
  // }

  Widget CardView() {
    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0, //그림자 깊이
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 0.0, right: 0.0, bottom: 0.0),
                    child: Text('현재 진행중'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 15.0, bottom: 0.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => pastTournament(),
                              ),
                            );
                          },
                          child: Text('과거 랭킹 결과', style: TextStyle(color: PRIMARY_COLOR),)))
                ],
              ),
              TournamentFeed(),
            ],
          )),
    );
  }

  Widget TournamentFeed() {
    return Container(
      height: 400,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Swiper(
          autoplay: true,
          scale: 0.9,
          viewportFraction: 0.8,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TournamentIng(),
                  ),
                );
                },
              child: Image.asset(images[index]),
            );
          },
        ),
      ),
    );
  }

}
