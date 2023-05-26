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


class CreaterReviewCard extends ConsumerStatefulWidget {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;

  CreaterReviewCard({
    Key? key,
    required this.npostId,
    required this.mainPhotoPath,
  }) : super(key: key);

  factory CreaterReviewCard.fromModel({
    required ReviewModel model,
  }) {
    return CreaterReviewCard(
      npostId: model.npostId,
      mainPhotoPath: model.mainPhotoPath,
    );
  }

  @override
  ConsumerState<CreaterReviewCard> createState() => _CreaterReviewCardState();
}

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

class _CreaterReviewCardState extends ConsumerState<CreaterReviewCard> with RestorationMixin{
  SliderController _scoreCountController = SliderController(0.0);
  bool? buttonPower = false;

  late RestorableRouteFuture<String> _createrDialogRoute;

  @override
  String get restorationId => 'dialog_creater';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(
      _createrDialogRoute,
      '크리에이터 한줄 평가',
    );
  }

  // Displays the popped String value in a SnackBar.
  void _showInSnackBar(String value) {
    // The value passed to Navigator.pop() or null.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '크리에이터 평가',
        ),
      ),
    );
  }

  @override
  void initState() {
    buttonPower = false;
    super.initState();
    _createrDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_simpleDialogDemoRoute);
      },
      onComplete: _showInSnackBar,
    );
  }

  static Route<String> _simpleDialogDemoRoute(
      BuildContext context,
      Object? arguments,
      ) {
    final theme = Theme.of(context);

    return DialogRoute<String>(
      context: context,
      builder: (context) => Container(
        child: SimpleDialog(
          // title: Text(GalleryLocalizations.of(context)!.dialogSetBackup),
          children: [
            _DialogDemoItem(
              icon: Icons.account_circle,
              color: theme.colorScheme.primary,
              text: 'username@gmail.com',
            ),
            _DialogDemoItem(
              icon: Icons.account_circle,
              color: theme.colorScheme.secondary,
              text: 'user02@gmail.com',
            ),
            _DialogDemoItem(
              icon: Icons.add_circle,
              text: 'GalleryLocalizations.of(context)!.dialogAddAccount',
              color: theme.disabledColor,
            ),
          ],
        ),
      ),
    );
  }


  Widget buildSlider({
    required SliderController controller,
    int? divisions,
    Color color = Colors.deepPurple,
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
            'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.mainPhotoPath}',
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
                    'http://$API_SERVICE_URI/eval/reply/register?pid=${widget.npostId}&score=${_scoreCountController.sliderValue}',
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => NormalReview(),
                    ),
                  );
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

class _DialogDemoItem extends StatelessWidget {
  const _DialogDemoItem({
    this.icon,
    this.color,
    required this.text,
  });

  final IconData? icon;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        Navigator.of(context).pop(text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}