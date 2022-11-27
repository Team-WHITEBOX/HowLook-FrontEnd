import 'package:howlook/common/const/data.dart';

class MainFeedModel {
  // 포스트 아이디
  final int NPostId;
  // 이름
  final String name;
  // 별명
  final String nickname;
  // 프로필 사진
  final String profile_image;
  // 이미지
  final List<String> images;
  // 이미지 갯수
  final int PhotoCnt;
  // 몸무게, 키
  final List<double> bodyinfo;

  MainFeedModel({
    required this.NPostId,
    required this.name,
    required this.nickname,
    required this.profile_image,
    required this.images,
    required this.PhotoCnt,
    required this.bodyinfo,
  });

  factory MainFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedModel(
      NPostId: json['NPostId'],
      name: json['name'],
      nickname: json['nickname'],
      profile_image: 'http://$ip${json['profileUrl']}',
      images: List<String>.from(json['phototPaths']),
      PhotoCnt: json['PhotoCnt'],
      bodyinfo: List<double>.from(json['bodyinfo']),
    );
  }
}