import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'creator_review_model_data.g.dart';

@JsonSerializable()
class CreatorReviewModelData {
  final int creatorEvalId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String mainPhotoPath;
  final double averageScore;
  final int hasMore;


  CreatorReviewModelData({
    required this.creatorEvalId,
    required this.mainPhotoPath,
    required this.averageScore,
    required this.hasMore
  });

  factory CreatorReviewModelData.fromJson(Map<String, dynamic> json) =>
      _$CreatorReviewModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorReviewModelDataToJson(this);
}
