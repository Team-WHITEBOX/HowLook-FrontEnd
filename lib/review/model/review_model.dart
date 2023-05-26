// "mainPhotoPath": "8dadd1d8-1064-497a-8372-e113502e7eb7_signature.png",
// "npostId": 7,
class ReviewModel {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;



  ReviewModel({
    required this.npostId,
    required this.mainPhotoPath,
  });

  factory ReviewModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ReviewModel(
      npostId: json['npostId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}
