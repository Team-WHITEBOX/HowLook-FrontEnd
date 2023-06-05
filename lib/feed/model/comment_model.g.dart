// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      replyId: json['replyId'] as int,
      postId: json['postId'] as int,
      content: json['content'] as String,
      parentId: json['parentId'] as int,
      likeCount: json['likeCount'] as int,
      nickName: json['nickName'] as String,
      profilePhoto: DataUtils.pathToUrl(json['profilePhoto'] as String),
      likeCheck: json['likeCheck'] as bool,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'replyId': instance.replyId,
      'postId': instance.postId,
      'content': instance.content,
      'parentId': instance.parentId,
      'likeCount': instance.likeCount,
      'nickName': instance.nickName,
      'profilePhoto': instance.profilePhoto,
      'likeCheck': instance.likeCheck,
    };
