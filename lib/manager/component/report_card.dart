import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/manager/model/params/manager_pagination_params.dart';
import 'package:howlook/manager/model/report_model.dart';
import 'package:howlook/manager/model/report_post_model.dart';

import '../provider/manager_feed_provider.dart';
import '../repository/manager_repository.dart';

class ReportCard extends ConsumerWidget {
  final int reportId;
  final String reporterId;
  final ReportPostModel? post;

  const ReportCard({
    required this.reportId,
    required this.reporterId,
    this.post,
    super.key,
  });

  factory ReportCard.fromModel({
    required ReportModel model,
  }) {
    return ReportCard(
      reportId: model.reportId,
      reporterId: model.reporterId,
      post: model.post,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "게시자: ${post!.memberId} / 신고자: $reporterId",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "게시글: ${post!.content}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 0.5, color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    await ref
                        .read(managerRepositoryProvider)
                        .delReject(postId: post!.postId);
                    ref
                        .read(managerFeedProvider.notifier)
                        .paginate(forceRefetch: true);
                  },
                  child: const Text(
                    "반려",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(height: 35, width: 0.5, color: Colors.black),
                GestureDetector(
                  onTap: () async {
                    final storage = ref.watch(secureStorageProvider);
                    final token = await storage.read(key: ACCESS_TOKEN_KEY);

                    await ref
                        .read(managerRepositoryProvider)
                        .delReport(accessToken: token!, postId: post!.postId);
                    ref
                        .read(managerFeedProvider.notifier)
                        .paginate(forceRefetch: true);
                  },
                  child: const Text(
                    "수락",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
