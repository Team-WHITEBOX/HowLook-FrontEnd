// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_feed_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainFeedDetailModel _$MainFeedDetailModelFromJson(Map<String, dynamic> json) =>
    MainFeedDetailModel(
      userPostInfo:
          UserInfoModel.fromJson(json['userPostInfo'] as Map<String, dynamic>),
      npostId: json['npostId'] as int,
      photoDTOs: (json['photoDTOs'] as List<dynamic>)
          .map((e) => PhotoDTOs.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoCnt: json['photoCnt'] as int,
      likeCount: json['likeCount'] as int,
      like_chk: json['like_chk'] as bool,
      commentCount: json['commentCount'] as int,
      content: json['content'] as String,
      regDate: json['regDate'] as List<dynamic>,
    );

Map<String, dynamic> _$MainFeedDetailModelToJson(
        MainFeedDetailModel instance) =>
    <String, dynamic>{
      'userPostInfo': instance.userPostInfo,
      'npostId': instance.npostId,
      'photoDTOs': instance.photoDTOs,
      'photoCnt': instance.photoCnt,
      'likeCount': instance.likeCount,
      'like_chk': instance.like_chk,
      'commentCount': instance.commentCount,
      'content': instance.content,
      'regDate': instance.regDate,
    };
