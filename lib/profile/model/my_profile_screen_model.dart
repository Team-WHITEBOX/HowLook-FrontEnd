import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/profile/model/profile_memberPosts.dart';

// part 'my_profile_screen_model.g.dart';

// @JsonSerializable()
class MainProfileModel {
  // 아이디
  final String memberId;
  // 닉네임
  final String memberNickName;
  // 키
  final int memberHeight;
  // 몸무게
  final int memberWeight;
  // 포토아이디
  final String profilePhoto;

  final bool me;

  final int memberPostCount;

  final List<MemberPosts> memberPosts;


  MainProfileModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
    required this.me,
    required this.memberPostCount,
    required this.memberPosts,
  });

  // "memberId": "testuser10",
  // "memberNickName": "길동이",
  // "memberHeight": 180,
  // "memberWeight": 70,
  // "profilePhoto": null,
  // "memberPostCount": 2,
  // "memberPosts": [
  // {
  // "postId": 18,
  // "mainPhotoPath": "29cd2213-6fdc-48f6-baff-2c161a840e35_balancing-1868051_960_720.jpg"
  // },
  // {
  // "postId": 25,
  // "mainPhotoPath": "261d363f-c588-4dd3-abaf-952ca9173a49_man-1866574_960_720.jpg"
  // }
  // ],
  // "me": true


  factory MainProfileModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainProfileModel(
      memberId: json['memberId'],
      memberNickName: json['memberNickName'],
      memberHeight: json['memberHeight'],
      memberWeight: json['memberWeight'],
      profilePhoto: json['profilePhoto'],
      me: json['me'],
      memberPostCount: json['memberPostCount'],
      // memberPosts: (json['memberPosts'] as List<dynamic>?)?.map<MemberPosts>(
      //       (x) => MemberPosts(
      //     postId: x['postId'],
      //     mainPhotoPath: x['mainPhotoPath'],
      //   ),
      // ).toList() ?? [],
      memberPosts: json['memberPosts'].map<MemberPosts>(
        (x) => MemberPosts(
          postId: x['postId'],
          mainPhotoPath: x['mainPhotoPath'],
        ),
      ).toList(),
    );
  }


  // // 아이디
  // final String memberId;
  // // 닉네임
  // final String memberNickName;
  // // 키
  // final int memberHeight;
  // // 몸무게
  // final int memberWeight;
  // // 포토아이디
  // final String profilePhoto;
  //
  // final bool me;
  //
  // final int memberPostCount;
  //
  // final List<MemberPosts> memberPosts;
  //
  //
  // MainProfileModel({
  //   required this.memberId,
  //   required this.memberNickName,
  //   required this.memberHeight,
  //   required this.memberWeight,
  //   required this.profilePhoto,
  //   required this.me,
  //   required this.memberPostCount,
  //   required this.memberPosts,
  // });
  //
  // factory MainProfileModel.fromJson(Map<String, dynamic> json) =>
  //     _$MainProfileModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$MainProfileModelToJson(this);
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
