import 'package:json_annotation/json_annotation.dart';

part 'curr_ruby_model.g.dart';

@JsonSerializable()
class CurrRubyModel {
  final int ruby;

  CurrRubyModel({
    required this.ruby,
  });

  CurrRubyModel copyWith({
    int? ruby,
  }) {
    return CurrRubyModel(
      ruby: ruby ?? this.ruby,
    );
  }

  factory CurrRubyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrRubyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrRubyModelToJson(this);
}
