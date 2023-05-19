// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_memberPosts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberPosts _$MemberPostsFromJson(Map<String, dynamic> json) => MemberPosts(
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      postId: json['postId'] as int,
    );

Map<String, dynamic> _$MemberPostsToJson(MemberPosts instance) =>
    <String, dynamic>{
      'mainPhotoPath': instance.mainPhotoPath,
      'postId': instance.postId,
    };
