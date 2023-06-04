import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/model/feed_photo_dto.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeedCard extends StatelessWidget {
  final List<PhotoDTOs> photoDTOs;
  final int photoCount;

  const FeedCard({
    required this.photoDTOs,
    required this.photoCount,
    Key? key,
  }) : super(key: key);

  factory FeedCard.fromModel({
    required FeedModel model,
  }) {
    return FeedCard(
      photoCount: model.photoCount,
      photoDTOs: model.photoDTOs,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Container(
      height: 10,
      color: Colors.black,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return ExtendedImage.network(
                  photoDTOs[index].path,
                  fit: BoxFit.cover,
                  cache: true,
                );
              },
              itemCount: photoCount,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: photoCount == 1
                ? Container()
                : SmoothPageIndicator(
                    controller: controller,
                    count: photoCount,
                    effect: const WormEffect(
                      spacing: 5.0,
                      radius: 14.0,
                      dotWidth: 9.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.fill,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                      type: WormType.thinUnderground,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
