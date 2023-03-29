import 'package:howlook/feed/model/feed_photo_dto.dart';
import 'package:howlook/feed/model/userinfo_model.dart';
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
  // 내용
  final String content;
  // 등록 날짜
  final List<dynamic> regDate;

  FeedModel({
    required this.userPostInfo,
    required this.postId,
    required this.photoDTOs,
    required this.photoCount,
    required this.likeCount,
    required this.likeCheck,
    required this.replyCount,
    required this.content,
    required this.regDate,
  });

  FeedModel copyWith({
    UserInfoModel? userPostInfo,
    int? postId,
    List<PhotoDTOs>? photoDTOs,
    int? photoCount,
    int? likeCount,
    bool? likeCheck,
    int? replyCount,
    String? content,
    List<dynamic>? regDate,
  }) {
    return FeedModel(
      userPostInfo: userPostInfo ?? this.userPostInfo,
      postId: postId ?? this.postId,
      photoDTOs: photoDTOs ?? this.photoDTOs,
      photoCount: photoCount ?? this.photoCount,
      likeCount: likeCount ?? this.likeCount,
      likeCheck: likeCheck ?? this.likeCheck,
      replyCount: replyCount ?? this.replyCount,
      content: content ?? this.content,
      regDate: regDate ?? this.regDate,
    );
  }

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedModelToJson(this);
}
