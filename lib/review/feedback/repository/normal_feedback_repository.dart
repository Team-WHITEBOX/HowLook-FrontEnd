import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../common/model/params/feedback_params/feedback_params.dart';
import '../model/feedback_model.dart';
import '../model/normal_feedback_model.dart';

part 'normal_feedback_repository.g.dart';

final NormalFeedbackRepositoryProvider = Provider<NormalFeedbackRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository = NormalFeedbackRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);

@RestApi()
abstract class NormalFeedbackRepository {
  factory NormalFeedbackRepository(Dio dio, {String baseUrl}) = _NormalFeedbackRepository;

  @GET('/member/check')
  @Headers({
    'accessToken': 'true',
  })
  Future<FeedbackModel> getMemberId();

  @GET('/eval/readByUserId')
  @Headers({
    'accessToken': 'true',
  })
  Future<NormalFeedbackModel> feedbackData({
    @Query('userID') String? userID,
  });
}
