import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';

class MainFeedCard extends StatelessWidget {
  // 이름
  final String name;
  // 별명
  final String nickname;
  // 프로필 사진
  final Widget profile_image;
  // 이미지
  final Widget images;
  // 몸무게, 키
  final List<double> bodyinfo;

  const MainFeedCard({
    required this.name,
    required this.nickname,
    required this.profile_image,
    required this.images,
    required this.bodyinfo,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: profile_image,
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  bodyinfo.join(' · '),
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: images,
        ),
      ],
    );
  }
}
