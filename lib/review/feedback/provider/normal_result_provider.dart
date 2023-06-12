import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../repository/normal_result_repository.dart';

final NormalResultProvider =
StateNotifierProvider<NormalResultStateNotifier, NormalResultModel>(
      (ref) {
    final repository = ref.watch((NormalResultRepositoryProvider));
    final notifier = NormalResultStateNotifier(repository: repository);
    return notifier;
  },
);

class NormalResultStateNotifier extends StateNotifier<NormalResultModel> {
  // API 요청을 위해 repository 가져오기
  final NormalResultRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  NormalResultStateNotifier({
    required this.repository,
  }) : super(NormalResultModel(data:NormalResultData(
    postId: 0,
    mainPhotoPath: '',
    averageScore: 0.0,
    maleScore: 0.0,
    femaleScore: 0.0,
    maxScore: 0.0,
    minScore: 0.0,
    replyCount: 0.0,
    maleCount: 0,
    femaleCount: 0,
    maleScores: [],
    femaleScores: [],
    maleCounts: [],
    femaleCounts: [],
  ),
  ));

  Future<NormalResultModel> getResultData({required int postId}) async {
    final ResultData = await repository.resultData(postId: postId);
    print(ResultData);
    print("object");
    print(ResultData.data);
    return ResultData;
  }
}
