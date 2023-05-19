import 'package:howlook/profile/model/my_profile_screen_model.dart';

class MyFeedModel {

  final bool me;

  final int memberPostCount;

  final List<MemberPosts> memberPosts;


  MyFeedModel({
    required this.me,
    required this.memberPostCount,
    required this.memberPosts,
  });



  factory MyFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MyFeedModel(
      me: json['me'],
      memberPostCount: json['memberPostCount'],
      memberPosts: json['memberPosts'].map<MemberPosts>(
            (x) => MemberPosts(
          postId: x['postId'],
          mainPhotoPath: x['mainPhotoPath'],
        ),
      ).toList(),
    );
  }

}

class MemberPosts {
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;

  MemberPosts({
    required this.postId,
    required this.mainPhotoPath,
  });

  factory MemberPosts.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MemberPosts(
      postId: json['postId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}

