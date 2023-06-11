import 'package:howlook/profile/model/profile/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_data.g.dart';

@JsonSerializable()
class ProfileData {
  final ProfileModel data;

  ProfileData({
    required this.data,
  });

  ProfileData copyWith({
    ProfileModel? data,
  }) {
    return ProfileData (
      data: data ?? this.data,
    );
  }

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
