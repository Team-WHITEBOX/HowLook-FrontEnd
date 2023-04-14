// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedModel _$FeedModelFromJson(Map<String, dynamic> json) => FeedModel(
      userPostInfo:
          UserInfoModel.fromJson(json['userPostInfo'] as Map<String, dynamic>),
      postId: json['postId'] as int,
      photoDTOs: (json['photoDTOs'] as List<dynamic>)
          .map((e) => PhotoDTOs.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoCount: json['photoCount'] as int,
      likeCount: json['likeCount'] as int,
      likeCheck: json['likeCheck'] as bool,
      replyCount: json['replyCount'] as int,
      content: json['content'] as String,
      regDate: json['regDate'] as List<dynamic>,
    );

Map<String, dynamic> _$FeedModelToJson(FeedModel instance) => <String, dynamic>{
      'userPostInfo': instance.userPostInfo,
      'postId': instance.postId,
      'photoDTOs': instance.photoDTOs,
      'photoCount': instance.photoCount,
      'likeCount': instance.likeCount,
      'likeCheck': instance.likeCheck,
      'replyCount': instance.replyCount,
      'content': instance.content,
      'regDate': instance.regDate,
    };
