import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import '../../../common/model/params/feedback_params/feedback_params.dart';
import '../model/normal_feedback_model.dart';
import '../model/normal_feedback_model_data.dart';
import '../repository/normal_feedback_repository.dart';

final NormalFeedbackProvider =
StateNotifierProvider<NormalFeedbackStateNotifier, NormalFeedbackModel>(
      (ref) {
    final repository = ref.watch((NormalFeedbackRepositoryProvider));
    final notifier = NormalFeedbackStateNotifier(repository: repository);
    return notifier;
  },
);

class NormalFeedbackStateNotifier extends StateNotifier<NormalFeedbackModel> {
  // API 요청을 위해 repository 가져오기
  final NormalFeedbackRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  NormalFeedbackStateNotifier({
    required this.repository,
  }) : super(NormalFeedbackModel(status: 0, code: '', message: '', data: [])) {}

}

final memberIdProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(NormalFeedbackRepositoryProvider);
  final feedbackModel = await repository.getMemberId();
  return feedbackModel.data;
});

// final feedbackDataProvider = FutureProvider<NormalFeedbackModel>((ref) async {
//   final repository = ref.watch(NormalFeedbackRepositoryProvider);
//   final feedbackModel = await repository.getMemberId();
//   final feedbackParams = FeedbackParams(userId: feedbackModel.data);
//   final feedbackData = await repository.feedbackData(feedbackParams: feedbackParams);
//   return feedbackData;
// });

final feedbackDataProvider = FutureProvider.family<NormalFeedbackModel, String>((ref, userId) async {
  final repository = ref.watch(NormalFeedbackRepositoryProvider);
  final feedbackParams = FeedbackParams(userId: userId); // FeedbackParams에 userId를 전달
  final feedbackData = await repository.feedbackData(feedbackParams: feedbackParams);
  print(feedbackData);
  return feedbackData;
});


