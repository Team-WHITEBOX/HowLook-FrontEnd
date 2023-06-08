import 'package:json_annotation/json_annotation.dart';
import 'package:howlook/common/utils/data_utils.dart';

part 'chart_page_model.g.dart';

@JsonSerializable()
class ChartModel {
  // 남자 차트
  final List<dynamic> maleCounts;
  // 여자 차트
  final List<dynamic> femaleCounts;

  final double replyCount;

  ChartModel({
    required this.maleCounts,
    required this.femaleCounts,
    required this.replyCount,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) =>
      _$ChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChartModelToJson(this);
}