import 'package:json_annotation/json_annotation.dart';

import 'normal_result_data_model.dart';

part 'normal_result_model.g.dart';

@JsonSerializable()
class NormalResultModel {
  final NormalResultData data;

  NormalResultModel({
    required this.data,
  });

  NormalResultModel copyWith({
    NormalResultData? data,
  }) {
    return NormalResultModel(
      data: data ?? this.data,
    );
  }

  factory NormalResultModel.fromJson(Map<String, dynamic> json) =>
      _$NormalResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$NormalResultModelToJson(this);
}
