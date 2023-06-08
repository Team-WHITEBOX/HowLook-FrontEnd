import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

import 'normal_feedback_model_data.dart';

part 'normal_feedback_model.g.dart';

@JsonSerializable()
class NormalFeedbackModel {
  final int status;
  final String code;
  final String message;
  final List<NormalFeedbackData> data;

  NormalFeedbackModel(
      {required this.status,
      required this.code,
      required this.message,
      required this.data});

  factory NormalFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$NormalFeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$NormalFeedbackModelToJson(this);
}
