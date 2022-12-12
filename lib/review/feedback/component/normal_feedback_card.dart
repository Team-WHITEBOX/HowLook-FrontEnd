import 'package:flutter/material.dart';
import 'package:howlook/user/view/profile/model/scrap_model.dart';
import 'package:howlook/review/feedback/model/normal_feedback_model.dart';
import 'package:howlook/review/feedback/view/feedback_result_screen.dart';

class NormalReviewCard extends StatelessWidget {

  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  const NormalReviewCard({
    required this.npostId,
    required this.mainPhotoPath,
    required this.averageScore,
    Key? key})
      : super(key: key);

  factory NormalReviewCard.fromModel({
    required NormalReviewModel model,
  }) {
    return NormalReviewCard(
      npostId: model.npostId,
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
    //                   //npostId: npostId,
    //               )),
    //             );
    //           },
    //           child: Stack(
    //               alignment: Alignment.center,
    //               children: [
    //                 Image.network('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${mainPhotoPath}'),
    //                 Container(
    //                   child: Image.network(
    //                       'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${mainPhotoPath}',
    //                     color: Colors.black.withOpacity(0.5),
    //                   ),
    //                 ),
    //                 Container(
    //                     alignment: Alignment.center,
    //                     child: Text('Score: 5점', style: TextStyle(color: Colors.white),)
    //                 )
    //               ]),
    //         );
    //       },
    //     ),
    //   ),
    // );

    return Container(
      child: averageScore==0.0?
      InkWell(
        onTap: () {},
        child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${mainPhotoPath}'),
              // Image.asset('asset/img/Profile/HL1.JPG'),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text('Score: ${averageScore}', style: TextStyle(color: Colors.white),)
              )
            ]),
      )
    : InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedbackResult(
            npostId: npostId,
          )),
        );
      },
      child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${mainPhotoPath}'),
            // Image.asset('asset/img/Profile/HL1.JPG'),
            Container(
                color: Colors.black.withOpacity(0.5),
              ),
            Container(
                alignment: Alignment.center,
                child: Text('Score: ${averageScore}', style: TextStyle(color: Colors.white),)
            )
          ]),
      ));
  }
}
