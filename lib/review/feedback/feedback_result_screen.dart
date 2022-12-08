import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/feedback/chart_page_screen.dart';

class FeedbackResult extends StatefulWidget {
  const FeedbackResult({Key? key}) : super(key: key);

  @override
  State<FeedbackResult> createState() => _FeedbackResultState();
}

class _FeedbackResultState extends State<FeedbackResult> {

  final List<String> images = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  final List<double> score = <double>[7.1, 6.8, 7.4];

  Widget customCard(String text) {
    return Card(
        child: Container(
          height: 120,
          child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 40),
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultLayout(
        child: CustomScrollView(
          slivers: [
            SliverAppBar( // 헤더 영역
              expandedHeight: MediaQuery.of(context).size.width * 1.0,  // 헤더의 최대 높이
              pinned: true, // 축소시 상단에 AppBar가 고정되는지 설정
              flexibleSpace: FlexibleSpaceBar(// 늘어나는 영역의 UI 정의
                title: tabTitle(),
                background: //Image.asset(images[0], fit: BoxFit.cover,),
                Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(images[0],),
                      Container(
                        child: Image.asset(
                          images[0],
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ]),
              ),
              backgroundColor: Colors.black45,
            ),
            SliverFillRemaining(                // 내용 영역
              child: Column(
                children: [
                  Text('성별 점수 그래프',style: TextStyle(fontSize: 15, color: Colors.grey),),
                  ChartPage(),
                ],
            )
            ),
          ],)
    );
  }
  
  Widget tabTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('종합 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${score[0]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('여자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${score[1]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('남자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${score[2]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        )
      ],
    );
  }
}
