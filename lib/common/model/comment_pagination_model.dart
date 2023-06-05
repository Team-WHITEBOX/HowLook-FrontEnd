import 'package:howlook/common/model/comment_page_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_pagination_model.g.dart';

abstract class CommentPaginationBase {}

class CommentPaginationError extends CommentPaginationBase {
  final String message;

  CommentPaginationError({
    required this.message,
  });
}

class CommentPaginationLoading extends CommentPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CommentPagination<T> extends CommentPaginationBase {
  final CommentPageModel data;

  CommentPagination({
    required this.data,
  });

  CommentPagination copyWith({CommentPageModel? data}) {
    return CommentPagination(
      data: data ?? this.data,
    );
  }

  factory CommentPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CommentPaginationFromJson(json, fromJsonT);
}

class CommentPaginationRefetching<T> extends CommentPagination<T> {
  CommentPaginationRefetching({
    required super.data,
  });
}

class CommentPaginationFetchingMore<T> extends CommentPagination<T> {
  CommentPaginationFetchingMore({
    required super.data,
  });
}
