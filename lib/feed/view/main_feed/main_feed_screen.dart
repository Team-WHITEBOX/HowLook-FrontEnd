import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';
import 'package:howlook/feed/view/feed_detail/feed_detail_screen.dart';

class MainFeedScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends ConsumerState<MainFeedScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(mainFeedProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 따로 autoDispose 설정하지 않으면 한번 생성된 이후로 데이터가 날아가지 않고 캐싱된다.
    final data = ref.watch(mainFeedProvider);

    // 완전 처음 로딩일 떄
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination 아래엔 다음과 같은 클래스가 존재
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching
    final cp = data as CursorPagination;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(mainFeedProvider.notifier).paginate(
              forceRefetch: true,
            );
      },
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.data.content.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.content.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('마지막 데이터입니다. ㅠㅠ'),
              ),
            );
          }
          // 받아온 데이터 JSON 매핑하기
          // 모델 사용
          final pItem = cp.data.content[index];
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FeedDetailScreen(
                      postId: pItem.postId,
                    ),
                  ),
                );
              },
              child: FeedCard.fromModel(model: pItem));
        },
        separatorBuilder: (_, index) {
          return const SizedBox();
        },
      ),
    );
  }
}
