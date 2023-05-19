class ScrapModel {

  final List<ScrapList> scraps;

  ScrapModel({
    required this.scraps,
  });


  factory ScrapModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ScrapModel(
      scraps: json['scraps'].map<ScrapList>(
            (x) => ScrapList(
          postId: x['postId'],
          mainPhotoPath: x['mainPhotoPath'],
        ),
      ).toList(),
    );
  }

}

class ScrapList {
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;

  ScrapList({
    required this.postId,
    required this.mainPhotoPath,
  });

  factory ScrapList.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ScrapList(
      postId: json['postId'],
      mainPhotoPath: json['mainPhotoPath'],
    );
  }
}

