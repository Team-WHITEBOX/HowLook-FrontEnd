// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResultModel _$PaymentResultModelFromJson(Map<String, dynamic> json) =>
    PaymentResultModel(
      success: json['success'] as bool,
      imp_uid: json['imp_uid'] as int,
      merchant_uid: json['merchant_uid'] as String,
      error_msg: json['error_msg'] as String,
    );

Map<String, dynamic> _$PaymentResultModelToJson(PaymentResultModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'imp_uid': instance.imp_uid,
      'merchant_uid': instance.merchant_uid,
      'error_msg': instance.error_msg,
    };
