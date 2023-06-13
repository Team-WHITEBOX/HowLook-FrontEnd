import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'creator_result_data_model.g.dart';

@JsonSerializable()
class CreatorResultData {
  final String nickname;
  // 포스트 아이디
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double score;
  final String review;



  CreatorResultData(
      {required this.postId,
        required this.mainPhotoPath,
        required this.review,
        required this.score,
        required this.nickname,
      });

  factory CreatorResultData.fromJson(Map<String, dynamic> json) =>
      _$CreatorResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorResultDataToJson(this);
}
