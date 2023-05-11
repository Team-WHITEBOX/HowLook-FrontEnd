// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detected_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceDetectedImageModel _$FaceDetectedImageModelFromJson(
        Map<String, dynamic> json) =>
    FaceDetectedImageModel(
      isDetected: json['isDetected'] as bool,
      paths: (json['paths'] as List<dynamic>)
          .map((e) => ImageInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaceDetectedImageModelToJson(
        FaceDetectedImageModel instance) =>
    <String, dynamic>{
      'isDetected': instance.isDetected,
      'paths': instance.paths,
    };
