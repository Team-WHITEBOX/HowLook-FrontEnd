// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentPageModel _$CommentPageModelFromJson(Map<String, dynamic> json) =>
    CommentPageModel(
      replies: (json['replies'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int,
      nowPage: json['nowPage'] as int,
    );

Map<String, dynamic> _$CommentPageModelToJson(CommentPageModel instance) =>
    <String, dynamic>{
      'replies': instance.replies,
      'totalPages': instance.totalPages,
      'nowPage': instance.nowPage,
    };
