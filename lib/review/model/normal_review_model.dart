// "mainPhotoPath": "8dadd1d8-1064-497a-8372-e113502e7eb7_signature.png",
// "npostId": 7,
class NRModel {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;



  NRModel({
    required this.npostId,
    required this.mainPhotoPath,
  });

  factory NRModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return NRModel(
      npostId: json['npostId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}
