import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

import 'creator_feedback_model_data.dart';

part 'creator_feedback_model.g.dart';

@JsonSerializable()
class CreatorFeedbackModel {
  final int status;
  final String code;
  final String message;
  final List<CreatorFeedbackData> data;

  CreatorFeedbackModel(
      {required this.status,
        required this.code,
        required this.message,
        required this.data});

  factory CreatorFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorFeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorFeedbackModelToJson(this);
}
