import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/http.dart';
import '../model/creator_review_model.dart';
import '../model/normal_review_model.dart';

part 'normal_review_repository.g.dart';

final NormalReviewRepositoryProvider = Provider<NormalReviewRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        NormalReviewRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);

@RestApi()
abstract class NormalReviewRepository {
  factory NormalReviewRepository(Dio dio, {String baseUrl}) =
      _NormalReviewRepository;

  @GET('/eval/readNextEval')
  @Headers({
    'accessToken': 'true',
  })
  Future<ReviewModel> reviewData();

  @GET('/CreatorEval/readNextCreatorEval')
  @Headers({
    'accessToken': 'true',
  })
  Future<CreatorReviewModel> reviewCreatorData();

  @POST('/eval/reply/register')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> postNormalReviewReply({
    @Query('postId') required int postId,
    @Query('score') required double score,
  });

  @POST('/CreatorReply/evalCreator')
  @Headers({
    'accessToken': 'true',
    // 'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> postCreatorReviewReply({
    @Query('postId') required int postId,
    @Query('review') required String review,
    @Query('score') required double score,
  });
}
