import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/feed/component/detail_feed_card.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';
import 'package:howlook/feed/provider/weather_feed_provider.dart';
import 'package:howlook/feed/view/feed_detail/feed_detail_screen.dart';

class WeatherFeedScreen extends ConsumerStatefulWidget {
  const WeatherFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherFeedScreen> createState() => _WeatherFeedScreenState();
}

class _WeatherFeedScreenState extends ConsumerState<WeatherFeedScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(weatherFeedProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(weatherFeedProvider);

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
        ref.read(weatherFeedProvider.notifier).paginate(
              forceRefetch: true,
            );
      },
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.data.content.length + 1,
        itemBuilder: (BuildContext context, int index) {
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
              child: DetailFeedCard.fromModel(model: pItem));
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
