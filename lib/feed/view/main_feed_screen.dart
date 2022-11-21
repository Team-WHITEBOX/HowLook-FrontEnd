import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'main_feed_category.dart';

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

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  double? Height;
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return DefaultLayout(
        title: 'HowLook',
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(50, 20),
                        ),
                        onPressed: () {},
                        child: Text(
                          "이웃",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(50, 20)),
                        onPressed: () {},
                        child: Text(
                          "모두",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        label: Text(''),
                        icon: Icon(
                          Icons.filter_alt,
                          size: 20.0,
                        ),
                        // 버튼 누르면 필터 설정 값 불러오기
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryScreen(
                                argument: Arguments(),
                              ),
                            ),
                          );

                          // result.returnValue에 카테고리 설정 값 날라옴
                          if (result != null) {
                            print("${result.returnValue.isMenChecked}");
                          }
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.black, minimumSize: Size(50, 20)),
                      ),
                    ],
                  ),
                  Text('$Height'),
                ],
              ),
            ),
          ),
        ));
  }
}
