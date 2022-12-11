import 'package:flutter/material.dart';
import 'package:howlook/user/view/profile/model/feed_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';

class MyFeedCard extends StatelessWidget {

  final bool me;

  final int memberFeedCnt;

  final List<MemberFeeds> memberFeeds;

  const MyFeedCard(
      {
        required this.me,
        required this.memberFeedCnt,
        required this.memberFeeds,
        Key? key})
      : super(key: key);

  factory MyFeedCard.fromModel({
    required MyFeedModel model,
  }) {
    return MyFeedCard(
      me: model.me,
      memberFeedCnt: model.memberFeedCnt,
      memberFeeds: model.memberFeeds,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Image.network(
    //     'http://${API_SERVICE_URI}/photo/${memberFeeds[0].photoDTOs}',
    //     //'asset/img/Profile/HL1.JPG',
    //     fit: BoxFit.cover,
    //   ),
    // );
    return GridView.custom(
            shrinkWrap: true,
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
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: memberFeedCnt,
                (_, int index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MainFeedDetailScreen(
                      npostId: memberFeeds[index].npostId,
                    ),
                  ));
                },
                child: Image.network(
                  'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberFeeds[index].mainPhotoPath}',
                  fit: BoxFit.cover,
                ),
              );
            }));
  }

}
