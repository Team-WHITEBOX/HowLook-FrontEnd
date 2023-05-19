import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_icon_button.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/category_feed/category_screen.dart';
import 'package:howlook/feed/view/main_feed/main_feed_screen.dart';
import 'package:flutter/src/material/bottom_sheet.dart';
import 'package:howlook/feed/view/near_feed/near_feed_screen.dart';

import 'category_feed/category_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget? ShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return _BottomSheetContent();
      },
    );
  }

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
      child: feedTabBar(),
    );
  }

  Widget feedTabBar() {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
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
                    MenuBar('메인'),
                    MenuBar('카테고리'),
                    MenuBar('날씨'),
                    MenuBar('위치')
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
                MainFeedScreen(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (_) => CategoryScreen()),
                            // );
                            ShowModalBottomSheet(context);
                          },
                          icon: const Icon(Icons.filter_alt)),
                      MainFeedScreen(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                    //탭3 화면
                    ),
                const NearFeedScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget MenuBar(String menu) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const SizedBox(width: 2),
          Tab(
            child: Text(
              menu,
              style: const TextStyle(
                fontFamily: 'NotoSans',
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

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: CategoryScreen(),
        ),
      ),
    );
  }
}
