import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/userinfomodel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_feed_detail_model.g.dart';

@JsonSerializable()
class MainFeedDetailModel extends MainFeedModel {
  // 좋아요 수
  final int likeCount;
  // 본인의 좋아요 체크 여부
  final bool like_chk;
  // 댓글
  final int commentCount;
  // 내용
  final String content;
  // 등록 날짜
  final List<dynamic> regDate;

  MainFeedDetailModel({
    required super.userPostInfo,
    required super.npostId,
    required super.photoDTOs,
    required super.photoCnt,
    required this.likeCount,
    required this.like_chk,
    required this.commentCount,
    required this.content,
    required this.regDate,
  });

  factory MainFeedDetailModel.fromJson(Map<String, dynamic> json)
  => _$MainFeedDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainFeedDetailModelToJson(this);

}
