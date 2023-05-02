import 'package:flutter/material.dart';
import 'package:howlook/user/view/profile/model/feed_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:howlook/feed/view/feed_detail_screen.dart';
import 'package:extended_image/extended_image.dart';


class MyFeedCard extends StatelessWidget {

  final bool me;

  final int memberPostCount;

  final List<MemberPosts> memberPosts;

  const MyFeedCard(
      {
        required this.me,
        required this.memberPostCount,
        required this.memberPosts,
        Key? key})
      : super(key: key);

  factory MyFeedCard.fromModel({
    required MyFeedModel model,
  }) {
    return MyFeedCard(
      me: model.me,
      memberPostCount: model.memberPostCount,
      memberPosts: model.memberPosts,
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
              childCount: memberPosts.length,
                (_, int index) {
              // return InkWell(
              //   onTap: (){
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (_) => FeedDetailScreen(
              //         postId: memberPosts[index].postId,
              //       ),
              //     ));
              //   },
              //   child: Image.network(
              //     'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberPosts[index].mainPhotoPath}',
              //     fit: BoxFit.cover,
              //   ),
              // );
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => FeedDetailScreen(
                          postId: memberPosts[index].postId,
                        ),
                      ));
                    },
                    // child: memberPosts.isNotEmpty
                    //     ? ExtendedImage.network(
                    //   'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberPosts[index].mainPhotoPath}',
                    //   fit: BoxFit.cover,
                    //   cache: true,
                    // )
                    //     : FadeInImage.assetNetwork(
                    //   placeholder: 'asset/img/Profile/BaseProfile.JPG',
                    //   image: '',
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.network(
                      'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${memberPosts[index].mainPhotoPath}',
                      fit: BoxFit.cover,
                    ),
                  );
            }));
  }

}
