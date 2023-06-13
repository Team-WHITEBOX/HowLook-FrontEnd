import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'creator_data_model.g.dart';

@JsonSerializable()
class CreatorDataModel {
  // 포스트 아이디
  final int creatorEvalId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;

  CreatorDataModel(
      {required this.creatorEvalId,
        required this.mainPhotoPath,
        required this.averageScore});

  factory CreatorDataModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorDataModelToJson(this);
}
