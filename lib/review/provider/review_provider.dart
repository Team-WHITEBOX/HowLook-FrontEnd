import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/main_review_model.dart';
import '../repository/main_review_repository.dart';

final ReviewProvider =
StateNotifierProvider<ReviewStateNotifier, MainReviewModel>(
      (ref) {
    final repository = ref.watch((mainReviewRepositoryProvider));
    final notifier = ReviewStateNotifier(repository: repository);
    return notifier;
  },
);

class ReviewStateNotifier extends StateNotifier<MainReviewModel> {
  // API 요청을 위해 repository 가져오기
  final MainReviewRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  ReviewStateNotifier({
    required this.repository,
  }) : super(MainReviewModel(status: 0, code: '', message: '', data: 0,)
  );

  Future<MainReviewModel> getReviewCount() async {
    final count = await repository.reviewCount();
    return count;
  }

  Future<MainReviewModel> getCreatorCount() async {
    final ResultData = await repository.creatorCount();
    return ResultData;
    // }
  }
}
