import 'package:json_annotation/json_annotation.dart';

part 'payment_result_model.g.dart';

@JsonSerializable()
class PaymentResultModel {
  final bool success;
  final int imp_uid;
  final String merchant_uid;
  final String error_msg;

  PaymentResultModel({
    required this.success,
    required this.imp_uid,
    required this.merchant_uid,
    required this.error_msg,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultModelFromJson(json);
}
