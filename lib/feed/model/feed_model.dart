import 'package:howlook/feed/model/feed_photo_dto.dart';
import 'package:howlook/profile/model/user_info/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_model.g.dart';

@JsonSerializable()
class FeedModel {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int postId;
  // 이미지 경로
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCount;
  // 좋아요 수
  final int likeCount;
  // 본인의 좋아요 체크 여부
  final bool likeCheck;
  // 댓글 갯수
  final int replyCount;
  // 스크랩 여부
  bool? isScrapped;
  // 내용
  final String content;
  // 등록 날짜
  final List<dynamic> regDate;
  // 날씨
  final int weather;
  // 온도
  final int temperature;

  FeedModel({
    required this.userPostInfo,
    required this.postId,
    required this.photoDTOs,
    required this.photoCount,
    required this.likeCount,
    required this.likeCheck,
    required this.replyCount,
    this.isScrapped,
    required this.content,
    required this.regDate,
    required this.weather,
    required this.temperature,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedModelToJson(this);
}
