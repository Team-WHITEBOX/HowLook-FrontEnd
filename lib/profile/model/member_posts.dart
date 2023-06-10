import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_posts.g.dart';

@JsonSerializable()
class MemberPosts {
  final int postId;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String mainPhotoPath;

  MemberPosts({
    required this.postId,
    required this.mainPhotoPath,
  });

  factory MemberPosts.fromJson(Map<String, dynamic> json) =>
      _$MemberPostsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberPostsToJson(this);
}
