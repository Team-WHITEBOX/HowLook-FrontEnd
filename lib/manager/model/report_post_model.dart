import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';

part 'report_post_model.g.dart';

@JsonSerializable()
class ReportPostModel {
  final int postId;
  final String memberId;
  final int photoCount;
  final int likeCount;
  final int postReplyCount;
  final int viewCount;
  final String content;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String mainPhotoPath;
  final List<int> registrationDate;

  ReportPostModel({
    required this.postId,
    required this.memberId,
    required this.photoCount,
    required this.likeCount,
    required this.postReplyCount,
    required this.viewCount,
    required this.content,
    required this.mainPhotoPath,
    required this.registrationDate,
  });

  factory ReportPostModel.fromJson(Map<String, dynamic> json) =>
      _$ReportPostModelFromJson(json);
}
