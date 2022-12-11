class FBResultModel {
  // 포스트 아이디
  final int npostId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;

  FBResultModel({
    required this.npostId,
    required this.mainPhotoPath,
  });

  factory FBResultModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return FBResultModel(
      npostId: json['npostId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}