import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/feed/main_feed_provider.dart';
import '../../repository/feed_repository.dart';
import '../../repository/report_repository.dart';

class MainFeedMoreVertScreen extends ConsumerStatefulWidget {
  final int postId;
  final String? userId;
  final String memberId;
  final bool isScrapped;

  const MainFeedMoreVertScreen({
    required this.postId,
    required this.userId,
    required this.memberId,
    required this.isScrapped,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainFeedMoreVertScreen> createState() =>
      _MainFeedMoreVertScreenState();
}

class _MainFeedMoreVertScreenState
    extends ConsumerState<MainFeedMoreVertScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(feedRepositoryProvider);
    final report = ref.watch(reportRepositoryProvider);

    return Column(
      children: [
        const SizedBox(height: 6),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 32,
                right: 32,
                bottom: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (!widget.isScrapped) {
                            final code = await repo.postScrap(widget.postId);
                            if (code.response.statusCode == 200) {
                              ref
                                  .read(mainFeedProvider.notifier)
                                  .getDetail(postId: widget.postId);
                              Navigator.pop(context);
                            } else {
                              return;
                            }
                          } else {
                            final code = await repo.delScrap(widget.postId);
                            if (code.response.statusCode == 200) {
                              ref
                                  .read(mainFeedProvider.notifier)
                                  .getDetail(postId: widget.postId);
                              Navigator.pop(context);
                            } else {
                              return;
                            }
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Icon(
                            widget.isScrapped
                                ? Icons.bookmark_remove
                                : Icons.bookmark,
                            size: 38,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.isScrapped ? "스크랩 취소" : "스크랩",
                      ),
                    ],
                  ),
                  widget.userId != widget.memberId
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final resp =
                                    await report.reportPost(widget.postId);
                                if (resp.response.statusCode == 200) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("신고가 완료되었습니다. 곧 관리자가 검토할 예정이에요"),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  return;
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                ),
                                child: const Icon(
                                  Icons.report,
                                  size: 38,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("신고",
                                style: TextStyle(color: Colors.red)),
                          ],
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final resp = await repo.delPost(widget.postId);
                                if (resp.response.statusCode == 200) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("삭제가 완료되었습니다."),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  return;
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                ),
                                child: const Icon(
                                  Icons.delete_forever,
                                  size: 38,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "삭제",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(color: Colors.black12, height: 1),
            GestureDetector(
              onTap: () async {
                if (!widget.isScrapped) {
                  final code = await repo.postScrap(widget.postId);
                  if (code.response.statusCode == 200) {
                    ref
                        .read(mainFeedProvider.notifier)
                        .getDetail(postId: widget.postId);
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                } else {
                  final code = await repo.delScrap(widget.postId);
                  if (code.response.statusCode == 200) {
                    ref
                        .read(mainFeedProvider.notifier)
                        .getDetail(postId: widget.postId);
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                }
              },
              child: Container(
                height: 64,
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          widget.isScrapped
                              ? Icons.bookmark_remove
                              : Icons.bookmark,
                          size: 32,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 28,
                          child: Text(
                            widget.isScrapped
                                ? "해당 게시글 스크랩 취소 하기"
                                : "해당 게시글 스크랩 하기",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 1),
            widget.userId != widget.memberId
                ? GestureDetector(
                    onTap: () async {
                      final resp = await report.reportPost(widget.postId);
                      if (resp.response.statusCode == 200) {
                        if (!mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("신고가 완료되었습니다. 곧 관리자가 검토할 예정이에요"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 64,
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 8, bottom: 8),
                        child: SizedBox(
                          height: 32,
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.report, size: 32, color: Colors.red),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "해당 게시글 신고 하기",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      final resp = await repo.delPost(widget.postId);
                      if (resp.response.statusCode == 200) {
                        if (!mounted) return;
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("삭제가 완료되었습니다."),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 64,
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 8, bottom: 8),
                        child: SizedBox(
                          height: 32,
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.delete_forever,
                                  size: 32, color: Colors.red),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "해당 게시글 삭제 하기",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            Container(color: Colors.black12, height: 1),
          ],
        ),
      ],
    );
  }
}
