import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';

class NormalReview extends StatefulWidget {
  const NormalReview({Key? key}) : super(key: key);
  @override
  State<NormalReview> createState() => _NormalReviewState();
}

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

class _NormalReviewState extends State<NormalReview> {
  SliderController _scoreCountController = SliderController(0.0);
  bool? buttonPower;

  @override
  void initState() {
    buttonPower = false;
    super.initState();
  }
  final List<String> images
  = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'];

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
          TextButton(
            onPressed: () {
              buttonPower = true;
            },
            child: Text('제가 보기엔 ${controller.sliderValue}점 이에요!',style: TextStyle(color: Colors.black),),
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
                setState(() {
                  controller.sliderValue = newValue;
                },);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Normal Review',
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child:Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Container(
                      child: Image.asset('asset/img/Profile/HL1.JPG', fit: BoxFit.cover,),
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),),
                        buttonPower==true? _ReviewTabBar(true): _ReviewTabBar(false)
                      ]
                  )
                ),
              ]
            )
          )
        )
        )
    );
  }

  _ReviewTabBar(bool buttonPower){
    return Container(
      child:((){
        if( buttonPower == true) {
          return ButtonBar(
            children: [
              TextButton(
                onPressed: () {

                },
                child: Text("다음 평가하기", style: TextStyle(color: Colors.deepPurple),),
              ),
            ],
          );
        } else {
          return const Text('평가를 해주세요', style: TextStyle(color: Colors.black38));
        }
      })(),
    );
  }

}
