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

  final int memberFeedCnt;

  final List<MemberFeeds> memberFeeds;

  MainProfileModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
    required this.me,
    required this.memberFeedCnt,
    required this.memberFeeds,
  });

  // "memberId": "jinbum99",
  // "memberNickName": "진범",
  // "memberHeight": 100,
  // "memberWeight": 200,
  // "profilePhoto": null,
  // "memberFeeds": [],
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
      memberFeedCnt: json['memberFeedCnt'],
      memberFeeds: json['memberFeeds'].map<MemberFeeds>(
            (x) => MemberFeeds(
              npostId: x['npostId'],
              photoDTOs: x[<dynamic>['photoDTOs']],
              mainPhotoPath: x['mainPhotoPath'],
              photoCnt: x['photoCnt'],
        ),
      ).toList(),
    );
  }

}

class MemberFeeds {
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 이미지 갯수
  final int photoCnt;

  MemberFeeds({
    required this.npostId,
    required this.photoDTOs,
    required this.mainPhotoPath,
    required this.photoCnt,
  });

  factory MemberFeeds.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MemberFeeds(
      npostId: json['npostId'],
      photoDTOs: json['photoDTOs'].map<PhotoDTOs>(
            (x) => PhotoDTOs(
          path: x['path'],
          photoId: x['photoId'],
        ),
      ).toList(),
      mainPhotoPath: json['mainPhotoPath'],
      photoCnt: json['photoCnt'],
    );
  }
}

class PhotoDTOs {
  final String path;
  final int photoId;

  PhotoDTOs({
    required this.path,
    required this.photoId,
  });

  factory PhotoDTOs.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PhotoDTOs(
      path: json['path'],
      photoId: json['photoId'],
    );
  }
}