// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p_signup_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostParams _$PostParamsFromJson(Map<String, dynamic> json) => PostParams(
      memberId: json['memberId'] as String?,
      memberPassword: json['memberPassword'] as String?,
      userPw: json['userPw'] as String?,
      name: json['name'] as String?,
      nickName: json['nickName'] as String?,
      phone: json['phone'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      birthDay: json['birthDay'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$PostParamsToJson(PostParams instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberPassword': instance.memberPassword,
      'userPw': instance.userPw,
      'name': instance.name,
      'nickName': instance.nickName,
      'phone': instance.phone,
      'height': instance.height,
      'weight': instance.weight,
      'birthDay': instance.birthDay,
      'gender': instance.gender,
    };
