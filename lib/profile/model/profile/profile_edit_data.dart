import 'package:json_annotation/json_annotation.dart';

import 'profile_edit_model.dart';

part 'profile_edit_data.g.dart';

@JsonSerializable()
class ProfileEditData {
  final ProfileEditModel data;

  ProfileEditData({
    required this.data,
  });

  factory ProfileEditData.fromJson(Map<String, dynamic> json) =>
      _$ProfileEditDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEditDataToJson(this);
}
