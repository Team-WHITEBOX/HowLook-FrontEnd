import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/main_feed_screen.dart';
import 'package:howlook/user/view/profile/profile_screen.dart';
import 'package:howlook/review/main_review_screen.dart';
import 'package:howlook/tournament/main_tournament_screen.dart';
import 'package:howlook/common/layout/bottom_navy_bar.dart';
import 'package:howlook/upload/main_liquid_swipe.dart';
import 'package:howlook/upload/feed_upload_screen.dart';
import 'package:howlook/upload/review_upload_screen.dart';


class RootTab extends StatefulWidget {
  final int? indexId;
  const RootTab({this.indexId, Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  // <- 애니메이션 관련된 것은 Single~를 선언해야 하는 것으로 우선 이해,
  // null을 안 받게 선언하지만, 나중에 대입하겠다는 뜻
  late TabController controller;
  int index = 0;
  bool check = false;

  @override
  void initState() {
    super.initState();
    // length는 TabBarView 밑의 children 개수, vsync는 위의 Single~ 이것과 관련된 것
    controller = TabController(length: 5, vsync: this);
    // controller에 Listener를 추가
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  void reloadTab() {
    if (widget.indexId != null && !check) {
      setState(() {
        index = widget.indexId!;
      });
      check = true;
      print('finish');
    }
  }

  @override
  void dispose() {
    // 이 State가 사라지기 전에 리스너 삭제하기,,,,
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      Stack(children: [
        Container(
          color: PRIMARY_COLOR,
        ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '피드 업로드',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FeedUpload(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 100,
                ),
              ]),
        )
      ]),
      Stack(children: [
        Container(
          color: Color(0xFFa6ceff),
        ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '리뷰 업로드',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ReviewUpload(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 100,
                ),
              ]),
        )
      ]),
    ];

    reloadTab();
    return DefaultLayout(
        child: TabBarView(
          // 탭바뷰 위에선 가로 스와이프 애니메이션 적용 x 하는 코드,
          // 만약 가로 스와이프 적용한다면 이 코드 제외
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            MainFeedScreen(),
            MainReviewScreen(),
            Builder(builder: (context) => LiquidSwipe(pages: pages)),
            tournamentScreen(),
            ProfileScreen(),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: PRIMARY_COLOR,
        //   unselectedItemColor: BODY_TEXT_COLOR,
        //   selectedFontSize: 10,
        //   unselectedFontSize: 10,
        //   // BottomNavigationBarType <- 밑에 아이콘 변화하는 애니메이션 지정
        //   type: BottomNavigationBarType.shifting,
        //   // 현재 탭 가리키는 코드, controller의 index를 애니메이션 적용
        //   onTap: (int index1) {
        //     print(index);
        //     controller.animateTo(index1);
        //   },
        //   currentIndex: index,
        //   // 여기 안에는 밑의 네비게이션 바의 내용을 가리키는 곳
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        //     BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '?'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.add_circle_outline_outlined), label: '업로드'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.theater_comedy_outlined), label: '토너먼트'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person_outlined), label: '프로필'),
        //   ],
        // ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: index,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (int index1) => setState(() {
            // _selectedIndex = index;
            // _pageController.animateToPage(index,
            //     duration: Duration(milliseconds: 300), curve: Curves.ease);
            print(index);
            controller.animateTo(index1);
          }),
          items: [
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: Icon(Icons.home_outlined),
              title: Text('Home'),
              activeColor: Colors.black,
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: Icon(Icons.message),
              title: Text('Review'),
              activeColor: Colors.black,
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: Icon(Icons.add_circle_outline_outlined),
              title: Text('Upload'),
              activeColor: Colors.black,
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: Icon(Icons.theater_comedy_outlined),
              title: Text('Tournament'),
              activeColor: Colors.black,
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: Icon(Icons.person_outlined),
              title: Text('Profile'),
              activeColor: Colors.black, //무슨 색이 어울릴까영..
            ),
          ],
        ));
  }
}
