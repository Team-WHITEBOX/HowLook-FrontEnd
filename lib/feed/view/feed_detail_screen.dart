import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';

class FeedDetailScreen extends ConsumerWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회

  const FeedDetailScreen({
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedDetailProvider(postId));

    if (state == null) {
      return DefaultLayout(
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
              FeedCard.fromModel(model: state),
            ],
          ),
        ),
      ),
    );
  }
}