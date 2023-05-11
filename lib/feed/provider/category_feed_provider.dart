import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/feed_params/category_pagination_params.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

final categoryfeedProvider =
StateNotifierProvider<CategoryFeedStateNotifier, CursorPaginationBase>(
      (ref) {
    final crepository = ref.watch((feedRepositoryProvider));
    final notifier = CategoryFeedStateNotifier(crepository: crepository);
    return notifier;
  },
);

class CategoryFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  final FeedRepository crepository;

  CategoryFeedStateNotifier({
    required this.crepository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }
  void paginate({
    int fetchPage = 0,
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        if (pState.data.totalPages == pState.data.number) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      CategoryPaginationParams categorypaginationParams =
          CategoryPaginationParams(
        page: fetchPage,
      );

      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          data: pState.data,
        );

        categorypaginationParams = categorypaginationParams.copyWith(
          page: (pState.data.number + 1),
        );
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationRefetching(
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await crepository.cpaginate(
        categorypaginationParams: categorypaginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(
          data: resp.data.copyWith(
            content: [
              ...pState.data.content,
              ...resp.data.content,
            ],
          ),
        );
      } else {
        state = resp;
      }
    } catch(e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
