// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyPageModel _$ReplyPageModelFromJson(Map<String, dynamic> json) =>
    ReplyPageModel(
      replies: (json['replies'] as List<dynamic>)
          .map((e) => ReplyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int,
      nowPage: json['nowPage'] as int,
    );

Map<String, dynamic> _$ReplyPageModelToJson(ReplyPageModel instance) =>
    <String, dynamic>{
      'replies': instance.replies,
      'totalPages': instance.totalPages,
      'nowPage': instance.nowPage,
    };
