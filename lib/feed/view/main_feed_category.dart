import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';

// 반환에 사용할 클래스
class ReturnValue {
  bool? isMenChecked;
  bool? isWomenChecked;
  // 스타일
  bool? isMinimalChecked;
  bool? isCasualChecked;
  bool? isStreetChecked;
  bool? isAmericanCasualChecked;
  bool? isSportyChecked;
  bool? isEtcChecked;
  // 키
  double? minHeight;
  double? maxHeight;
  // 몸무게
  double? minWeight;
  double? maxWeight;

  ReturnValue({
    this.isMenChecked,
    this.isWomenChecked,
    this.isMinimalChecked,
    this.isCasualChecked,
    this.isStreetChecked,
    this.isAmericanCasualChecked,
    this.isSportyChecked,
    this.isEtcChecked,
    this.minWeight,
    this.maxWeight,
    this.minHeight,
    this.maxHeight,
  });
}

// 데이터 전달에 사용할 클래스
class Arguments {
  bool? isMenChecked;
  bool? isWomenChecked;
  // 스타일
  bool? isMinimalChecked;
  bool? isCasualChecked;
  bool? isStreetChecked;
  bool? isAmericanCasualChecked;
  bool? isSportyChecked;
  bool? isEtcChecked;
  // 키
  double? minHeight;
  double? maxHeight;
  // 몸무게
  double? minWeight;
  double? maxWeight;
  //반환때 사용할 클래스
  ReturnValue? returnValue;

  Arguments({
    this.isMenChecked,
    this.isWomenChecked,
    this.isMinimalChecked,
    this.isCasualChecked,
    this.isStreetChecked,
    this.isAmericanCasualChecked,
    this.isSportyChecked,
    this.isEtcChecked,
    this.minWeight,
    this.maxWeight,
    this.minHeight,
    this.maxHeight,
    this.returnValue,
  });
}

class CategoryScreen extends StatefulWidget {
  final argument;
  const CategoryScreen({Key? key, this.argument}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  // 성별
  bool isMenChecked = false;
  bool isWomenChecked = false;
  // 스타일
  bool isMinimalChecked = false;
  bool isCasualChecked = false;
  bool isStreetChecked = false;
  bool isAmericanCasualChecked = false;
  bool isSportyChecked = false;
  bool isEtcChecked = false;
  // 키
  double minHeight = 100.0;
  double maxHeight = 240.0;
  // 몸무게
  double minWeight = 20.0;
  double maxWeight = 165.0;

  RangeValues _currentHeightRangeValues = const RangeValues(100, 240);
  RangeValues _currentWeightRangeValues = const RangeValues(20, 165);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '카테고리',
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              this.isMenChecked = false;
              this.isWomenChecked = false;
              this.isMinimalChecked = false;
              this.isCasualChecked = false;
              this.isStreetChecked = false;
              this.isAmericanCasualChecked = false;
              this.isSportyChecked = false;
              this.isEtcChecked = false;
              this._currentHeightRangeValues = RangeValues(100, 240);
              this._currentWeightRangeValues = RangeValues(20, 165);
            });
          },
          child: Text(
            "초기화",
            style: TextStyle(
              color: BODY_TEXT_COLOR,
            ),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ******** 성별 ********
                // ** 성별 텍스트 **
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "GENDER",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // ** 성별 체크박스 **
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "MEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Checkbox(
                          value: this.isMenChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isMenChecked = value!;
                              if (this.isWomenChecked) {
                                this.isWomenChecked = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "WOMEN",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Checkbox(
                          value: this.isWomenChecked,
                          activeColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              this.isWomenChecked = value!;
                              if (this.isMenChecked) {
                                this.isMenChecked = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                // ******** 키 ********
                // ** 키 텍스트 **
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "HEIGHT",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10000,
                ),
                // ** 키 슬라이더 **
                // 여기 슬라이더 코드
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SliderTheme(
                    data: SliderThemeData(
                      inactiveTrackColor: Colors.black54,
                      activeTrackColor: PRIMARY_COLOR,
                      thumbColor: Colors.white,
                      inactiveTickMarkColor: Colors.white,
                      activeTickMarkColor: PRIMARY_COLOR,
                      valueIndicatorColor: PRIMARY_COLOR,
                      trackHeight: 2,
                      rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 10,
                        elevation: 5,
                      ),
                    ),
                    child: RangeSlider(
                      values: _currentHeightRangeValues,
                      min: minHeight,
                      max: maxHeight,
                      divisions: 200,
                      activeColor: PRIMARY_COLOR,
                      labels: RangeLabels(
                        _currentHeightRangeValues.start.round().toString(),
                        _currentHeightRangeValues.end.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          _currentHeightRangeValues = values;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // ******** 몸무게 ********
                // ** 몸무게 텍스트 **
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "WEIGHT",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10000,
                ),
                // ** 몸무게 슬라이더 **
                // 여기 슬라이더 코드
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SliderTheme(
                    data: SliderThemeData(
                      inactiveTrackColor: Colors.black54,
                      activeTrackColor: PRIMARY_COLOR,
                      thumbColor: Colors.white,
                      inactiveTickMarkColor: Colors.white,
                      activeTickMarkColor: PRIMARY_COLOR,
                      valueIndicatorColor: PRIMARY_COLOR,
                      trackHeight: 2,
                      rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 10,
                        elevation: 5,
                      ),
                    ),
                    child: RangeSlider(
                      values: _currentWeightRangeValues,
                      min: minWeight,
                      max: maxWeight,
                      divisions: 100,
                      activeColor: PRIMARY_COLOR,
                      labels: RangeLabels(
                        _currentWeightRangeValues.start.round().toString(),
                        _currentWeightRangeValues.end.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          _currentWeightRangeValues = values;
                        });
                      },
                    ),
                  ),
                ),


                // ******** 스타일 ********
                // ** 스타일 텍스트 **
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "STYLE",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10000,
                ),
                // ** 스타일 체크박스 **
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 40),
                          Text(
                            "미니멀",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            value: this.isMinimalChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isMinimalChecked = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                          ),
                          Text(
                            "캐주얼",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            value: this.isCasualChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isCasualChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "스트릿",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            value: this.isStreetChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isStreetChecked = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4,
                          ),
                          Text(
                            "아메카지",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Checkbox(
                            value: this.isAmericanCasualChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isAmericanCasualChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "스포티",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            value: this.isSportyChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isSportyChecked = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 9 + 4,
                          ),
                          Text(
                            "기타     ",
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                          Checkbox(
                            value: this.isEtcChecked,
                            activeColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              setState(() {
                                this.isEtcChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFF1D002D),
                            //Color(0xFFa17fe0),
                            Color(0xFF603674),
                            // #F9E79F
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            print(MediaQuery.of(context).size.width);
                            Navigator.pop(
                              context,
                              Arguments(
                                returnValue: ReturnValue(
                                  isMenChecked: isMenChecked,
                                  isWomenChecked: isWomenChecked,
                                  isMinimalChecked: isMinimalChecked,
                                  isCasualChecked: isCasualChecked,
                                  isStreetChecked: isStreetChecked,
                                  isAmericanCasualChecked:
                                      isAmericanCasualChecked,
                                  isSportyChecked: isSportyChecked,
                                  isEtcChecked: isEtcChecked,
                                  minHeight: minHeight,
                                  maxHeight: maxHeight,
                                  minWeight: minWeight,
                                  maxWeight: maxWeight,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "계속하기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
