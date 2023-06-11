// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberPosts _$MemberPostsFromJson(Map<String, dynamic> json) => MemberPosts(
      postId: json['postId'] as int,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
    );

Map<String, dynamic> _$MemberPostsToJson(MemberPosts instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'mainPhotoPath': instance.mainPhotoPath,
    };
