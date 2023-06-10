import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  String? memberId = "";
  String? memberPassword = "";
  String? memberPasswordCheck = "";
  String? name = "";
  String? nickName = "";
  String? phone = "";
  int? height = 0;
  int? weight = 0;
  String? birthDay = "";
  String? gender = "";

  SignUpModel({
    this.memberId,
    this.memberPassword,
    this.memberPasswordCheck,
    this.name,
    this.nickName,
    this.phone,
    this.height,
    this.weight,
    this.birthDay,
    this.gender,
  });

  SignUpModel copyWith({
    String? memberId,
    String? memberPassword,
    String? memberPasswordCheck,
    String? name,
    String? nickName,
    String? phone,
    int? height,
    int? weight,
    String? birthDay,
    String? gender,
  }) {
    return SignUpModel(
      memberId: memberId ?? this.memberId,
      memberPassword: memberPassword ?? this.memberPassword,
      memberPasswordCheck: memberPasswordCheck ?? this.memberPasswordCheck,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      phone: phone ?? this.phone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
    );
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
