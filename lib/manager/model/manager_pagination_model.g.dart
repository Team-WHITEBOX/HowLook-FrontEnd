// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerPagination<T> _$ManagerPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ManagerPagination<T>(
      content: (json['content'] as List<dynamic>)
          .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int,
      number: json['number'] as int,
    );

Map<String, dynamic> _$ManagerPaginationToJson<T>(
  ManagerPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content,
      'totalPages': instance.totalPages,
      'number': instance.number,
    };
