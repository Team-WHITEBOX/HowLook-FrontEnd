import 'package:json_annotation/json_annotation.dart';

part 'nick_check_data.g.dart';

@JsonSerializable()
class NickCheckData {
  final bool data;

  NickCheckData({
    required this.data,
  });

  factory NickCheckData.fromJson(Map<String, dynamic> json) =>
      _$NickCheckDataFromJson(json);
}
