class MainFeedModel {
  // 이름
  final String name;
  // 별명
  final String nickname;
  // 프로필 사진
  final String profile_image;
  // 이미지
  final String images;
  // 몸무게, 키
  final List<double> bodyinfo;

  MainFeedModel({
    required this.name,
    required this.nickname,
    required this.profile_image,
    required this.images,
    required this.bodyinfo,
  });
}

