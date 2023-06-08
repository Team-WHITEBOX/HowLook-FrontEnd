import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/params/feed_params/category_pagination_params.dart';
import 'package:howlook/feed/model/category_model.dart';
import 'package:howlook/feed/provider/category_provider.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

final categoryFeedProvider =
    StateNotifierProvider<CategoryFeedStateNotifier, CursorPaginationBase>(
  (ref) {
    final cRepository = ref.watch((feedRepositoryProvider));
    final category = ref.watch(categoryProvider);
    final notifier = CategoryFeedStateNotifier(
      cRepository: cRepository,
      categoryModel: category,
    );
    return notifier;
  },
);

class CategoryFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  final FeedRepository cRepository;
  final CategoryModel categoryModel;

  CategoryFeedStateNotifier({
    required this.cRepository,
    required this.categoryModel,
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

      CategoryPaginationParams categoryPaginationParams =
          CategoryPaginationParams(
        page: fetchPage,
        size: fetchCount,
        gender: categoryModel.gender,
        hashtagDTOMinimal: categoryModel.hashtagDTOMinimal,
        hashtagDTOCasual: categoryModel.hashtagDTOCasual,
        hashtagDTOStreet: categoryModel.hashtagDTOStreet,
        hashtagDTOAmekaji: categoryModel.hashtagDTOAmekaji,
        hashtagDTOSporty: categoryModel.hashtagDTOSporty,
        hashtagDTOGuitar: categoryModel.hashtagDTOGuitar,
        heightLow: categoryModel.heightLow,
        heightHigh: categoryModel.heightHigh,
        weightLow: categoryModel.weightLow,
        weightHigh: categoryModel.weightHigh,
      );

      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(data: pState.data);

        categoryPaginationParams =
            categoryPaginationParams.copyWith(page: (pState.data.number + 1));
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

      final resp = await cRepository.cPaginate(
          categoryPaginationParams: categoryPaginationParams);

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
