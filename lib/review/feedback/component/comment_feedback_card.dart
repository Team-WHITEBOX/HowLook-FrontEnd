// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:howlook/common/layout/default_layout.dart';
// import 'package:howlook/review/feedback/view/chart_page_screen.dart';
// import 'package:dio/dio.dart';
// import 'package:howlook/common/const/data.dart';
//
// import '../model/creator_result_data_model.dart';
// import '../model/normal_result_data_model.dart';
// import '../view/comment_feedback_screen.dart';
//
// class CommentFeedBackCard extends StatefulWidget {
//   final String nickname;
//   // 포스트 아이디
//   final int postId;
//   // 첫 장 이미지 경로
//   final String mainPhotoPath;
//   // 평균 점수
//   final double score;
//   final String review;
//
//   CommentFeedBackCard(
//       {Key? key,
//         required this.postId,
//         required this.mainPhotoPath,
//         required this.review,
//         required this.score,
//         required this.nickname,
//       }) : super(key: key);
//
//   factory CommentFeedBackCard.fromModel({
//     required CreatorResultData model,
//   }) {
//     return CommentFeedBackCard(
//       postId: model.postId,
//       mainPhotoPath: model.mainPhotoPath,
//       review: model.review,
//       score: model.score,
//       nickname: model.nickname,
//     );
//   }
//
//   @override
//   State<CommentFeedBackCard> createState() => _CommentFeedBackCardState();
// }
//
// class _CommentFeedBackCardState extends State<CommentFeedBackCard> {
//   //리스트뷰로 코멘트들만 가져오기
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       child: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         children: [
//           for (int index = 1; index < 21; index++)
//             ListTile(
//                 leading: ExcludeSemantics(
//                   child: CircleAvatar(child: Text('$index')),
//                 ),
//                 title: Text(
//                     widget.nickname
//                 ),
//                 subtitle: Text(widget.review)
//             ),
//         ],
//       ),
//     );
//   }
// }
