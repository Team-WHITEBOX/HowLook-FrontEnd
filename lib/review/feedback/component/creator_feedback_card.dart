import 'package:flutter/material.dart';
import 'package:howlook/profile/model/scrap_model.dart';
import 'package:howlook/review/feedback/model/normal_feedback_model.dart';
import 'package:howlook/review/feedback/view/normal_feedback_result_screen.dart';

import '../model/creator_feedback_model_data.dart';
import '../model/normal_feedback_model_data.dart';
import '../view/creator_feedback_result_screen.dart';

class CreatorFeedbackCard extends StatelessWidget {
  // 포스트 아이디
  final int creatorEvalId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  const CreatorFeedbackCard(
      {required this.creatorEvalId,
        required this.mainPhotoPath,
        required this.averageScore,
        Key? key})
      : super(key: key);

  factory CreatorFeedbackCard.fromModel({
    required CreatorFeedbackData model,
  }) {
    return CreatorFeedbackCard(
      creatorEvalId: model.creatorEvalId,
      mainPhotoPath: model.mainPhotoPath,
      averageScore: model.averageScore,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: averageScore == 0.0
            ? InkWell(
          onTap: () {},
          child: Stack(alignment: Alignment.center, children: [
            Image.network('${mainPhotoPath}'),
            // Image.asset('asset/img/Profile/HL1.JPG'),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Score: ${averageScore.toStringAsFixed(1)}',
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        )
            : InkWell(
          onTap: () {
            print(creatorEvalId);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatorFeedbackResult(
                    postId: creatorEvalId,
                  )),
            );
          },
          child: Stack(alignment: Alignment.center, children: [
            Image.network('${mainPhotoPath}'),
            // Image.asset('asset/img/Profile/HL1.JPG'),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Score: ${averageScore.toStringAsFixed(1)}',
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        ));
  }
}
