import 'package:json_annotation/json_annotation.dart';

part 'isCreator_model.g.dart';

@JsonSerializable()
class IsCreatorModel {
  final int status;
  final String code;
  final String message;
  final bool data; // data 값 추가

  IsCreatorModel({required this.status, required this.code, required this.message, required this.data});

  factory IsCreatorModel.fromJson(Map<String, dynamic> json) =>
      _$IsCreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$IsCreatorModelToJson(this);
}