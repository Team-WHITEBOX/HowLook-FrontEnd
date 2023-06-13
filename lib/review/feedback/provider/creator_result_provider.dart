import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/review/feedback/model/creator_data_model.dart';
import '../model/creator_model.dart';
import '../model/creator_result_data_model.dart';
import '../model/creator_result_model.dart';
import '../model/normal_result_data_model.dart';
import '../model/normal_result_model.dart';
import '../repository/result_repository.dart';

final CreatorResultProvider =
StateNotifierProvider<ResultStateNotifier, CreatorResultModel>(
      (ref) {
    final repository = ref.watch((ResultRepositoryProvider));
    final notifier = ResultStateNotifier(repository: repository);
    return notifier;
  },
);

class ResultStateNotifier extends StateNotifier<CreatorResultModel> {
  // API 요청을 위해 repository 가져오기
  final ResultRepository repository;

  // 외부에서 API 입력 받기위해 required에 넣기
  ResultStateNotifier({
    required this.repository,
  }) : super(CreatorResultModel(data: [])
  );

  Future<List<CreatorResultData>> getCreatorResultData({required int postId}) async {
    final ResultData = await repository.creatorResultData(postId: postId);
    print(ResultData);
    print("object");
    print(ResultData.data);
    return ResultData.data;
  }

  Future<CreatorModel> getCreatorData({required int creatorEvalId}) async {
    final ResultData = await repository.creatorData(creatorEvalId: creatorEvalId);
    print(ResultData);
    print("object");
    print(ResultData.data);
    return ResultData;
  }
}
