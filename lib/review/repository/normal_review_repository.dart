import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/review/model/normal_review_model_data.dart';
import 'package:retrofit/http.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/creator_review_model.dart';
import '../model/normal_reply_model.dart';
import '../model/normal_review_model.dart';

part 'normal_review_repository.g.dart';

final NormalReviewRepositoryProvider = Provider<NormalReviewRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        NormalReviewRepository(dio, baseUrl: 'http://$API_SERVICE_URI/eval');
    return repository;
  },
);

@RestApi()
abstract class NormalReviewRepository {
  factory NormalReviewRepository(Dio dio, {String baseUrl}) =
      _NormalReviewRepository;

  @GET('/readNextEval')
  @Headers({
    'accessToken': 'true',
  })
  Future<ReviewModel> reviewData();

  @GET('/readNextEval')
  @Headers({
    'accessToken': 'true',
  })
  Future<CreatorReviewModel> reviewCratorData();

  @POST('/reply/register')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> postNormalReviewReply(
      {@Body() required int postId, required double score});
}
