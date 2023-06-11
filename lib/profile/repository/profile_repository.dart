import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/profile/model/profile/profile_edit_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../user/model/sign_up/sign_up_model.dart';
import '../../user/model/token/token_model.dart';
import '../model/params/my_profile_params.dart';
import '../model/profile/profile_data.dart';
import '../model/profile/profile_edit_data.dart';
import '../model/user_info/check_token_data.dart';

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
  Future<ProfileData> getMyProfile(
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

  @GET('/edit')
  @Headers({
    'accessToken': 'true',
  })
  Future<ProfileEditData> getProfileData();

  @PUT('/edit')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> updateProfileData({
    @Body() required ProfileEditModel profileEditModel,
  });

  @PUT('/socialedit')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> socialEdit({
    @Body() required SignUpModel signupModel,
  });
}
