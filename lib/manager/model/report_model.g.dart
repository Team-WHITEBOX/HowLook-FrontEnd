// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportId: json['reportId'] as int,
      reporterId: json['reporterId'] as String,
      post: json['post'] == null
          ? null
          : ReportPostModel.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'reporterId': instance.reporterId,
      'post': instance.post,
    };
