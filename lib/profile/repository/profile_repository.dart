import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../user/model/sign_up/sign_up_model.dart';
import '../../user/model/token/token_model.dart';
import '../model/check_token_data.dart';
import '../model/my_profile_data.dart';
import '../model/params/my_profile_params.dart';

part 'profile_repository.g.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        ProfileRepository(dio, baseUrl: 'http://$API_SERVICE_URI/member');
    return repository;
  },
);

@RestApi()
abstract class ProfileRepository {
  factory ProfileRepository(Dio dio, {String baseUrl}) = _ProfileRepository;

  // GET 함수
  @GET('/{memberId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserInfoData> getMyProfile(
    @Path('memberId') String memberId, {
    @Queries() required MyProfileParams myProfileParams,
  });

  @GET('/check')
  @Headers({
    'accessToken': 'true',
  })
  Future<CheckTokenData> checkToken();

  @DELETE('/logout')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> logout({
    @Body() required TokenModel tokenModel,
  });

  @PUT('/socialedit')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> socialEdit({
    @Body() required SignUpModel signupModel,
  });
}
