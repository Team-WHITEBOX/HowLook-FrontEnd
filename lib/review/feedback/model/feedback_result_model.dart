import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';
part 'feedback_result_model.g.dart';

@JsonSerializable()
class FBResultModel {
  // 포스트 아이디
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  final double averageScore;
  final double maleScore;
  final double femaleScore;

  FBResultModel({
    required this.postId,
    required this.mainPhotoPath,
    required this.averageScore,
    required this.maleScore,
    required this.femaleScore
  });

  // factory FBResultModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return FBResultModel(
  //     postId: json['postId'],
  //     mainPhotoPath: json['mainPhotoPath'],
  //     averageScore: json['averageScore'],
  //     maleScore: json['maleScore'],
  //     femaleScore: json['femaleScore'],
  //   );
  // }
  factory FBResultModel.fromJson(Map<String, dynamic> json) =>
      _$FBResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$FBResultModelToJson(this);

}