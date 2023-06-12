import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'normal_review_model_data.g.dart';

@JsonSerializable()
class ReviewModelData {
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String mainPhotoPath;
  final double averageScore;
  final int hasMore;


  ReviewModelData({
    required this.postId,
    required this.mainPhotoPath,
    required this.averageScore,
    required this.hasMore
  });

  factory ReviewModelData.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelDataToJson(this);
}
