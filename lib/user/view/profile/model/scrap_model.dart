class ScrapModel {
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 이미지 갯수
  final int photoCnt;

  ScrapModel({
    required this.npostId,
    required this.photoDTOs,
    required this.mainPhotoPath,
    required this.photoCnt,
  });

  factory ScrapModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ScrapModel(
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