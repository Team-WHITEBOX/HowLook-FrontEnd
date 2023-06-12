// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportPostModel _$ReportPostModelFromJson(Map<String, dynamic> json) =>
    ReportPostModel(
      postId: json['postId'] as int,
      memberId: json['memberId'] as String,
      photoCount: json['photoCount'] as int,
      likeCount: json['likeCount'] as int,
      postReplyCount: json['postReplyCount'] as int,
      viewCount: json['viewCount'] as int,
      content: json['content'] as String,
      mainPhotoPath: DataUtils.pathToUrl(json['mainPhotoPath'] as String),
      registrationDate: (json['registrationDate'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$ReportPostModelToJson(ReportPostModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'memberId': instance.memberId,
      'photoCount': instance.photoCount,
      'likeCount': instance.likeCount,
      'postReplyCount': instance.postReplyCount,
      'viewCount': instance.viewCount,
      'content': instance.content,
      'mainPhotoPath': instance.mainPhotoPath,
      'registrationDate': instance.registrationDate,
    };
