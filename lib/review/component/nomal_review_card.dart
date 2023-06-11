import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/model/review_model.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:http/http.dart' as http;
import 'package:howlook/review/view/normal_review_screen.dart';

import '../model/review_model_data.dart';
import '../view/main_review_screen.dart';

class NormalReviewCard extends ConsumerStatefulWidget {
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  final double averageScore;
  final int hasMore;

  NormalReviewCard({
    Key? key,
    required this.postId,
    required this.mainPhotoPath,
    required this.averageScore,
    required this.hasMore,
  }) : super(key: key);

  factory NormalReviewCard.fromModel({
    required ReviewModelData model,
  }) {
    return NormalReviewCard(
      postId: model.postId,
      mainPhotoPath: model.mainPhotoPath,
      averageScore: model.averageScore,
      hasMore: model.hasMore,

    );
  }

  @override
  ConsumerState<NormalReviewCard> createState() => _NormalReviewCardState();
}

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

class _NormalReviewCardState extends ConsumerState<NormalReviewCard> {
  SliderController _scoreCountController = SliderController(0.0);
  bool? buttonPower = false;

  @override
  void initState() {
    buttonPower = false;
    super.initState();
  }

  Widget buildSlider({
    required SliderController controller,
    int? divisions,
    Color color = Colors.black87,
    double enabledThumbRadius = 10.0,
    double elevation = 1.0,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '제가 보기엔 ${controller.sliderValue}점 이에요!',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: PRIMARY_COLOR,
              thumbColor: Colors.white,
              activeTickMarkColor: PRIMARY_COLOR,
              valueIndicatorColor: PRIMARY_COLOR,
              inactiveTickMarkColor: Colors.white,
              inactiveTrackColor: Colors.black54,
              trackHeight: 2,
              //thumbShape: RoundSliderThumbShape(
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 5,
              ),
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            ),
            child: Slider(
              value: controller.sliderValue,
              min: 0.0,
              max: 10.0,
              divisions: divisions,
              activeColor: PRIMARY_COLOR,
              label: '${controller.sliderValue.round()}',
              onChanged: (newValue) {
                setState(
                      () {
                    controller.sliderValue = newValue;
                    buttonPower = true;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 0.8,
        child: Container(
          child: Image.network(
            // 'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.mainPhotoPath}',
            '${widget.mainPhotoPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
          padding: EdgeInsets.all(30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSlider(
                  controller: _scoreCountController,
                  divisions: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                buttonPower == true ? _ReviewTabBar(true) : _ReviewTabBar(false)
              ])),
    ]);
  }

  _ReviewTabBar(bool buttonPower) {
    return Container(
      child: (() {
        if (buttonPower == true) {
          return ButtonBar(
            children: [
              AnimatedButton(
                height: 35,
                width: 90,
                text: 'SUBMIT',
                selectedTextColor: Colors.grey,
                transitionType: TransitionType.LEFT_TO_RIGHT,
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: PRIMARY_COLOR,
                borderColor: Colors.white,
                borderRadius: 50,
                borderWidth: 2,
                onPress: () async {
                  final dio = Dio();
                  final storage = ref.read(secureStorageProvider);
                  final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
                  final resp = await dio.post(
                    'http://$API_SERVICE_URI/eval/reply/register?postId=${widget.postId}&score=${_scoreCountController.sliderValue}',
                    // 'pid=${widget.postId}&score=${_scoreCountController.sliderValue}',
                    options: Options(
                      headers: {
                        'authorization': 'Bearer $accessToken',
                      },
                    ),
                  );
                  // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
                  // String url = 'http://$API_SERVICE_URI/eval/reply/register';
                  //
                  // http.Response response = await http.post(
                  //   // Uri(path: url),
                  //   url,
                  //   headers: {
                  //       'authorization': 'Bearer $accessToken',
                  //     },
                  //   body: <String, String> {
                  //     'pid': '${widget.npostId}',
                  //     'score': '${_scoreCountController.sliderValue}'
                  //   },
                  // );
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (_) => NormalReview(),
                  //   ),
                  // );
                  if(widget.hasMore != 0){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => NormalReview(),
                      ),
                    );
                  }
                  else{
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (_) => MainReviewScreen(),
                      ),
                    );
                  }

                },
              ),
            ],
          );
        } else {
          return const Text('평가를 해주세요',
              style: TextStyle(color: Colors.black38));
        }
      })(),
    );
  }
}