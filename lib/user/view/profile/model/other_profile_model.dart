class OtherProfileModel {
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

  OtherProfileModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
    required this.me,
    required this.memberPostCount,
    required this.memberPosts,
  });

  // "memberId": "jinbum99",
  // "memberNickName": "진범",
  // "memberHeight": 100,
  // "memberWeight": 200,
  // "profilePhoto": null,
  // "memberFeeds": [],
  // "me": true


  factory OtherProfileModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return OtherProfileModel(
      memberId: json['memberId'],
      memberNickName: json['memberNickName'],
      memberHeight: json['memberHeight'],
      memberWeight: json['memberWeight'],
      profilePhoto: json['profilePhoto'],
      me: json['me'],
      memberPostCount: json['memberFeedCnt'],
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
      postId: json['npostId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}

//
// class OtherProfileModel {
//   // 아이디
//   final String memberId;
//   // 닉네임
//   final String memberNickName;
//   // 키
//   final int memberHeight;
//   // 몸무게
//   final int memberWeight;
//   // 포토아이디
//   final String profilePhoto;
//
//   final bool me;
//
//   final int memberPostCount;
//
//   final List<MemberPosts> memberPosts;
//
//   OtherProfileModel({
//     required this.memberId,
//     required this.memberNickName,
//     required this.memberHeight,
//     required this.memberWeight,
//     required this.profilePhoto,
//     required this.me,
//     required this.memberPostCount,
//     required this.memberPosts,
//   });
//
//   // "memberId": "jinbum99",
//   // "memberNickName": "진범",
//   // "memberHeight": 100,
//   // "memberWeight": 200,
//   // "profilePhoto": null,
//   // "memberFeeds": [],
//   // "me": true
//
//
//   factory OtherProfileModel.fromJson({
//     required Map<String, dynamic> json,
//   }) {
//     return OtherProfileModel(
//       memberId: json['memberId'],
//       memberNickName: json['memberNickName'],
//       memberHeight: json['memberHeight'],
//       memberWeight: json['memberWeight'],
//       profilePhoto: json['profilePhoto'],
//       me: json['me'],
//       memberPostCount: json['memberFeedCnt'],
//       memberPosts: json['memberFeeds'].map<MemberPosts>(
//             (x) => MemberPosts(
//           postId: x['postId'],
//           mainPhotoPath: x['mainPhotoPath'],
//         ),
//       ).toList(),
//     );
//   }
//
// }
//
// class MemberPosts {
//   // 포스트 아이디
//   final int postId;
//   // 첫 장 이미지 경로
//   final String mainPhotoPath;
//
//   MemberPosts({
//     required this.postId,
//     required this.mainPhotoPath,
//   });
//
//   factory MemberPosts.fromJson({
//     required Map<String, dynamic> json,
//   }) {
//     return MemberPosts(
//       postId: json['npostId'],
//       mainPhotoPath: json['mainPhotoPath'],
//     );
//   }
// }
