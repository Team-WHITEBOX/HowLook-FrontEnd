import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_info_model.g.dart';

@JsonSerializable()
class ImageInfoModel {
  String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  String path;

  ImageInfoModel({
    required this.name,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
    };
  }

  factory ImageInfoModel.fromJson(Map<String, dynamic> json)
  => _$ImageInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageInfoModelToJson(this);

}