import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:howlook/chat/view/chat_home_screen.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/home_screen.dart';
import 'package:howlook/profile/view/my_profile_screen.dart';
import 'package:howlook/upload/Provider/review_upload_provider.dart';
import 'package:howlook/upload/view/photo_selected_screen.dart';
import 'package:howlook/review/view/main_review_screen.dart';
import 'package:howlook/tournament/view/main_tournament_screen.dart';

class RootTab extends ConsumerStatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _bottomNavIndex = 0;
  bool check = false;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.index = 4;
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
    return DefaultLayout(
      floatingActionButton: SizedBox(
        height: 45.0,
        width: 45.0,
        child: FittedBox(
          child: controller.index != 4
              ? FloatingActionButton(
                  backgroundColor: Colors.black87,
                  child: const Icon(Icons.home),
                  onPressed: () {
                    controller.index = 4;
                  },
                )
              : uploadFloatingButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.chat,
          Icons.chair,
          Icons.theater_comedy_outlined,
          Icons.person_2_outlined,
        ],
        height: 50,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeIndex: _bottomNavIndex,
        onTap: (index) => controller.index = index,
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          const ChatHomeScreen(),
          MainReviewScreen(),
          const tournamentScreen(),
          MyProfileScreen(),
          const HomeScreen(),
        ],
      ),
    );
  }

  Widget uploadFloatingButton() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      // animatedIcon: AnimatedIcons.arrow_menu,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: Colors.black,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // 아이콘은 추후 결정
        SpeedDialChild(
          child: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PhotoSelectScreen(),
                // builder: (_) => FeedUpload(),
              ),
            );
          },
          label: '피드 업로드',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 14.0,
          ),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onTap: () {
            ref.read(isReviewUpload.notifier).update((state) => true);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PhotoSelectScreen(),
              ),
            );
          },
          label: '평가 업로드',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 14.0,
          ),
          labelBackgroundColor: Colors.black,
        )
      ],
    );
  }
}

// ConvexAppBar(
// curve: null,
// color: Colors.black,
// controller: controller,
// backgroundColor: Colors.white,
// style: TabStyle.fixedCircle,
// activeColor: Colors.black,
// cornerRadius: 15,
// height: 60,
// items: [
// TabItem(
// icon: Icon(
// _bottomNavIndex == 0 ? Icons.home : Icons.home_outlined,
// size: 30)),
// TabItem(
// icon: Icon(
// _bottomNavIndex == 1 ? Icons.reviews : Icons.reviews_outlined,
// size: 30)),
// TabItem(
// icon: Icon(
// _bottomNavIndex == 2
// ? Icons.add_circle
//     : Icons.add_circle_outline,
// color: Colors.white,
// size: 40)),
// TabItem(
// icon: Icon(
// _bottomNavIndex == 3
// ? Icons.theater_comedy
//     : Icons.theater_comedy_outlined,
// size: 30)),
// TabItem(
// icon: Icon(
// _bottomNavIndex == 4
// ? Icons.person_2
//     : Icons.person_2_outlined,
// size: 30)),
// ],
// ),
