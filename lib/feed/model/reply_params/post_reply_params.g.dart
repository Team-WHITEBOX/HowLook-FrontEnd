// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reply_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReplyParams _$PostReplyParamsFromJson(Map<String, dynamic> json) =>
    PostReplyParams(
      content: json['content'] as String?,
      postId: json['postId'] as int?,
    );

Map<String, dynamic> _$PostReplyParamsToJson(PostReplyParams instance) =>
    <String, dynamic>{
      'content': instance.content,
      'postId': instance.postId,
    };
