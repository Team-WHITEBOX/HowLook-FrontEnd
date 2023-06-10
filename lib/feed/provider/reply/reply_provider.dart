import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/model/reply_pagination_model.dart';
import '../../model/reply_params/reply_params.dart';
import '../../repository/reply_repository.dart';


final replyContentProvider = StateProvider<String>((ref) => "");

final replyProvider =
    StateNotifierProvider.family<ReplyStateNotifier, ReplyPaginationBase, int>(
  (ref, postId) {
    final repository = ref.watch(replyRepositoryProvider);
    final notifier = ReplyStateNotifier(repository: repository, postId: postId);
    return notifier;
  },
);

class ReplyStateNotifier extends StateNotifier<ReplyPaginationBase> {
  final ReplyRepository repository;
  final int postId;

  ReplyStateNotifier({
    required this.repository,
    required this.postId,
  }) : super(ReplyPaginationLoading()) {
    paginate(postId: postId);
  }

  Future<void> paginate({
    required int postId,
    int fetchPage = 0,
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is ReplyPagination && !forceRefetch) {
        final pState = state as ReplyPagination;

        // 댓글 전체 페이지 수, 현재 페이지 넘버에 대한 구현 필요
        if (pState.data.totalPages == pState.data.nowPage) {
          return;
        }
      }

      final isLoading = state is ReplyPaginationLoading;
      final isRefetching = state is ReplyPaginationRefetching;
      final isFetchingMore = state is ReplyPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      ReplyParams replyParams = ReplyParams(
        page: fetchPage,
        size: fetchCount,
      );

      if (fetchMore) {
        final pState = state as ReplyPagination;

        state = ReplyPaginationFetchingMore(
          data: pState.data,
        );

        replyParams = replyParams.copyWith(
          page: (pState.data.nowPage + 1),
        );
      } else {
        if (state is ReplyPagination && !forceRefetch) {
          final pState = state as ReplyPagination;

          state = ReplyPaginationRefetching(
            data: pState.data,
          );
        }
        // 강제로 새로고침하는 상황
        else {
          state = ReplyPaginationLoading();
        }
      }

      final resp = await repository.replyPaginate(postId, replyParams: replyParams);

      if (state is ReplyPaginationFetchingMore) {
        final pState = state as ReplyPaginationFetchingMore;

        state = resp.copyWith(
          data: resp.data.copyWith(
            replies: [
              ...pState.data.replies,
              ...resp.data.replies,
            ],
          ),
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = ReplyPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
