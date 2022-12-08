class MainFeedModel {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;

  MainFeedModel({
    required this.userPostInfo,
    required this.npostId,
    required this.photoDTOs,
    required this.photoCnt,
  });

  factory MainFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedModel(
      userPostInfo: UserInfoModel.fromJson(
          json: Map<String, dynamic>.from(json['userPostInfo'])),
      npostId: json['npostId'],
      photoDTOs: json['photoDTOs'].map<PhotoDTOs>(
        (x) => PhotoDTOs(
          path: x['path'],
          photoId: x['photoId'],
        ),
      ).toList(),
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

class UserInfoModel {
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

  UserInfoModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
  });

  factory UserInfoModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return UserInfoModel(
      memberId: json['memberId'],
      memberNickName: json['memberNickName'],
      memberHeight: json['memberHeight'],
      memberWeight: json['memberWeight'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
