import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/detail_feed_card.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';

class FeedDetailScreen extends ConsumerStatefulWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회

  const FeedDetailScreen({
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends ConsumerState<FeedDetailScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedDetailProvider(widget.postId));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '게시글',
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              DetailFeedCard.fromModel(model: state),
            ],
          ),
        ),
      ),
    );
  }
}