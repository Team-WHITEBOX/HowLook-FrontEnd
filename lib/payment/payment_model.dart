import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  final int amount;
  final int ruby;
  final String impUid;

  PaymentModel({
    required this.amount,
    required this.ruby,
    required this.impUid,
  });

  PaymentModel copyWith({
    int? amount,
    int? ruby,
    String? impUid,
  }) {
    return PaymentModel(
      amount: amount ?? this.amount,
      ruby: ruby ?? this.ruby,
      impUid: impUid ?? this.impUid,
    );
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
