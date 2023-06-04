import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/provider/category_check_provider.dart';
import 'package:howlook/feed/provider/category_feed_provider.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';
import 'package:howlook/feed/view/category_feed/category_selected_screen.dart';
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
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.watch(isFiltering)
          ? ref.read(categoryFeedProvider.notifier).paginate(
                fetchMore: true,
              )
          : ref.read(mainFeedProvider.notifier).paginate(
                fetchMore: true,
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(mainFeedProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPagination;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(mainFeedProvider.notifier).paginate(
              forceRefetch: true,
            );
      },
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategorySelectScreen(),
                ),
              );
            },
            icon: const Icon(Icons.filter_alt_rounded),
          ),
          Expanded(
            child: GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                ],
              ),
              controller: controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: cp.data.content.length + 1,
                (context, index) {
                  if (index == cp.data.content.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
                    child: FeedCard.fromModel(model: pItem),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
