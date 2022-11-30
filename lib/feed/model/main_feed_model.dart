class MainFeedModel {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지
  final List<String> photoPaths;
  // 이미지 갯수
  final int photoCnt;

  MainFeedModel({
    required this.userPostInfo,
    required this.npostId,
    required this.photoPaths,
    required this.photoCnt,
  });

  factory MainFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedModel(
      userPostInfo: UserInfoModel.fromJson(json: Map<String, dynamic>.from(json['userPostInfo'])),
      npostId: json['npostId'],
      photoPaths: List<String>.from(json['photoPaths']),
      photoCnt: json['photoCnt'],
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
  final int profilePhotoId;

  UserInfoModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhotoId,
  });

  factory UserInfoModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return UserInfoModel(
      memberId: json['memberId'],
      memberNickName: json['memberNickName'],
      memberHeight: json['memberHeight'],
      memberWeight: json['memberWeight'],
      profilePhotoId: json['profilePhotoId'],
    );
  }
}
