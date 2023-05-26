import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/comment_pagination_model.dart';
import 'package:howlook/feed/component/comment_card.dart';
import 'package:howlook/feed/model/feed_comment_model.dart';
import 'package:howlook/feed/provider/comment_provider.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({
    required this.postId,
    Key? key,
  }) : super(key: key);

  final int postId;

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(commentProvider.notifier).paginate(
            postId: widget.postId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(commentProvider);
    final dataRead = ref.read(commentProvider.notifier);

    if (data is CommentPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CommentPaginationError) {
      return Center(child: Text(data.message));
    }

    final cp = data as CommentPagination;

    return RefreshIndicator(
      onRefresh: () async {
        dataRead.paginate(
          postId: widget.postId,
          forceRefetch: true,
        );
      },
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CommentPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('마지막 데이터입니다. ㅠㅠ'),
              ),
            );
          }
          final pItem = cp.data[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: CommentCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
