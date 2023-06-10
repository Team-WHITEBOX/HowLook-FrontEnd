import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/sign_up/id_check_data.dart';
import '../model/sign_up/nick_check_data.dart';
import '../model/sign_up/sign_up_model.dart';

part 'sign_up_repository.g.dart';

final signUpRepositoryProvider = Provider<SignUpRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        SignUpRepository(dio, baseUrl: 'http://$API_SERVICE_URI/account');
    return repository;
  },
);

@RestApi()
abstract class SignUpRepository {
  factory SignUpRepository(Dio dio, {String baseUrl}) = _SignUpRepository;

  @POST('/join')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> postJoin({
    @Body() required SignUpModel signupModel,
  });

  @GET('/idcheck')
  @Headers({
    'accessToken': 'true',
  })
  Future<IdCheckData> idCheck({
    @Query('memberId') required String memberId,
  });

  @GET('/nickcheck')
  @Headers({
    'accessToken': 'true',
  })
  Future<NickCheckData> nickCheck({
    @Query('nickName') required String nickName,
  });
}
