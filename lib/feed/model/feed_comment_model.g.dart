// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainFeedCommentModel _$MainFeedCommentModelFromJson(
        Map<String, dynamic> json) =>
    MainFeedCommentModel(
      replyId: json['replyId'] as int,
      parentId: json['parentId'] as int,
      likeCount: json['likeCount'] as int,
      nickName: json['nickName'] as String,
      profilePhoto: DataUtils.pathToUrl(json['profilePhoto'] as String),
      like_chk: json['like_chk'] as bool,
      contents: json['contents'] as String,
      npostId: json['npostId'] as int,
    );

Map<String, dynamic> _$MainFeedCommentModelToJson(
        MainFeedCommentModel instance) =>
    <String, dynamic>{
      'replyId': instance.replyId,
      'parentId': instance.parentId,
      'likeCount': instance.likeCount,
      'nickName': instance.nickName,
      'profilePhoto': instance.profilePhoto,
      'like_chk': instance.like_chk,
      'contents': instance.contents,
      'npostId': instance.npostId,
    };
