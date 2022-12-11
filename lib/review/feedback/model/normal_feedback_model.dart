class NormalReviewModel {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  NormalReviewModel({
    required this.npostId,
    required this.mainPhotoPath,
    required this.averageScore
  });

  factory NormalReviewModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return NormalReviewModel(
      npostId: json['npostId'],
      mainPhotoPath: json['mainPhotoPath'],
      averageScore: json['averageScore'],
    );
  }
}