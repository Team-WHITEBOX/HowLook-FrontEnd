import 'package:json_annotation/json_annotation.dart';

import 'user_info_model.dart';

part 'my_profile_data.g.dart';

@JsonSerializable()
class UserInfoData {
  final UserInfoModel data;

  UserInfoData({
    required this.data,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);
}
