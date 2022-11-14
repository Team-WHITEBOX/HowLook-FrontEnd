import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HowLook',
      child: Center(
        child: Text('RootTab'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
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
