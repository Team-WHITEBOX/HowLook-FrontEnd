import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/category_screen.dart';
import 'package:howlook/feed/view/near_feed_screen.dart';
import 'package:howlook/feed/view/main_feed_screen.dart';
import 'package:flutter/src/material/bottom_sheet.dart';

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
    return DefaultLayout(title: 'HowLook', child: FeedTabBar());
  }

  Widget FeedTabBar() {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft, //탭바 메뉴를 왼쪽으로 정렬
            child: TabBar(
              //위젯을 통해 상단 탭바 메뉴가 보여진다

              labelColor: Colors.black, //선택된 Tab의 label 색상
              unselectedLabelColor: Colors.grey, //선택되지 않은 Tab의 label 색상
              labelStyle: TextStyle(fontSize: 15),
              indicator: UnderlineTabIndicator(
                  //선택된 Tab에 스타일 적용 시 사용
                  borderSide: BorderSide(
                    //선택된 탭바 스타일 적용
                    width: 3,
                    color: Colors.deepPurple,
                  ),
                  insets: EdgeInsets.only(left: 10, right: 14, bottom: 4)),
              isScrollable: true, //탭의 크기가 label의 크기만큼 할당되며 스크롤이 가능
              labelPadding: EdgeInsets.only(left: 14, right: 2),
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '메인'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '카테고리'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '날씨'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '위치'),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              //위젯을 통해 하단 탭별 화면을 보여줌
              children: <Widget>[
                SingleChildScrollView(
                  child: MainFeedScreen(), //탭1 화면
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => CategoryScreen()),
                            );
                          },
                          icon: Icon(Icons.filter_alt)),
                      MainFeedScreen()
                    ],
                  ),
                    // child: ShowModalBottomSheet(context), //탭2 화면
                    ),
                Container(
                    //탭3 화면
                    ),
                SingleChildScrollView(
                  // child: NearFeedScreen(), //탭4 화면
                ),
              ],
            ),
          ),
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
        decoration: BoxDecoration(
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
