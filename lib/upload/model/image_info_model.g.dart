// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfoModel _$ImageInfoModelFromJson(Map<String, dynamic> json) =>
    ImageInfoModel(
      name: json['name'] as String,
      path: DataUtils.pathToUrl(json['path'] as String),
    );

Map<String, dynamic> _$ImageInfoModelToJson(ImageInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
    };
