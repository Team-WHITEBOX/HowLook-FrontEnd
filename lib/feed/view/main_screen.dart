import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/view/category_screen.dart';
import 'package:howlook/feed/view/near_feed_screen.dart';
import 'package:howlook/feed/view/main_feed_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HowLook',
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NearFeedScreen()),
            );
          },
          icon: Icon(Icons.gps_fixed_rounded),
        ),
        IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CategoryScreen()),
              );
            },
            icon: Icon(Icons.filter_alt)),
      ],
      child: SafeArea(
        top: true,
        bottom: false,
        child: MainFeedScreen(),
      ),
    );
  }
}
