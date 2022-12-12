import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/userinfomodel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_feed_model.g.dart';

@JsonSerializable()
class MainFeedModel {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;

  MainFeedModel({
    required this.userPostInfo,
    required this.npostId,
    required this.photoDTOs,
    required this.photoCnt,
  });

  factory MainFeedModel.fromJson(Map<String, dynamic> json)
  => _$MainFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainFeedModelToJson(this);
}