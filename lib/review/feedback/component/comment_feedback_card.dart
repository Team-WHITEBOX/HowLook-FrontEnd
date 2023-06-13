import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';

import '../model/creator_result_data_model.dart';
import '../model/normal_result_data_model.dart';
import '../view/comment_feedback_screen.dart';

class CommentFeedBackCard extends StatefulWidget {
  final String nickname;
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double score;
  final String review;

  CommentFeedBackCard(
      {Key? key,
        required this.postId,
        required this.mainPhotoPath,
        required this.review,
        required this.score,
        required this.nickname,
      }) : super(key: key);

  factory CommentFeedBackCard.fromModel({
    required CreatorResultData model,
  }) {
    return CommentFeedBackCard(
      postId: model.postId,
      mainPhotoPath: model.mainPhotoPath,
      review: model.review,
      score: model.score,
      nickname: model.nickname,
    );
  }

  @override
  State<CommentFeedBackCard> createState() => _CommentFeedBackCardState();
}

class _CommentFeedBackCardState extends State<CommentFeedBackCard> {
  //리스트뷰로 코멘트들만 가져오기
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return CustomScrollView(
      slivers: [
        SliverAppBar( // 헤더 영역
          expandedHeight: MediaQuery
              .of(context)
              .size
              .width * 1.0, // 헤더의 최대 높이
          pinned: true, // 축소시 상단에 AppBar가 고정되는지 설정
          flexibleSpace: FlexibleSpaceBar( // 늘어나는 영역의 UI 정의
            title: tabTitle(),
            background: //Image.asset(images[0], fit: BoxFit.cover,),
            Stack(
                alignment: Alignment.center,
                children: [
                  Image.network('${widget.mainPhotoPath}'),
                  Container(
                    child: Image.network(
                      '${widget.mainPhotoPath}',
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
                Text("크리에이터의 코멘트가 도착했습니다!", style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontFamily: 'NotoSans'),),
                CommentFeedback(postId: widget.postId,)
              ],
            )
        ),
      ],);
  }

  Widget tabTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Creator's Feedback")
          ],
        )
      ],
    );
  }
}
