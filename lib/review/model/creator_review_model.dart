import 'package:howlook/review/model/normal_review_model_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

import 'creator_review_model_data.dart';

part 'creator_review_model.g.dart';

@JsonSerializable()
class CreatorReviewModel {
  final int status;
  final String code;
  final String message;
  final CreatorReviewModelData data;

  CreatorReviewModel({required this.status, required this.code, required this.message, required this.data});


  factory CreatorReviewModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorReviewModelToJson(this);
}