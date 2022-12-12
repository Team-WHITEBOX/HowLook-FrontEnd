// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoDTOs _$PhotoDTOsFromJson(Map<String, dynamic> json) => PhotoDTOs(
      path: DataUtils.pathToUrl(json['path'] as String),
      photoId: json['photoId'] as int,
    );

Map<String, dynamic> _$PhotoDTOsToJson(PhotoDTOs instance) => <String, dynamic>{
      'path': instance.path,
      'photoId': instance.photoId,
    };
