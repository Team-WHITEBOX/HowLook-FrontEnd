import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/model/reply_pagination_model.dart';
import 'package:howlook/feed/component/comment_card.dart';
import 'package:howlook/feed/provider/reply/reply_provider.dart';

class ReplyScreen extends ConsumerStatefulWidget {
  final int postId;

  const ReplyScreen({
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ReplyScreen> createState() => _ReplyScreenState();
}

class _ReplyScreenState extends ConsumerState<ReplyScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 500) {
      ref
          .read(replyProvider(widget.postId).notifier)
          .paginate(postId: widget.postId, fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(replyProvider(widget.postId));

    if (data is ReplyPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is ReplyPaginationError) {
      return Center(child: Text(data.message));
    }

    final cp = data as ReplyPagination;

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(replyProvider(widget.postId).notifier)
            .paginate(postId: widget.postId, forceRefetch: true);
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.data.replies.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.replies.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is ReplyPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('마지막 데이터입니다. ㅠㅠ'),
              ),
            );
          }
          final pItem = cp.data.replies[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: CommentCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: (_, index) {
          return const Divider(color: Colors.black26);
        },
      ),
    );
  }
}
