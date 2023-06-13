import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/creator_model.dart';
import '../model/creator_result_model.dart';
import '../model/normal_result_model.dart';

part 'result_repository.g.dart';

final ResultRepositoryProvider = Provider<ResultRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository = ResultRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);

@RestApi()
abstract class ResultRepository {
  factory ResultRepository(Dio dio, {String baseUrl}) = _ResultRepository;

  @GET('/eval/getReplyData')
  @Headers({
    'accessToken': 'true',
  })
  Future<NormalResultModel> resultData({
    @Query('postId') int? postId,
  });

  @GET('/CreatorEval/readByCreatorId')
  @Headers({
    'accessToken': 'true',
  })
  Future<CreatorModel> creatorData({
    @Query('creatorEvalId') int? creatorEvalId,
  });

  @GET('/CreatorData/getReplyData')
  @Headers({
    'accessToken': 'true',
  })
  Future<CreatorResultModel> creatorResultData({
    @Query('postId') int? postId,
  });
}
