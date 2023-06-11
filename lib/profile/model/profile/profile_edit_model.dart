import 'package:json_annotation/json_annotation.dart';

part 'profile_edit_model.g.dart';

@JsonSerializable()
class ProfileEditModel {
  final String? memberId;
  final String memberNickName;
  final String memberPhone;
  final int memberHeight;
  final int memberWeight;

  ProfileEditModel({
    this.memberId,
    required this.memberNickName,
    required this.memberPhone,
    required this.memberHeight,
    required this.memberWeight,
  });

  ProfileEditModel copyWith({
    String? memberNickName,
    String? memberPhone,
    int? memberHeight,
    int? memberWeight,
  }) {
    return ProfileEditModel(
      memberNickName: memberNickName ?? this.memberNickName,
      memberPhone: memberPhone ?? this.memberPhone,
      memberHeight: memberHeight ?? this.memberHeight,
      memberWeight: memberWeight ?? this.memberWeight,
    );
  }

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileEditModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEditModelToJson(this);
}
