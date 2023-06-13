import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:howlook/chat/view/chat_home_screen.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/home_screen.dart';
import 'package:howlook/profile/provider/profile_provider.dart';
import 'package:howlook/profile/view/profile/my_profile_screen.dart';
import 'package:howlook/upload/Provider/review_upload_provider.dart';
import 'package:howlook/upload/view/photo_selected_screen.dart';
import 'package:howlook/review/view/main_review_screen.dart';
import 'package:howlook/tournament/view/main_tournament_screen.dart';

import '../../payment/view/main_payment_screen.dart';
import '../const/data.dart';
import '../secure_storage/secure_storage.dart';

class RootTab extends ConsumerStatefulWidget {
  bool? isCharge;

  RootTab({
    this.isCharge = false,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _bottomNavIndex = 4;
  bool check = false;
  String memberId = "";

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.index = 4;
    controller.addListener(tabListener);

    if (widget.isCharge != null && widget.isCharge == true) {
      controller.index = 1;
      _bottomNavIndex = 1;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isCharge != null && widget.isCharge == true) {
        show();
      }
    });
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

  show() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const MainPaymentScreen();
      },
      elevation: 50,
      enableDrag: true,
      isDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      constraints: const BoxConstraints(
        minHeight: 250,
        maxHeight: 450,
      ),
    );
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
        icons: [
          _bottomNavIndex == 0 ? Icons.forum : Icons.forum_outlined,
          _bottomNavIndex == 1 ? Icons.analytics : Icons.analytics_outlined,
          _bottomNavIndex == 2
              ? Icons.theater_comedy
              : Icons.theater_comedy_outlined,
          _bottomNavIndex == 3 ? Icons.person_2 : Icons.person_2_outlined,
        ],
        height: 60,
        iconSize: 32,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeIndex: _bottomNavIndex,
        onTap: (index) async {
          if (index == 3) {
            final storage = ref.watch(secureStorageProvider);
            memberId = (await storage.read(key: USERMID_KEY))!;
            await ref
                .read(profileProvider(memberId).notifier)
                .getUserInfoData();
          }
          controller.index = index;
        },
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          const ChatHomeScreen(),
          MainReviewScreen(),
          const MainTournamentScreen(),
          MyProfileScreen(
            memberId: memberId,
          ),
          const HomeScreen(),
        ],
      ),
    );
  }

  Widget uploadFloatingButton() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      animatedIconTheme: const IconThemeData(size: 60),
      backgroundColor: Colors.black,
      visible: true,
      curve: Curves.bounceIn,
      childrenButtonSize: const Size(72, 72),
      spaceBetweenChildren: 18,
      children: [
        // 아이콘은 추후 결정
        SpeedDialChild(
          child: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
            size: 32,
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
            fontSize: 18.0,
          ),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
            size: 32,
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
            fontSize: 18.0,
          ),
          labelBackgroundColor: Colors.black,
        )
      ],
    );
  }
}
