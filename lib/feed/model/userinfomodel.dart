import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userinfomodel.g.dart';

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

  UserInfoModel({
    required this.memberId,
    required this.memberNickName,
    required this.memberHeight,
    required this.memberWeight,
    required this.profilePhoto,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json)
  => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}