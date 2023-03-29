import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/model/category_pagination_params.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/near_pagination_params.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

final categoryfeedProvider =
StateNotifierProvider<CategoryFeedStateNotifier, CursorPaginationBase>(
      (ref) {
    final crepository = ref.watch((FeedRepositoryProvider));
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
  var gps;
  void paginate({
    int fetchPage = 0,
    int fetchCount = 10,
    // 추가로 데이터 더 가져오기
    // true -> 추가로 데이터 더 가져옴
    // false -> 새로고침  (현재상태 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading() <- 화면에 데이터 다 지우고 돌아가는 원 띄우기
    bool forceRefetch = false,
  }) async {
    // 5가지 케이스 존재
    // State의 상태
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터 로딩중인 상태 (현재 캐시 X)
    // 3) CursorPaginationError - 에러 상태
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올 떄
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

    // 바로 반환하는 상황
    // 1) hasMore가 false (기존 상태에서 이미 다음 데이터 없다는 거 알 때
    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination;
      // <- 이건 HowLook에 없는 파라미터라 일단 여기선 Skip ->
      // if (!pState.meta.hasMore) {
      //   return;
      // }
    }
    // 2) 로딩중 -> fetchMore : true 일때
    //  fetchMore가 아닐때 - 새로고침의 의도가 있을 수 있다. (기존 요청 있더라도 위로 댕겨서 새로고침하는 것을 의미)
    final isLoading = state is CursorPaginationLoading; // 완전 새로
    final isRefetching = state is CursorPaginationRefetching; // 이미 어느정도 있는 상태
    final isFetchingMore = state is CursorPaginationFetchingMore;

    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return;
    }

    // PaginationParams 생성 - 여기서 바꿀 값만 선택하기
    CategoryPaginationParams categorypaginationParams = CategoryPaginationParams(
      page: fetchPage,

    );
    // page: fetchPage, 뭐 이런식??

    // fetch
    // 데이터 추가로 더 가져오는 상황
    if (fetchMore) {
      final pState = state as CursorPagination;

      state = CursorPaginationFetchingMore(
        data: pState.data,
      );

      categorypaginationParams = categorypaginationParams.copyWith(
        page: (fetchPage + 1),

        // page:  + 1, 지금 여기서 다음 페이지 값 넣어줘야 함,,,,
      );
    }
    // 데이터를 처음부터 가져오는 상황
    else {
      // 만약에 데이터가 있는 상황이라면 기존 데이터를 보존한채로 Fetch(API 요청)를 진행
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        // 기존 데이터가 존재하는 경우 && 완전 새로고침 아닌 경우
        state = CursorPaginationRefetching(
          data: pState.data,
        );
      }
      // 나머지 상황
      else {
        state = CursorPaginationLoading();
      }
    }

    // 가장 최신의 10개 데이터 가져온 것
    final resp = await crepository.cpaginate(
      categorypaginationParams: categorypaginationParams,
    );
    print('hello3');

    if (state is CursorPaginationFetchingMore) {
      final pState = state as CursorPaginationFetchingMore;

      // 기존 데이터에 새로운 데이터 추가
      state = resp.copyWith(
        data: [
          ...pState.data,
          ...resp.data,
        ],
      );
    } else {
      state = resp;
    }
  }
}
