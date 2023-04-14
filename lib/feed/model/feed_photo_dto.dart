import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_photo_dto.g.dart';

@JsonSerializable()
class PhotoDTOs {
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String path;
  final int photoId;

  PhotoDTOs({
    required this.path,
    required this.photoId,
  });

  factory PhotoDTOs.fromJson(Map<String, dynamic> json) =>
      _$PhotoDTOsFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoDTOsToJson(this);
}
