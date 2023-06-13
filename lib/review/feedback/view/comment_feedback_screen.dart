import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/component/normal_feedback_result_card.dart';

import '../component/comment_feedback_card.dart';
import '../component/creator_feedback_result_card.dart';
import '../model/creator_result_data_model.dart';
import '../model/creator_result_model.dart';
import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../provider/creator_result_provider.dart';
import '../provider/feedback_provider.dart';
import '../provider/normal_result_provider.dart';

class CommentFeedback extends ConsumerWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회
  CommentFeedback({required this.postId, Key? key}) : super(key: key);
  late Future<List<CreatorResultData>> _CreatorResultFuture;

  Future<void> _fetchNormalResultModel(WidgetRef ref) async {
    final repository = ref.read(CreatorResultProvider.notifier);
    _CreatorResultFuture = repository.getCreatorResultData(postId: postId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchNormalResultModel(ref);

    final Size size = MediaQuery.of(context).size;
    return DefaultLayout(
      child: FutureBuilder<List<CreatorResultData>>(
        future: _CreatorResultFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final itemList = snapshot.data!; // 데이터 리스트
            return Scrollbar(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  final item = itemList[index];
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      for (int number = 1; number < index; number++)
                        ListTile(
                            leading: ExcludeSemantics(
                              child: CircleAvatar(child: Text('$number')),
                            ),
                            title: Text(
                                item.nickname
                            ),
                            subtitle: Text(item.review)
                        ),
                    ],
                  );
                },
              )
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
