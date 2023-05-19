// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainProfileModel _$MainProfileModelFromJson(Map<String, dynamic> json) =>
    MainProfileModel(
      memberId: json['memberId'] as String,
      memberNickName: json['memberNickName'] as String,
      memberHeight: json['memberHeight'] as int,
      memberWeight: json['memberWeight'] as int,
      profilePhoto: json['profilePhoto'] as String,
      me: json['me'] as bool,
      memberPostCount: json['memberPostCount'] as int,
      memberPosts: (json['memberPosts'] as List<dynamic>)
          .map((e) => MemberPosts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainProfileModelToJson(MainProfileModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberNickName': instance.memberNickName,
      'memberHeight': instance.memberHeight,
      'memberWeight': instance.memberWeight,
      'profilePhoto': instance.profilePhoto,
      'me': instance.me,
      'memberPostCount': instance.memberPostCount,
      'memberPosts': instance.memberPosts,
    };
