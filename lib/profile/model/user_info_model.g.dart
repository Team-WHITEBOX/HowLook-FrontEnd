// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      memberId: json['memberId'] as String,
      memberNickName: json['memberNickName'] as String,
      memberHeight: json['memberHeight'] as int,
      memberWeight: json['memberWeight'] as int,
      profilePhoto: DataUtils.pathToUrl(json['profilePhoto'] as String),
      memberPostCount: json['memberPostCount'] as int?,
      memberPosts: (json['memberPosts'] as List<dynamic>?)
          ?.map((e) => MemberPosts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberNickName': instance.memberNickName,
      'memberHeight': instance.memberHeight,
      'memberWeight': instance.memberWeight,
      'profilePhoto': instance.profilePhoto,
      'memberPostCount': instance.memberPostCount,
      'memberPosts': instance.memberPosts,
    };
