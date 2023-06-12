import 'package:howlook/review/model/normal_review_model_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'normal_review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int status;
  final String code;
  final String message;
  final ReviewModelData data;

  ReviewModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
