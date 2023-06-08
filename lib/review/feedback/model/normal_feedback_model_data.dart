import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'normal_feedback_model_data.g.dart';

@JsonSerializable()
class NormalFeedbackData {
  // 포스트 아이디
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  NormalFeedbackData(
      {required this.postId,
      required this.mainPhotoPath,
      required this.averageScore});

  factory NormalFeedbackData.fromJson(Map<String, dynamic> json) =>
      _$NormalFeedbackDataFromJson(json);

  Map<String, dynamic> toJson() => _$NormalFeedbackDataToJson(this);
}
