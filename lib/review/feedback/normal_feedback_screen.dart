import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:howlook/review/feedback/feedback_result_screen.dart';

class NormalFeedback extends StatefulWidget {
  const NormalFeedback({Key? key}) : super(key: key);

  @override
  State<NormalFeedback> createState() => _NormalFeedbackState();
}

class _NormalFeedbackState extends State<NormalFeedback> {
  final List<String> images = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
                  child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reviewFeed(),
        ],
      )))),
    );
  }

  Widget reviewFeed() {
    return Container(
      height: 400,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Swiper(
          autoplay: false,
          scale: 0.9,
          viewportFraction: 0.8,
          // pagination: SwiperPagination(
          //   alignment: Alignment.bottomCenter
          // ),
          // control: SwiperControl(color: Colors.white),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackResult()),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                  children: [
                Image.asset(images[index]),
                Container(
                  child: Image.asset(
                    images[index],
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                    child: Text('Score: 5점', style: TextStyle(color: Colors.white),)
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
