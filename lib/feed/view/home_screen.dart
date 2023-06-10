import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/feed/view/weather_feed/weather_feed_screen.dart';


import '../../common/component/cust_icon_button.dart';
import '../../common/layout/default_layout.dart';
import 'category_feed/category_feed_screen.dart';
import 'near_feed/near_feed_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HowLook',
      actions: <Widget>[
        CustIconButton(
          onTap: () {},
          icon: Icons.chat_bubble,
        ),
        const SizedBox(width: 30),
        CustIconButton(
          onTap: () {},
          icon: Icons.notifications,
        ),
        const SizedBox(width: 30),
      ],
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.topLeft, // 탭바 메뉴를 왼쪽으로 정렬
                  child: TabBar(
                    // 위젯을 통해 상단 탭바 메뉴가 보여진다
                    labelColor: Colors.black, // 선택된 Tab의 label 색상
                    unselectedLabelColor: Colors.grey, // 선택되지 않은 Tab의 label 색상
                    labelStyle: const TextStyle(fontSize: 15),
                    indicator: const UnderlineTabIndicator(
                        //선택된 Tab에 스타일 적용 시 사용
                        borderSide: BorderSide(
                          //선택된 탭바 스타일 적용
                          width: 2.5,
                          color: Colors.black,
                        ),
                        insets: EdgeInsets.all(6)),
                    isScrollable: true, //탭의 크기가 label의 크기만큼 할당되며 스크롤이 가능
                    labelPadding: EdgeInsets.zero,
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    tabs: <Widget>[
                      menuBar('추천'),
                      menuBar('날씨별코디'),
                      menuBar('지역별코디')
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                //위젯을 통해 하단 탭별 화면을 보여줌
                children: <Widget>[
                  CategoryFeedScreen(),
                  const WeatherFeedScreen(),
                  const NearFeedScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBar(String menu) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const SizedBox(width: 2),
          Tab(
            child: Text(
              menu,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
