import 'package:json_annotation/json_annotation.dart';

part 'p_signup_params.g.dart';

@JsonSerializable()
class PostParams {

  final String? memberId;
  final String? memberPassword;
  final String? userPw;
  final String? name;
  final String? nickName;
  final String? phone;
  final int? height;
  final int? weight;
  final String? birthDay;
  final String? gender;

  const PostParams({
    this.memberId,
    this.memberPassword,
    this.userPw,
    this.name,
    this.nickName,
    this.phone,
    this.height,
    this.weight,
    this.birthDay,
    this.gender
  });

  PostParams copyWith({
    String? memberId,
    String? memberPassword,
    String? userpw,
    String? name,
    String? nickName,
    String? phone,
    int? height,
    int? weight,
    String? birthDay,
    String? gender,
  }) {
    return PostParams(
      memberId: memberId ?? this.memberId,
      memberPassword: memberPassword ?? this.memberPassword,
      userPw: userpw ?? this.userPw,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      phone: phone ?? this.phone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
    );
  }

  factory PostParams.fromJson(Map<String, dynamic> json) =>
      _$PostParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PostParamsToJson(this);

}
