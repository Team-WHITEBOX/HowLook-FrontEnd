import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_memberPosts.g.dart';

@JsonSerializable()
class MemberPosts {
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String mainPhotoPath;
  final int postId;

  MemberPosts({
    required this.mainPhotoPath,
    required this.postId,
  });

  factory MemberPosts.fromJson(Map<String, dynamic> json) =>
      _$MemberPostsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberPostsToJson(this);
}
