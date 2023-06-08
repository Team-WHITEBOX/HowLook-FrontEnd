// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:howlook/profile/model/scrap_model.dart';
// import 'package:howlook/review/feedback/model/normal_feedback_model_data.dart';
// import 'package:howlook/review/feedback/view/feedback_result_screen.dart';
//
// import '../provider/normal_feedback_provider.dart';
//
// class NormalFeedbackCard extends ConsumerWidget {
//
//   // 포스트 아이디
//   final int postId;
//   // 첫 장 이미지 경로
//   final String mainPhotoPath;
//   // 평균 점수
//   final double averageScore;
//
//   const NormalFeedbackCard({
//     required this.postId,
//     required this.mainPhotoPath,
//     required this.averageScore,
//     Key? key})
//       : super(key: key);
//
//   factory NormalFeedbackCard.fromModel({
//     required NormalFeedbackData? model,
//   }) {
//     if (model == null) {
//       // null일 경우 처리
//       return NormalFeedbackCard(
//         postId: 0,
//         mainPhotoPath: '',
//         averageScore: 0.0,
//       );
//     }
//     return NormalFeedbackCard(
//       postId: model.postId,
//       mainPhotoPath: model.mainPhotoPath,
//       averageScore: model.averageScore,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       height: 400,
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Swiper(
//           autoplay: false,
//           scale: 0.9,
//           viewportFraction: 0.8,
//           // pagination: SwiperPagination(
//           //   alignment: Alignment.bottomCenter
//           // ),
//           // control: SwiperControl(color: Colors.white),
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => FeedbackResult(
//                       //npostId: npostId,
//                       postId: postId,
//                   )),
//                 );
//               },
//               child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Image.network('${mainPhotoPath}'),
//                     Container(
//                       child: Image.network(
//                           '${mainPhotoPath}',
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                     Container(
//                         alignment: Alignment.center,
//                         child: Text('Score: ${averageScore}점', style: TextStyle(color: Colors.white),)
//                     )
//                   ]),
//             );
//           },
//         ),
//       ),
//     );
//
//     // return Container(
//     //   child: averageScore==0.0?
//     //   InkWell(
//     //     onTap: () {},
//     //     child: Stack(
//     //         alignment: Alignment.center,
//     //         children: [
//     //           Image.network('${mainPhotoPath}'),
//     //           // Image.asset('asset/img/Profile/HL1.JPG'),
//     //           Container(
//     //             color: Colors.black.withOpacity(0.5),
//     //           ),
//     //           Container(
//     //               alignment: Alignment.center,
//     //               child: Text('Score: ${averageScore}', style: TextStyle(color: Colors.white),)
//     //           )
//     //         ]),
//     //   )
//     // : InkWell(
//     //   onTap: () {
//     //     Navigator.push(
//     //       context,
//     //       MaterialPageRoute(builder: (context) => FeedbackResult(
//     //         postId: postId,
//     //       )),
//     //     );
//     //   },
//     //   child: Stack(
//     //       alignment: Alignment.center,
//     //       children: [
//     //         Image.network('${mainPhotoPath}'),
//     //         // Image.asset('asset/img/Profile/HL1.JPG'),
//     //         Container(
//     //             color: Colors.black.withOpacity(0.5),
//     //           ),
//     //         Container(
//     //             alignment: Alignment.center,
//     //             child: Text('Score: ${averageScore}', style: TextStyle(color: Colors.white),)
//     //         )
//     //       ]),
//     //   ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:howlook/profile/model/scrap_model.dart';
import 'package:howlook/review/feedback/model/normal_feedback_model.dart';
import 'package:howlook/review/feedback/view/feedback_result_screen.dart';

import '../model/normal_feedback_model_data.dart';

class NormalFeedbackCard extends StatelessWidget {
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  const NormalFeedbackCard(
      {required this.postId,
      required this.mainPhotoPath,
      required this.averageScore,
      Key? key})
      : super(key: key);

  factory NormalFeedbackCard.fromModel({
    required NormalFeedbackData model,
  }) {
    return NormalFeedbackCard(
      postId: model.postId,
      mainPhotoPath: model.mainPhotoPath,
      averageScore: model.averageScore,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 400,
    //   child: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Swiper(
    //       autoplay: false,
    //       scale: 0.9,
    //       viewportFraction: 0.8,
    //       // pagination: SwiperPagination(
    //       //   alignment: Alignment.bottomCenter
    //       // ),
    //       // control: SwiperControl(color: Colors.white),
    //       itemBuilder: (BuildContext context, int index) {
    //         return InkWell(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => FeedbackResult(
    //                   postId: postId,
    //               )),
    //             );
    //           },
    //           child: Stack(
    //               alignment: Alignment.center,
    //               children: [
    //                 Image.network('${mainPhotoPath}'),
    //                 Container(
    //                   child: Image.network(
    //                       '${mainPhotoPath}',
    //                     color: Colors.black.withOpacity(0.5),
    //                   ),
    //                 ),
    //                 Container(
    //                     alignment: Alignment.center,
    //                     child: Text('Score: ${averageScore}점', style: TextStyle(color: Colors.white),)
    //                 )
    //               ]),
    //         );
    //       },
    //     ),
    //   ),
    // );

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
                        'Score: ${averageScore}',
                        style: TextStyle(color: Colors.white),
                      ))
                ]),
              )
            : InkWell(
                onTap: () {
                  print(postId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedbackResult(
                              postId: postId,
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
                        'Score: ${averageScore}',
                        style: TextStyle(color: Colors.white),
                      ))
                ]),
              ));
  }
}
