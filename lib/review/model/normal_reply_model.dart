import 'package:howlook/review/model/normal_review_model_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'normal_reply_model.g.dart';

@JsonSerializable()
class NormalReplyModel {
  final int postId;
  final double score;

  NormalReplyModel({required this.postId, required this.score,});


  factory NormalReplyModel.fromJson(Map<String, dynamic> json) =>
      _$NormalReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$NormalReplyModelToJson(this);
}