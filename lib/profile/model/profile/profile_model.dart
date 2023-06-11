import 'package:howlook/profile/model/user_info/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/data_utils.dart';
import 'member_posts.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends UserInfoModel{
  // 해당 유저의 포스트 갯수
  final int memberPostCount;
  // 각 포스트의 정보
  final List<MemberPosts> memberPosts;

  ProfileModel({
    required super.memberId,
    required super.memberNickName,
    required super.memberHeight,
    required super.memberWeight,
    required super.profilePhoto,
    required this.memberPostCount,
    required this.memberPosts,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

}
