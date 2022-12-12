class TempUserInfoModel {
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

  TempUserInfoModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
  });

  factory TempUserInfoModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return TempUserInfoModel(
      memberId: json['memberId'],
      memberNickName: json['memberNickName'],
      memberHeight: json['memberHeight'],
      memberWeight: json['memberWeight'],
      profilePhoto: json['profilePhoto'],
    );
  }
}