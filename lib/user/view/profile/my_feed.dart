import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({Key? key}) : super(key: key);

  @override
  State<MyFeed> createState() => _MyFeed();
}

class _MyFeed extends State<MyFeed> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'MyLook',
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate:SliverChildBuilderDelegate(
            (context, index)
            => Container(
              color: Colors.grey,
              child: Text('index: $index'),
            ),
          ),
        )
      )
    );
  }
}