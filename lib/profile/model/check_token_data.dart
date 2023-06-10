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

  factory CheckTokenData.fromJson(Map<String, dynamic> json) =>
      _$CheckTokenDataFromJson(json);
}
