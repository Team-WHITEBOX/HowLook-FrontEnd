import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'normal_result_data_model.g.dart';

@JsonSerializable()
class NormalResultData {
  // 포스트 아이디
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  // 평균 점수
  final double averageScore;
  final double maleScore;
  final double femaleScore;
  final double maxScore;
  final double minScore;
  final double replyCount;
  final int maleCount;
  final int femaleCount;
  final List<double> maleScores;
  final List<double> femaleScores;
  final List<int> maleCounts;
  final List<int> femaleCounts;



  NormalResultData(
      {required this.postId,
        required this.mainPhotoPath,
        required this.averageScore,
        required this.maleScore,
        required this.femaleScore,
        required this.maxScore,
        required this.minScore,
        required this.replyCount,
        required this.maleCount,
        required this.femaleCount,
        required this.maleScores,
        required this.femaleScores,
        required this.maleCounts,
        required this.femaleCounts,
      });

  factory NormalResultData.fromJson(Map<String, dynamic> json) =>
      _$NormalResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$NormalResultDataToJson(this);
}
