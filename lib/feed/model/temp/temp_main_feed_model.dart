
import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/temp/temp_userinfo_model.dart';
import 'package:howlook/feed/model/userinfomodel.dart';

class TempMainFeedModel {
  final TempUserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;

  TempMainFeedModel({
    required this.userPostInfo,
    required this.npostId,
    required this.photoDTOs,
    required this.photoCnt,
  });

  factory TempMainFeedModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return TempMainFeedModel(
      userPostInfo: TempUserInfoModel.fromJson(
          json: Map<String, dynamic>.from(json['userPostInfo'])),
      npostId: json['npostId'],

      photoDTOs: json['photoDTOs'].map<PhotoDTOs>(
            (x) => PhotoDTOs(
          path: x['path'],
          photoId: x['photoId'],
        ),
      ).toList(),

      photoCnt: json['photoCnt'],
    );
  }
}