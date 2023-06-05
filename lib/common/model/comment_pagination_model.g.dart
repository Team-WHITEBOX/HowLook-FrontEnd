// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentPagination<T> _$CommentPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CommentPagination<T>(
      data: CommentPageModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentPaginationToJson<T>(
  CommentPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data,
    };
