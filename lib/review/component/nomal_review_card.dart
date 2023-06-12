import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/model/normal_review_model.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:http/http.dart' as http;
import 'package:howlook/review/view/normal_review_screen.dart';

import '../model/normal_review_model_data.dart';
import '../repository/normal_review_repository.dart';
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

  Widget _ReviewTabBar(bool buttonPower) {
    final repo = ref.watch(NormalReviewRepositoryProvider);
    final bool check = false;

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
                  final code = await repo.postNormalReviewReply(
                    postId: widget.postId,
                    score: _scoreCountController.sliderValue,
                  );

                  try {
                    final data = await repo.reviewData();

                    if (code.response.statusCode == 200) {
                      if (data.message.toLowerCase().contains("실패")) {
                        // "실패"라는 단어가 포함되어 있을 때
                        if (!mounted) return;
                        Navigator.pop(context);
                        // 화면 전환 후 화면 새로고침
                        setState(() {});
                      } else if (data.message.toLowerCase().contains("성공")) {
                        if (!mounted) return;
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => NormalReview(),
                          ),
                        )
                            .then((_) {
                          // 화면 전환 후 화면 새로고침
                          setState(() {});
                        });
                      }
                    } else {
                      print(code.data.toString());

                      code.response.statusCode == 200 ? !check : check;

                      if (widget.hasMore != 0 && check == true) {
                        if (!mounted) return;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => NormalReview(),
                          ),
                        );
                      } else if (widget.hasMore == 0 && check == true) {
                        if (!mounted) return;
                        Navigator.pop(context);
                        setState(() {});
                      } else {
                        AlertDialog(
                          content: Text(
                            "오류발생😅",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            _DialogButton(text: "확인"),
                          ],
                          backgroundColor: Colors.black87,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }
                    }
                  } catch (err) {
                    // "실패"라는 단어가 포함되어 있을 때
                    if (!mounted) return;
                    Navigator.pop(context);
                    // 화면 전환 후 화면 새로고침
                    setState(() {});
                  }
                },
              ),
            ],
          );
        } else {
          return const Text(
            '평가를 해주세요',
            style: TextStyle(color: Colors.black38),
          );
        }
      })(),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop(text);
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
