import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/main_feed_screen.dart';
import 'package:howlook/user/view/profile/profile_screen.dart';
import 'package:howlook/review/main_review_screen.dart';

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
          Center(child: Container(child: Text('업로드'))),
          Center(child: Container(child: Text('토너먼트'))),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // BottomNavigationBarType <- 밑에 아이콘 변화하는 애니메이션 지정
        type: BottomNavigationBarType.shifting,
        // 현재 탭 가리키는 코드, controller의 index를 애니메이션 적용
        onTap: (int index1) {
          print(index);
          controller.animateTo(index1);
        },
        currentIndex: index,
        // 여기 안에는 밑의 네비게이션 바의 내용을 가리키는 곳
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '?'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: '업로드'),
          BottomNavigationBarItem(
              icon: Icon(Icons.theater_comedy_outlined), label: '토너먼트'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
    );
  }
}
