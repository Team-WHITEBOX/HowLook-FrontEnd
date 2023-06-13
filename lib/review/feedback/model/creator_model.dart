import 'package:json_annotation/json_annotation.dart';

import 'creator_data_model.dart';
import 'normal_result_data_model.dart';

part 'creator_model.g.dart';

@JsonSerializable()
class CreatorModel {
  final CreatorDataModel data;

  CreatorModel({
    required this.data,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);
}
