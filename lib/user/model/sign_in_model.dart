import 'package:json_annotation/json_annotation.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  final String memberId;
  final String memberPassword;

  SignInModel({
   required this.memberId,
   required this.memberPassword,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json)
  => _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}