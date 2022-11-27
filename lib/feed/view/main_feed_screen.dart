import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';
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
  // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
  Future<List> paginateMainFeed() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$ip/',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 이웃, 모두, 카테고리 버튼 관련
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(50, 20),
                        ),
                        onPressed: () {
                          // 임시로 이웃버튼 누르면 각 피드 상세 페이지로 이동할 수 있게 우선 구현
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => MainFeedDetailScreen(),
                              )
                          );
                        },
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
                  FutureBuilder<List>(
                    future: paginateMainFeed(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      // 에러처리
                      if (!snapshot.hasData) {
                        // 임시로 Container 반환하게 해둠
                        return Container();
                      }
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          // 받아온 데이터 JSON 매핑하기
                          // 모델 사용
                          final item = snapshot.data![index];
                          final pItem = MainFeedModel.fromJson(json: item);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => MainFeedDetailScreen(),
                                )
                              );
                            },
                              child: MainFeedCard.fromModel(model: pItem));
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(height: 16.0);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
