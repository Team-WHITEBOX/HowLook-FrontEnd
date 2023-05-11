import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/user/model/signup_model.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_repository.g.dart';

final signupRepositoryProvider = Provider<SignupRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
    SignupRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);


@RestApi()
abstract class SignupRepository {
  factory SignupRepository(Dio dio, {String baseUrl}) = _SignupRepository;

  // post 함수
  @POST('/account/join')
  @Headers({
    'accessToken': 'true',
  })
  Future<SignupModel> postData({
    @Body() required SignupModel signupModel,
  });

}

