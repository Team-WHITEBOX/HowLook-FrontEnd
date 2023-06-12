// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_review_model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModelData _$ReviewModelDataFromJson(Map<String, dynamic> json) =>
    ReviewModelData(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      averageScore: (json['averageScore'] as num).toDouble(),
      hasMore: json['hasMore'] as int,
    );

Map<String, dynamic> _$ReviewModelDataToJson(ReviewModelData instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
      'averageScore': instance.averageScore,
      'hasMore': instance.hasMore,
    };
