import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({Key? key}) : super(key: key);

  @override
  State<MyFeed> createState() => _MyFeed();
}

class _MyFeed extends State<MyFeed> {
  final List<String> images = <String>['asset/img/Profile/HL1.JPG', 'asset/img/Profile/HL2.JPG', 'asset/img/Profile/HL3.JPG', 'asset/img/Profile/HL4.JPG'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'My Look',
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
            childCount: images.length,
            (context, index)
            => Container(
              child: Image.asset(images[index], fit: BoxFit.cover,),
            ),
          ),
        )
      )
    );
  }
}