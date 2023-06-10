// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyPagination<T> _$ReplyPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ReplyPagination<T>(
      data: ReplyPageModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyPaginationToJson<T>(
  ReplyPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data,
    };
