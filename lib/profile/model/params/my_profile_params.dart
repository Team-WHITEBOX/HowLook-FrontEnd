import 'package:json_annotation/json_annotation.dart';

part 'my_profile_params.g.dart';

@JsonSerializable()
class MyProfileParams {
  final String memberId;

  const MyProfileParams({
    required this.memberId,
  });

  MyProfileParams copyWith({
    String? memberId,
  }) {
    return MyProfileParams(
      memberId: memberId ?? this.memberId,
    );
  }

  factory MyProfileParams.fromJson(Map<String, dynamic> json) =>
      _$MyProfileParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileParamsToJson(this);
}
