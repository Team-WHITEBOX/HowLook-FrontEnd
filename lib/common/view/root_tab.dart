import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/home_screen.dart';
import 'package:howlook/upload/temp_screen/t_upload_screen.dart';
import 'package:howlook/upload/view/main_liquid_swipe.dart';
// import 'package:howlook/upload/view/upload_screen.dart';
import 'package:howlook/review/view/main_review_screen.dart';
import 'package:howlook/tournament/view/main_tournament_screen.dart';
import 'package:howlook/upload/view/review_upload_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int _bottomNavIndex = 0;
  bool check = false;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      _bottomNavIndex = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      Stack(
        children: [
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
                          builder: (_) => TUploadScreen(),
                          // builder: (_) => FeedUpload(),
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
        ],
      ),
      Stack(
        children: [
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
        ],
      ),
    ];
    return DefaultLayout(
      bottomNavigationBar: ConvexAppBar(
        curve: null,
        color: Colors.black,
        controller: controller,
        backgroundColor: Colors.white,
        style: TabStyle.fixedCircle,
        activeColor: Colors.black,
        cornerRadius: 15,
        height: 60,
        items: [
          TabItem(
              icon: Icon(
                  _bottomNavIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: 30)),
          TabItem(
              icon: Icon(
                  _bottomNavIndex == 1 ? Icons.reviews : Icons.reviews_outlined,
                  size: 30)),
          TabItem(
              icon: Icon(
                  _bottomNavIndex == 2
                      ? Icons.add_circle
                      : Icons.add_circle_outline,
                  color: Colors.white,
                  size: 40)),
          TabItem(
              icon: Icon(
                  _bottomNavIndex == 3
                      ? Icons.theater_comedy
                      : Icons.theater_comedy_outlined,
                  size: 30)),
          TabItem(
              icon: Icon(
                  _bottomNavIndex == 4
                      ? Icons.person_2
                      : Icons.person_2_outlined,
                  size: 30)),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          HomeScreen(),
          MainReviewScreen(),
          Builder(builder: (context) => LiquidSwipe(pages: pages)),
          tournamentScreen(),
          MyProfileScreen(),
        ],
      ),
    );
  }
}
