import 'package:json_annotation/json_annotation.dart';

import 'report_model.dart';

part 'manager_pagination_model.g.dart';

abstract class ManagerPaginationBase {}

// Error 상태를 의미하는 CursorPaginationError Class
class ManagerPaginationError extends ManagerPaginationBase {
  final String message;

  ManagerPaginationError({
    required this.message,
  });
}

// Data Loading 상태를 의미하는 CursorPaginationLoading Class
class ManagerPaginationLoading extends ManagerPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ManagerPagination<T> extends ManagerPaginationBase {
  final List<ReportModel> content;
  final int totalPages;
  final int number;

  ManagerPagination({
    required this.content,
    required this.totalPages,
    required this.number,
  });

  ManagerPagination copyWith({
    List<ReportModel>? content,
    int? totalPages,
    int? number,
  }) {
    return ManagerPagination(
      content: content ?? this.content,
      totalPages: totalPages ?? this.totalPages,
      number: number ?? this.number,
    );
  }

  factory ManagerPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ManagerPaginationFromJson(json, fromJsonT);
}

// 데이터 새로고침을 위한 클래스,
// CursorPagination 클래스를 상속함 <- MetaData 및 Data가 필요하기 때문
class ManagerPaginationRefetching<T> extends ManagerPagination<T> {
  ManagerPaginationRefetching({
    required super.content,
    required super.number,
    required super.totalPages,
  });
}

// 맨 아래로 내려서 추가 데이터를 요청을 위한 클래스,
// CursorPagination 클래스를 상속함 <- MetaData 및 Data가 필요하기 때문
class ManagerPaginationFetchingMore<T> extends ManagerPagination<T> {
  ManagerPaginationFetchingMore({
    required super.content,
    required super.number,
    required super.totalPages,
  });
}
