import 'package:flutter/material.dart';
import 'package:howlook/profile/model/scrap_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/view/feed_detail_screen.dart';

class ScrapCard extends StatelessWidget {

  final List<ScrapList> scraps;

  const ScrapCard({
    required this.scraps,
    Key? key})
      : super(key: key);

  factory ScrapCard.fromModel({
    required ScrapModel model,
  }) {
    return ScrapCard(
      scraps: model.scraps,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: scraps.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FeedDetailScreen(
                postId: scraps[index].postId,
              ),
            ));
          },
          child: Image.network(
            'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${scraps[index].mainPhotoPath}',
            fit: BoxFit.cover,
          ),
        );
      },
    );
    // return GridView.builder(
    //   //physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: photoDTOs.length,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         childAspectRatio: 1,
    //         mainAxisSpacing: 1,
    //         crossAxisSpacing: 1
    //     ),
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         child: Image.network(
    //           'http://${API_SERVICE_URI}/photo/${photoDTOs[index].path}',
    //           //'asset/img/Profile/HL1.JPG',
    //           fit: BoxFit.cover,)
    //       );

          //return Stack(
          //children: [
          //Container(child: Image.asset(images[index], fit: BoxFit.cover,)),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Checkbox(
          //     value: _checks[index],
          //     onChanged: (newValue) {
          //       setState(() {
          //         _checks[index] = newValue;
          //       },);
          //     },
          //   ),
          // ),
          //],
          //);
        }

}
