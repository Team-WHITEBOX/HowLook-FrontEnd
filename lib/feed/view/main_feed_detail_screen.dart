import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/component/main_feed_detail_card.dart';

class MainFeedDetailScreen extends StatelessWidget {
  const MainFeedDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    List<String> list = [
      'asset/img/HL1.JPG',
      'asset/img/HL2.JPG',
      'asset/img/HL3.JPG',
    ];
    return DefaultLayout(
      title: '게시글',
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              MainFeedDetailCard(
                NPostId: 1,
                name: "홍길동",
                nickname: "nickname",
                profile_image: CircleAvatar(
                  radius: 18,
                  backgroundImage: Image.asset(
                    'asset/img/Profile/HL1.JPG',
                    fit: BoxFit.cover,
                  ).image,
                ),
                images: list,
                bodyinfo: [170.0, 50.1],
                PhotoCnt: 1,
                LikeCount: 1,
                Content: "1",
                CommentCount: 1,
              ),
              // 밑에 사진 인디케이터
            ],
          ),
        ),
      ),
    );
  }
}
