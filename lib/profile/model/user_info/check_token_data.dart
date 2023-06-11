import 'package:howlook/profile/model/profile/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_token_data.g.dart';

@JsonSerializable()
class CheckTokenData {
  final int status;
  final String data;

  CheckTokenData({
    required this.status,
    required this.data,
  });

  CheckTokenData copyWith({
    int? status,
    String? data,
  }) {
    return CheckTokenData (
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory CheckTokenData.fromJson(Map<String, dynamic> json) =>
      _$CheckTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckTokenDataToJson(this);
}
