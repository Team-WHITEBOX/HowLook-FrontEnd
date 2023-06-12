import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/normal_result_model.dart';

part 'normal_result_repository.g.dart';

final NormalResultRepositoryProvider = Provider<NormalResultRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository = NormalResultRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);

@RestApi()
abstract class NormalResultRepository {
  factory NormalResultRepository(Dio dio, {String baseUrl}) = _NormalResultRepository;

  @GET('/eval/getReplyData')
  @Headers({
    'accessToken': 'true',
  })
  Future<NormalResultModel> resultData({
    @Query('postId') int? postId,
  });
}
