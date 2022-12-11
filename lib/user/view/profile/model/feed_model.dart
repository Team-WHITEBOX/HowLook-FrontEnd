class MyFeedModel {
  final bool me;

  final int memberFeedCnt;

  final List<MemberFeeds> memberFeeds;

  MyFeedModel({
    required this.me,
    required this.memberFeedCnt,
    required this.memberFeeds,
  });

  factory MyFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MyFeedModel(
      me: json['me'],
      memberFeedCnt: json['memberFeedCnt'],
      memberFeeds: json['memberFeeds'].map<MemberFeeds>(
            (x) => MemberFeeds(
          npostId: x['npostId'],
          photoDTOs: x[<dynamic>['photoDTOs']],
          mainPhotoPath: x['mainPhotoPath'],
          photoCnt: x['photoCnt'],
        ),
      ).toList(),
    );
  }

}

class MemberFeeds {
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 이미지 갯수
  final int photoCnt;

  MemberFeeds({
    required this.npostId,
    required this.photoDTOs,
    required this.mainPhotoPath,
    required this.photoCnt,
  });

  factory MemberFeeds.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MemberFeeds(
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