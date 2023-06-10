import 'package:howlook/user/model/token/token_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_data.g.dart';

@JsonSerializable()
class TokenData {
  final TokenModel data;

  TokenData({
    required this.data,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);
}
