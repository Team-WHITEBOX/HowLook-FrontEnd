// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartModel _$ChartModelFromJson(Map<String, dynamic> json) => ChartModel(
      maleCounts: json['maleCounts'] as List<dynamic>,
      femaleCounts: json['femaleCounts'] as List<dynamic>,
      replyCount: (json['replyCount'] as num).toDouble(),
    );

Map<String, dynamic> _$ChartModelToJson(ChartModel instance) =>
    <String, dynamic>{
      'maleCounts': instance.maleCounts,
      'femaleCounts': instance.femaleCounts,
      'replyCount': instance.replyCount,
    };
