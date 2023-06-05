import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/comment_pagination_model.dart';
import 'package:howlook/common/model/params/comment_params/comment_params.dart';
import 'package:howlook/feed/repository/comment_repository.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

final commentProvider =
    StateNotifierProvider.family<CommentStateNotifier, CommentPaginationBase, int>(
  (ref, postId) {
    final repository = ref.watch(commentRepositoryProvider);
    final notifier = CommentStateNotifier(repository: repository, postId: postId);
    return notifier;
  },
);

class CommentStateNotifier extends StateNotifier<CommentPaginationBase> {
  final CommentRepository repository;
  final int postId;

  CommentStateNotifier({
    required this.repository,
    required this.postId,
  }) : super(CommentPaginationLoading()) {
    paginate(postId: postId);
  }

  Future<void> paginate({
    required int postId,
    int fetchPage = 0,
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is CommentPagination && !forceRefetch) {
        final pState = state as CommentPagination;

        // 댓글 전체 페이지 수, 현재 페이지 넘버에 대한 구현 필요
        if (pState.data.totalPages == pState.data.nowPage) {
          return;
        }
      }

      final isLoading = state is CommentPaginationLoading;
      final isRefetching = state is CommentPaginationRefetching;
      final isFetchingMore = state is CommentPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      CommentParams commentParams = CommentParams(
        page: fetchPage,
        size: fetchCount,
      );

      if (fetchMore) {
        final pState = state as CommentPagination;

        state = CommentPaginationFetchingMore(
          data: pState.data,
        );

        commentParams = commentParams.copyWith(
          page: (pState.data.nowPage + 1),
        );
      } else {
        if (state is CommentPagination && !forceRefetch) {
          final pState = state as CommentPagination;

          state = CommentPaginationRefetching(
            data: pState.data,
          );
        }
        // 강제로 새로고침하는 상황
        else {
          state = CommentPaginationLoading();
        }
      }

      final resp = await repository.commentPaginate(postId, commentParams: commentParams);

      if (state is CommentPaginationFetchingMore) {
        final pState = state as CommentPaginationFetchingMore;

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
      state = CommentPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
