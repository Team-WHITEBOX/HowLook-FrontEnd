// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_result_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalResultData _$NormalResultDataFromJson(Map<String, dynamic> json) =>
    NormalResultData(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
      maleScore: (json['maleScore'] as num).toDouble(),
      femaleScore: (json['femaleScore'] as num).toDouble(),
      maxScore: (json['maxScore'] as num).toDouble(),
      minScore: (json['minScore'] as num).toDouble(),
      replyCount: (json['replyCount'] as num).toDouble(),
      maleCount: json['maleCount'] as int,
      femaleCount: json['femaleCount'] as int,
      maleScores: (json['maleScores'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      femaleScores: (json['femaleScores'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      maleCounts:
          (json['maleCounts'] as List<dynamic>).map((e) => e as int).toList(),
      femaleCounts:
          (json['femaleCounts'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$NormalResultDataToJson(NormalResultData instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
      'maleScore': instance.maleScore,
      'femaleScore': instance.femaleScore,
      'maxScore': instance.maxScore,
      'minScore': instance.minScore,
      'replyCount': instance.replyCount,
      'maleCount': instance.maleCount,
      'femaleCount': instance.femaleCount,
      'maleScores': instance.maleScores,
      'femaleScores': instance.femaleScores,
      'maleCounts': instance.maleCounts,
      'femaleCounts': instance.femaleCounts,
    };
