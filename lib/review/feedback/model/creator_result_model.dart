import 'package:json_annotation/json_annotation.dart';

import 'creator_result_data_model.dart';

part 'creator_result_model.g.dart';

@JsonSerializable()
class CreatorResultModel {
  final List<CreatorResultData> data;

  CreatorResultModel({required this.data});

  factory CreatorResultModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorResultModelToJson(this);
}
