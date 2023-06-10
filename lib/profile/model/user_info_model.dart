import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'member_posts.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  // 아이디
  final String memberId;
  // 닉네임
  final String memberNickName;
  // 키
  final int memberHeight;
  // 몸무게
  final int memberWeight;
  // 포토아이디
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String profilePhoto;
  // 해당 유저의 포스트 갯수
  final int? memberPostCount;
  // 각 포스트의 정보
  final List<MemberPosts>? memberPosts;

  UserInfoModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
    this.memberPostCount,
    this.memberPosts,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json)
  => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}