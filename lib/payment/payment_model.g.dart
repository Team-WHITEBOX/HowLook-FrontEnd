// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      amount: json['amount'] as int,
      ruby: json['ruby'] as int,
      impUid: json['impUid'] as String,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'ruby': instance.ruby,
      'impUid': instance.impUid,
    };
