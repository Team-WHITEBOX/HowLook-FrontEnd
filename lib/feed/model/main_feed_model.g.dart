// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainFeedModel _$MainFeedModelFromJson(Map<String, dynamic> json) =>
    MainFeedModel(
      userPostInfo:
          UserInfoModel.fromJson(json['userPostInfo'] as Map<String, dynamic>),
      npostId: json['npostId'] as int,
      photoDTOs: (json['photoDTOs'] as List<dynamic>)
          .map((e) => PhotoDTOs.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoCnt: json['photoCnt'] as int,
    );

Map<String, dynamic> _$MainFeedModelToJson(MainFeedModel instance) =>
    <String, dynamic>{
      'userPostInfo': instance.userPostInfo,
      'npostId': instance.npostId,
      'photoDTOs': instance.photoDTOs,
      'photoCnt': instance.photoCnt,
    };
