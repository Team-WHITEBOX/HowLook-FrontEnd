import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  String? memberId;
  String? memberPassword;
  String? name;
  String? nickName;
  String? phone;
  int? height;
  int? weight;
  String? birthDay;
  String? gender;

  SignupModel(
      {this.memberId,
      this.memberPassword,
      this.name,
      this.nickName,
      this.phone,
      this.height,
      this.weight,
      this.birthDay,
      this.gender});

  SignupModel copyWith({
    required String? memberId,
    required String? memberPassword,
    String? name,
    String? nickName,
    String? phone,
    int? height,
    int? weight,
    String? birthDay,
    String? gender,
  }) {
    return SignupModel(
      memberId: memberId ?? this.memberId,
      memberPassword: memberPassword ?? this.memberPassword,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      phone: phone ?? this.phone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
    );
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
