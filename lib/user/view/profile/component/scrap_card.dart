import 'package:flutter/material.dart';
import 'package:howlook/user/view/profile/model/scrap_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';

class ScrapCard extends StatelessWidget {

  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 이미지 갯수
  final int photoCnt;

  const ScrapCard({
    required this.npostId,
    required this.photoDTOs,
    required this.mainPhotoPath,
    required this.photoCnt,
    Key? key})
      : super(key: key);

  factory ScrapCard.fromModel({
    required ScrapModel model,
  }) {
    return ScrapCard(
      npostId: model.npostId,
      photoDTOs: model.photoDTOs,
      mainPhotoPath: model.mainPhotoPath,
      photoCnt: model.photoCnt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MainFeedDetailScreen(
              npostId: npostId,
            ),
          ));
        },
      child: Image.network(
          'https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${mainPhotoPath}',
        fit: BoxFit.cover,
      )
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
