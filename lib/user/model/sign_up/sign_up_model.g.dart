// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      memberId: json['memberId'] as String?,
      memberPassword: json['memberPassword'] as String?,
      memberPasswordCheck: json['memberPasswordCheck'] as String?,
      name: json['name'] as String?,
      nickName: json['nickName'] as String?,
      phone: json['phone'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      birthDay: json['birthDay'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'memberPassword': instance.memberPassword,
      'memberPasswordCheck': instance.memberPasswordCheck,
      'name': instance.name,
      'nickName': instance.nickName,
      'phone': instance.phone,
      'height': instance.height,
      'weight': instance.weight,
      'birthDay': instance.birthDay,
      'gender': instance.gender,
    };
