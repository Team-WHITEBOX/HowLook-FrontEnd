import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/model/feedback_result_model.dart';

class FeedbackResultCard extends StatefulWidget {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;

  const FeedbackResultCard({
    Key? key,
    required this.npostId,
    required this.mainPhotoPath,
  }) : super(key: key);

  factory FeedbackResultCard.fromModel({
    required FBResultModel model,
  }) {
    return FeedbackResultCard(
      npostId: model.npostId,
      mainPhotoPath: model.mainPhotoPath,
    );
  }

  @override
  State<FeedbackResultCard> createState() => _FeedbackResultCardState();
}

class _FeedbackResultCardState extends State<FeedbackResultCard> {


  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
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
                      Image.network('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.mainPhotoPath}'),
                      Container(
                        child: Image.network(
                          'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.mainPhotoPath}',
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ]),
              ),
              backgroundColor: Colors.black45,
            ),
            SliverFillRemaining(
              // 내용 영역
                child: Column(
                  children: [
                    Text('성별 점수 그래프',style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'NotoSans'),),
                    ChartPage(
                      npostId: widget.npostId,
                    ),
                  ],
                )
            ),
          ],);
  }

  Widget tabTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(''),
            // Text('종합 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            // Text('${score[0]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        // Container(
        //   width: 1,
        //   height: 50,
        //   color: Colors.white,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(''),
            // Text('여자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            // Text('${score[1]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        // Container(
        //   width: 1,
        //   height: 50,
        //   color: Colors.white,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(''),
            // Text('남자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            // Text('${score[2]}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        )
      ],
    );
  }
}
