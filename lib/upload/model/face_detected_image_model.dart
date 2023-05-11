import 'package:howlook/upload/model/image_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'face_detected_image_model.g.dart';

@JsonSerializable()
class FaceDetectedImageModel {
  final bool isDetected;
  final List<ImageInfoModel> paths;

  FaceDetectedImageModel({
    required this.isDetected,
    required this.paths,
  });

  factory FaceDetectedImageModel.fromJson(Map<String, dynamic> json) =>
      _$FaceDetectedImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaceDetectedImageModelToJson(this);
}

