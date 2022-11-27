import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/component/main_feed_detail_comment.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedDetailCard extends StatelessWidget {
  // 포스트 아이디
  final int NPostId;
  // 이름
  final String name;
  // 별명
  final String nickname;
  // 프로필 사진
  final Widget profile_image;
  // 이미지
  final List<String> images;
  // 이미지 갯수
  final int PhotoCnt;
  // 몸무게, 키
  final List<double> bodyinfo;
  // 좋아요
  final int LikeCount;
  // 댓글
  final int CommentCount;
  // 내용
  final String Content;

  const MainFeedDetailCard(
      {required this.NPostId,
      required this.name,
      required this.nickname,
      required this.profile_image,
      required this.images,
      required this.PhotoCnt,
      required this.bodyinfo,
      required this.LikeCount,
      required this.CommentCount,
      required this.Content,
      Key? key})
      : super(key: key);

  factory MainFeedDetailCard.fromModel({
    required MainFeedDetailModel model,
  }) {
    return MainFeedDetailCard(
      NPostId: model.NPostId,
      PhotoCnt: model.PhotoCnt,
      images: model.images,
      name: model.name,
      nickname: model.nickname,
      profile_image: CircleAvatar(
        radius: 18,
        // 여기에 프로필 사진 없을 경우, 기본 이미지로 로드하는것도 있어야 할 듯,,,
        /*
        * backgroundImage: profile_image == null
        * ? AssetImage('asset/img/Profile/HL2.JPG')
        * : FileImage(File(profile.path)),
        * */
        backgroundImage: Image.network(
          model.profile_image,
          fit: BoxFit.cover,
        ).image,
      ),
      bodyinfo: model.bodyinfo,
      LikeCount: model.LikeCount,
      CommentCount: model.CommentCount,
      Content: model.Content,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    // 임시로 리스트 주기
    List<String> list = [
      'asset/img/Profile/HL1.JPG',
      'asset/img/Profile/HL2.JPG',
      'asset/img/Profile/HL3.JPG',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //child: Image.network(images[index], fit: BoxFit.cover,),
                child: Image.asset(
                  list[index],
                  fit: BoxFit.cover,
                ),
                // -> 네트워크로 수정하기
              );
            },
            itemCount: 3, // -> PhotoCnt로 수정
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SmoothPageIndicator(
              controller: _controller,
              count: 3, // -> PhotoCnt로 수정
              effect: ExpandingDotsEffect(
                  spacing: 5.0,
                  radius: 8.0,
                  dotWidth: 12.0,
                  dotHeight: 12.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Colors.grey,
                  activeDotColor: PRIMARY_COLOR),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  label: Text(''),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return MainFeedDetailComment();
                      },
                      backgroundColor: Colors.transparent,
                    );
                  },
                  icon: Icon(
                    Icons.comment,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                ),
                TextButton.icon(
                  label: Text(''),
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        )
      ],
    );
  }
}
