import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/params/feed_params/category_pagination_params.dart';
import 'package:howlook/feed/provider/category_provider.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

import '../model/category_model.dart';

final categoryFeedProvider =
    StateNotifierProvider<CategoryFeedStateNotifier, CursorPaginationBase>(
  (ref) {
    final category = ref.watch(categoryProvider);
    final cRepository = ref.watch((feedRepositoryProvider));
    final notifier = CategoryFeedStateNotifier(cRepository: cRepository);
    return notifier;
  },
);

class CategoryFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  final FeedRepository cRepository;
  late CategoryModel category;

  CategoryFeedStateNotifier({
    required this.cRepository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
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

      final currentPage = state is CursorPagination
          ? (state as CursorPagination).data.number
          : 0;

      CategoryPaginationParams categorypaginationParams =
          CategoryPaginationParams(
        page: fetchMore ? currentPage + 1 : 0,
        size: fetchCount,
        gender: category.gender,
        hashtagDTOMinimal: category.hashtagDTOMinimal,
        hashtagDTOCasual: category.hashtagDTOCasual,
        hashtagDTOStreet: category.hashtagDTOStreet,
        hashtagDTOAmekaji: category.hashtagDTOAmekaji,
        hashtagDTOSporty: category.hashtagDTOSporty,
        hashtagDTOGuitar: category.hashtagDTOGuitar,
        heightLow: category.heightLow,
        heightHigh: category.heightHigh,
        weightLow: category.weightLow,
        weightHigh: category.weightHigh,
      );

      final resp = await cRepository.cPaginate(
        categoryPaginationParams: categorypaginationParams,
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
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
