import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/isCreator_model.dart';
import '../repository/main_review_repository.dart';


final MainReviewProvider =
StateNotifierProvider<MainReviewStateNotifier, IsCreatorModel>(
      (ref) {
    final repository = ref.watch((mainReviewRepositoryProvider));
    final notifier = MainReviewStateNotifier(repository: repository);
    return notifier;
  },
);

class MainReviewStateNotifier extends StateNotifier<IsCreatorModel> {
  // API 요청을 위해 repository 가져오기
  final MainReviewRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  MainReviewStateNotifier({
    required this.repository,
  }) : super(IsCreatorModel(status: 0, code: '', message: '', data: false)) {}

  Future<bool> checkIsCreator() async {
    final check = await repository.checkCreator();

    return check.data;
  }
}
