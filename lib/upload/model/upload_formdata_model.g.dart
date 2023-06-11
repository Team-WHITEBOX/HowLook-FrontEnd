// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_formdata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadModel _$UploadModelFromJson(Map<String, dynamic> json) => UploadModel(
      content: json['content'] as String,
      hashtagAmekaji: json['hashtagDTO.amekaji'] as bool?,
      hashtagCasual: json['hashtagDTO.casual'] as bool?,
      hashtagGuitar: json['hashtagDTO.guitar'] as bool?,
      hashtagMinimal: json['hashtagDTO.minimal'] as bool?,
      hashtagSporty: json['hashtagDTO.sporty'] as bool?,
      hashtagStreet: json['hashtagDTO.street'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UploadModelToJson(UploadModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'hashtagDTO.amekaji': instance.hashtagAmekaji,
      'hashtagDTO.casual': instance.hashtagCasual,
      'hashtagDTO.guitar': instance.hashtagGuitar,
      'hashtagDTO.minimal': instance.hashtagMinimal,
      'hashtagDTO.sporty': instance.hashtagSporty,
      'hashtagDTO.street': instance.hashtagStreet,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
