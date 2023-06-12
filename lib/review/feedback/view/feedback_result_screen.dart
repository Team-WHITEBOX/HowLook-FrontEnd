import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/component/feedback_result_card.dart';

import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../provider/normal_feedback_provider.dart';
import '../provider/normal_result_provider.dart';

class FeedbackResult extends ConsumerWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회
  FeedbackResult({required this.postId, Key? key}) : super(key: key);

  late Future<NormalResultModel> _NormalResultFuture;

  Future<void> _fetchNormalResultModel(WidgetRef ref) async {
    final repository = ref.read(NormalResultProvider.notifier);
    _NormalResultFuture = repository.getResultData(postId: postId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchNormalResultModel(ref);

    final Size size = MediaQuery.of(context).size;
    return DefaultLayout(
      child: FutureBuilder<NormalResultModel>(
        future: _NormalResultFuture,
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
            final item = snapshot.data!.data; //인덱스값
            return FeedbackResultCard.fromModel(model: item);
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
