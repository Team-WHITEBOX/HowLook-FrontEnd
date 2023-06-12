import 'package:json_annotation/json_annotation.dart';

import 'report_post_model.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  final int reportId;
  final String reporterId;
  final ReportPostModel? post;

  ReportModel({
    required this.reportId,
    required this.reporterId,
    required this.post,
  });

  ReportModel copyWith({
    int? reportId,
    String? reporterId,
    ReportPostModel? post,
  }) {
    return ReportModel(
      reportId: reportId ?? this.reportId,
      reporterId: reporterId ?? this.reporterId,
      post: post ?? this.post,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
