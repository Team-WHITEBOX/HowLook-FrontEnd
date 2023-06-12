import 'package:json_annotation/json_annotation.dart';

import 'curr_ruby_model.dart';

part 'curr_ruby_data.g.dart';

@JsonSerializable()
class CurrRubyData {
  final CurrRubyModel data;

  CurrRubyData({
    required this.data,
  });

  CurrRubyData copyWith({
    CurrRubyModel? data,
  }) {
    return CurrRubyData(
      data: data ?? this.data,
    );
  }

  factory CurrRubyData.fromJson(Map<String, dynamic> json) =>
      _$CurrRubyDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrRubyDataToJson(this);
}
