import 'package:howlook/common/model/reply_page_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_pagination_model.g.dart';

abstract class ReplyPaginationBase {}

class ReplyPaginationError extends ReplyPaginationBase {
  final String message;

  ReplyPaginationError({
    required this.message,
  });
}

class ReplyPaginationLoading extends ReplyPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ReplyPagination<T> extends ReplyPaginationBase {
  final ReplyPageModel data;

  ReplyPagination({
    required this.data,
  });

  ReplyPagination copyWith({ReplyPageModel? data}) {
    return ReplyPagination(
      data: data ?? this.data,
    );
  }

  factory ReplyPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ReplyPaginationFromJson(json, fromJsonT);
}

class ReplyPaginationRefetching<T> extends ReplyPagination<T> {
  ReplyPaginationRefetching({
    required super.data,
  });
}

class ReplyPaginationFetchingMore<T> extends ReplyPagination<T> {
  ReplyPaginationFetchingMore({
    required super.data,
  });
}
