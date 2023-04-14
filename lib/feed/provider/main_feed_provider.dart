import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/feed_params/detail_feed_params.dart';
import 'package:howlook/common/model/feed_params/pagination_params.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/repository/feed_repository.dart';

// 각 피드 디테일 페이지 이동 시 캐시 적용을 위한 Detail Provider 사용
// family Provider을 통해 feedDetailProvider을 생성할 때 id 값을 같이 넣어서 전달
final feedDetailProvider = Provider.family<FeedModel?, int>((ref, id) {
  final state = ref.watch(mainfeedProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.content.firstWhere((element) => element.postId == id);
});

// 캐시를 관리하는 모든 Provider => StateNotifierProvider
// 왜냐하면 method를 많이 생성해서 로직을 클래스 안에 집어 넣기 위함
final mainfeedProvider =
    StateNotifierProvider<MainFeedStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch((FeedRepositoryProvider));
    final notifier = MainFeedStateNotifier(repository: repository);
    return notifier;
  },
);

class MainFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  // API 요청을 위해 repository 가져오기
  final FeedRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  MainFeedStateNotifier({
    required this.repository,

    // 해당 클래스가 CursorPaginationBase를 상속받기 때문에 해당 클래스의 타입은 모두 가능
    // Loading, Error 등등,,
  }) : super(CursorPaginationLoading()) {
    // MainFeedStateNotifier가 어디든 호출이 되어 인스턴스화 될 때
    // 바로 페이지네이션을 실시하기 위해 생성자 안에 paginate 함수를 정의하여
    // 생성될 떄 바로 paginate 함수가 호출되게 작업하기 위함
    paginate();
  }

  // paginate 함수
  Future<void> paginate({
    // 현재 페이지 넘버
    int fetchPage = 0,

    // 한번에 가져오는 페이지 수
    int fetchCount = 10,

    // 추가로 데이터 더 가져오기
    // true -> 추가로 데이터 더 가져옴
    // false -> 새로고침 (현재상태 덮어씌움)
    bool fetchMore = false,

    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading() <- 화면에 데이터 다 지우고 돌아가는 원 띄우기
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지 State 상태 가능
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터 로딩중인 상태 (현재 캐시 X), forceRefetch가 True인 상태
      // 3) CursorPaginationError - 에러 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올 떄
      // 5) CursorPaginationFetchMore - 리스트의 맨 아래에서 추가 데이터를 요청 받았을 때

      // 1) hasMore == false (기존 상태에서 이미 다음 데이터 없다는 값을 가지고 있을 때)
      // 2) 로딩중 -> fetchMore == true
      //    fetchMore가 아닐때 - 새로고침의 의도가 있을 수 있다. (기존 요청 있더라도 위로 댕겨서 새로고침하는 것을 의미)
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        // 만약 pState.data.totalPages == pState.data.number이 같을 경우
        // 아래 if문에 진입하여 그대로 return -> 더이상 가져올 데이터가 없기 때문
        if (pState.data.totalPages == pState.data.number) {
          return;
        }
      }

      // ** 로딩 상태의 정의 **
      // 1. 데이터가 아예 없이 완전 새로운 상태에서 로딩할 때
      final isLoading = state is CursorPaginationLoading;
      // 2. 이미 받아온 데이터가 있는 상태에서 로딩(새로고침)할 떄
      final isRefetching = state is CursorPaginationRefetching;
      // 3. 이미 받아온 데이터가 있는 상태에서 추가 데이터를 요청할 떄
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 로딩 중(fetchMore) && 위에 정의한 상태 중 하나일 때 그대로 반환
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // feed_repository.dart에서 쿼리 파라미터(PaginationParams) 선언한 클래스의 인스턴스 선언 및 값 입력하기
      PaginationParams paginationParams = PaginationParams(
        // fetchPage - (0 페이지 부터 시작)
        page: fetchPage,
      );

      // fetchMore == True (데이터가 존재하는 상황에서 추가로 더 가져오는 상황일 떄)
      if (fetchMore) {
        final pState = state as CursorPagination;

        // 데이터 더 가져오기 위해 state를 FetchingMore로 변경
        state = CursorPaginationFetchingMore(
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          page: (pState.data.number + 1),
        );
      }

      // fetchMore == False (데이터를 처음부터 가져오거나 강제로 새로고침하는 상황)
      else {
        // 만약에 데이터가 있는 상황이라면 기존 데이터를 보존한채로 Fetch(API 요청 - 불러오기)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationRefetching(
            data: pState.data,
          );
        }
        // 강제로 새로고침하는 상황
        else {
          state = CursorPaginationLoading();
        }
      }

      // 각 상태에 맞는 paginationParams를 첨부하여 API 실행
      // 가장 최신 데이터 10개 불러오기
      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        // 기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(
          data: resp.data.copyWith(
            content: [
              ...pState.data.content,
              ...resp.data.content,
            ],
          ),
        );
      } else {
        // CursorPaginationLoading 또는 CursorPaginationRefetching 상황이면
        // 가져온 응답 값을 기존 데이터에 이어붙일 필요가 없기 때문
        state = resp;
      }
    } catch (e) {
      // 에러 처리
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }

  getDetail({
    required int postId,
  }) async {
    DetailFeedParams detailfeedParams = DetailFeedParams(
      postId: postId,
    );

    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await this.paginate();
    }

    // 예외처리
    // state가 CursorPagination이 아닐떄 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    // 기존 데이터
    final pState = state as CursorPagination;

    // 요청 데이터
    final resp =
        await repository.getFeedDetail(detailfeedParams: detailfeedParams);

    state = pState.copyWith(
      data: pState.data.copyWith(
        content: pState.data.content
            // 기존 데이터의 postId와 요청 데이터의 postId 비교 연산
            .map<FeedModel>((e) => e.postId == postId ? resp : e)
            .toList(),
      ),
    );
  }
}
