import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/component/normal_feedback_result_card.dart';

import '../component/creator_feedback_result_card.dart';
import '../model/creator_model.dart';
import '../model/creator_result_data_model.dart';
import '../model/creator_result_model.dart';
import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../provider/creator_result_provider.dart';
import '../provider/feedback_provider.dart';
import '../provider/normal_result_provider.dart';

// class CreatorFeedbackResult extends ConsumerWidget {
//   final int postId; // 포스트 아이디로 특정 게시글 조회
//   CreatorFeedbackResult({required this.postId, Key? key}) : super(key: key);
//
//   late Future<List<CreatorResultData>> _CreatorResultFuture;
//
//   Future<void> _fetchNormalResultModel(WidgetRef ref) async {
//     final repository = ref.read(CreatorResultProvider.notifier);
//     _CreatorResultFuture = repository.getCreatorResultData(postId: postId);
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     _fetchNormalResultModel(ref);
//
//     final Size size = MediaQuery.of(context).size;
//     return DefaultLayout(
//       child: FutureBuilder<List<CreatorResultData>>(
//         future: _CreatorResultFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             final item = snapshot.data!; //인덱스값
//             return CreatorFeedbackResultCard.fromModel(model: item);
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class CreatorFeedbackResult extends ConsumerWidget {
  final int postId; // 포스트 아이디로 특정 게시글 조회
  CreatorFeedbackResult({required this.postId, Key? key}) : super(key: key);

  late Future<CreatorModel> _CreatorResultFuture;

  Future<void> _fetchResultModel(WidgetRef ref) async {
    final repository = ref.read(CreatorResultProvider.notifier);
    _CreatorResultFuture = repository.getCreatorData(creatorEvalId: postId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchResultModel(ref);

    final Size size = MediaQuery.of(context).size;
    return DefaultLayout(
      child: FutureBuilder<CreatorModel>(
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
            // final itemList = snapshot.data!; // 데이터 리스트
            // return ListView.builder(
            //   itemCount: itemList.length,
            //   itemBuilder: (context, index) {
            //     final item = itemList[index]; // 각 데이터 아이템
            //     return CreatorFeedbackResultCard.fromModel(model: item);
            //   },
            final item = snapshot.data!.data; //인덱스값
            return CreatorFeedbackResultCard.fromModel(model: item);
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
