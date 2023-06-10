import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/token/token_data.dart';
import '../model/token/token_model.dart';

part 'sign_in_repository.g.dart';

final signInRepositoryProvider = Provider<SignInRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        SignInRepository(dio, baseUrl: 'http://$API_SERVICE_URI/account');
    return repository;
  },
);

@RestApi()
abstract class SignInRepository {
  factory SignInRepository(Dio dio, {String baseUrl}) = _SignInRepository;

  @POST('/generateToken')
  @Headers({
    'content-type': 'application/json',
  })
  Future<TokenData> generateToken(
    @Body() Map<String, dynamic> member,
  );

  @POST('/refreshToken')
  @Headers({'accessToken': 'true', 'content-type': 'application/json'})
  Future<TokenData> refreshToken({
    @Body() required TokenModel tokenModel,
  });

  @POST('/oauth/{provider}')
  @Headers({})
  Future<TokenData> loginOauth(
    @Path('provider') String provider, {
    @Body() required String token,
  });
}
