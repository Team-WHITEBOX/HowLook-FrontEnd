import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import '../../../common/model/params/feedback_params/feedback_params.dart';
import '../model/creator_feedback_model.dart';
import '../model/normal_feedback_model.dart';
import '../model/normal_feedback_model_data.dart';
import '../repository/feedback_repository.dart';

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

  Future<NormalFeedbackModel> getFeedbackData() async {
    final userId = await repository.getMemberId();
    final feedbackData = await repository.feedbackData(
        userID: userId.data);

    return feedbackData;
  }

  Future<CreatorFeedbackModel> getCreatorFeedbackData() async {
    final userId = await repository.getMemberId();
    final feedbackData = await repository.feedbackCreatorData(
        userId: userId.data);

    return feedbackData;
  }
}
