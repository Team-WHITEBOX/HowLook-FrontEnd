// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalReplyModel _$NormalReplyModelFromJson(Map<String, dynamic> json) =>
    NormalReplyModel(
      postId: json['postId'] as int,
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$NormalReplyModelToJson(NormalReplyModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'score': instance.score,
    };
