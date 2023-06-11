import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/main_review_model.dart';

part 'main_review_repository.g.dart';

final mainReviewRepositoryProvider = Provider<MainReviewRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository = MainReviewRepository(dio, baseUrl: 'http://$API_SERVICE_URI/eval');
    return repository;
  },
);

@RestApi()
abstract class MainReviewRepository {
  factory MainReviewRepository(Dio dio, {String baseUrl}) = _MainReviewRepository;

  @GET('/getEvalCount')
  @Headers({
    'accessToken': 'true',
  })
  Future<MainReviewModel> reviewCount();

}
