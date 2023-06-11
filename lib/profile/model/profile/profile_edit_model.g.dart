// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEditModel _$ProfileEditModelFromJson(Map<String, dynamic> json) =>
    ProfileEditModel(
      memberId: json['memberId'] as String?,
      memberNickName: json['memberNickName'] as String,
      memberPhone: json['memberPhone'] as String,
      memberHeight: json['memberHeight'] as int,
      memberWeight: json['memberWeight'] as int,
    );

Map<String, dynamic> _$ProfileEditModelToJson(ProfileEditModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberNickName': instance.memberNickName,
      'memberPhone': instance.memberPhone,
      'memberHeight': instance.memberHeight,
      'memberWeight': instance.memberWeight,
    };
