import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/review/model/review_model_data.dart';
import 'package:retrofit/http.dart';

import '../model/review_model.dart';

part 'normal_review_repository.g.dart';

final NormalReviewRepositoryProvider = Provider<NormalReviewRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository = NormalReviewRepository(dio, baseUrl: 'http://$API_SERVICE_URI/eval');
    return repository;
  },
);

@RestApi()
abstract class NormalReviewRepository {
  factory NormalReviewRepository(Dio dio, {String baseUrl}) = _NormalReviewRepository;

  @GET('/readNextEval')
  @Headers({
    'accessToken': 'true',
  })
  Future<ReviewModel> reviewData();
}
