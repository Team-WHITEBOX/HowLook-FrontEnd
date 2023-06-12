import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/manager/repository/manager_repository.dart';

import '../model/manager_pagination_model.dart';
import '../model/params/manager_pagination_params.dart';

final managerFeedProvider =
    StateNotifierProvider<ManagerFeedStateNotifier, ManagerPaginationBase>(
  (ref) {
    final mRepository = ref.watch((managerRepositoryProvider));
    final notifier = ManagerFeedStateNotifier(mRepository: mRepository);
    return notifier;
  },
);

class ManagerFeedStateNotifier extends StateNotifier<ManagerPaginationBase> {
  final ManagerRepository mRepository;

  ManagerFeedStateNotifier({
    required this.mRepository,
  }) : super(ManagerPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchPage = 0,
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is ManagerPagination && !forceRefetch) {
        final pState = state as ManagerPagination;
        if (pState.totalPages == pState.number) {
          return;
        }
      }

      final isLoading = state is ManagerPaginationLoading;
      final isRefetching = state is ManagerPaginationRefetching;
      final isFetchingMore = state is ManagerPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      ManagerPaginationParams managerPaginationParams = ManagerPaginationParams(
        page: fetchPage,
      );

      if (fetchMore) {
        final pState = state as ManagerPagination;

        state = ManagerPaginationFetchingMore(
          content: pState.content,
          number: pState.number,
          totalPages: pState.totalPages,
        );

        managerPaginationParams =
            managerPaginationParams.copyWith(page: (pState.number + 1));
      } else {
        if (state is ManagerPagination && !forceRefetch) {
          final pState = state as ManagerPagination;

          state = ManagerPaginationRefetching(
            content: pState.content,
            number: pState.number,
            totalPages: pState.totalPages,
          );
        } else {
          state = ManagerPaginationLoading();
        }
      }

      final resp = await mRepository.paginate(
          managerPaginationParams: managerPaginationParams);

      if (state is ManagerPaginationFetchingMore) {
        final pState = state as ManagerPaginationFetchingMore;

        state = resp.copyWith(
          content: [
            ...pState.content,
            ...resp.content,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      print(e);
      state = ManagerPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
