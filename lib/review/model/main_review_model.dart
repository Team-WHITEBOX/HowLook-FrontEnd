import 'package:json_annotation/json_annotation.dart';

part 'main_review_model.g.dart';

@JsonSerializable()
class MainReviewModel {
  final int status;
  final String code;
  final String message;
  final int data; // data 값 추가

  MainReviewModel({required this.status, required this.code, required this.message, required this.data});

  factory MainReviewModel.fromJson(Map<String, dynamic> json) =>
      _$MainReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainReviewModelToJson(this);
}
