import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feedback/model/normal_feedback_model.dart';
import '../model/normal_review_model.dart';
import '../repository/normal_review_repository.dart';

final ReviewReplyProvider =
StateNotifierProvider<ReviewReplyStateNotifier, NormalFeedbackModel>(
      (ref) {
    final repository = ref.watch((NormalReviewRepositoryProvider));
    final notifier = ReviewReplyStateNotifier(repository: repository);
    return notifier;
  },
);

class ReviewReplyStateNotifier extends StateNotifier<NormalFeedbackModel> {
  // API 요청을 위해 repository 가져오기
  final NormalReviewRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  ReviewReplyStateNotifier({
    required this.repository,
  }) : super(NormalFeedbackModel(status: 0, code: '', message: '', data: [])) {}

  // Future<NormalFeedbackModel> getFeedbackData() async {
  //   final userId = await repository.getMemberId();
  //   final feedbackData = await repository.feedbackData(
  //       userID: userId.data);
  //
  //   return feedbackData;
  // }
}
