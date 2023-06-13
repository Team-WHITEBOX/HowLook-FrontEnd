// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_result_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorResultData _$CreatorResultDataFromJson(Map<String, dynamic> json) =>
    CreatorResultData(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      review: json['review'] as String,
      score: (json['score'] as num).toDouble(),
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$CreatorResultDataToJson(CreatorResultData instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
      'score': instance.score,
      'review': instance.review,
    };
