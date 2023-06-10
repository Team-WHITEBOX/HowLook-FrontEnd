import 'package:json_annotation/json_annotation.dart';

part 'id_check_data.g.dart';

@JsonSerializable()
class IdCheckData {
  final bool data;

  IdCheckData({
    required this.data,
  });

  factory IdCheckData.fromJson(Map<String, dynamic> json) =>
      _$IdCheckDataFromJson(json);
}
