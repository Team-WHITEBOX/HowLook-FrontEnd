// import 'package:dio/dio.dart' hide Headers;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:howlook/common/const/data.dart';
// import 'package:howlook/common/dio/dio.dart';
// import 'package:howlook/profile/model/my_profile_screen_model.dart';
// import 'package:retrofit/retrofit.dart';
//
// // part 'profile_repository.g.dart';
//
// final ProfileRepositoryProvider = Provider<ProfileRepository>(
//       (ref) {
//     final dio = ref.watch(dioProvider);
//     final repository =
//     ProfileRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
//     return repository;
//   },
// );
//
//
// @RestApi()
// abstract class ProfileRepository {
//   factory ProfileRepository(Dio dio, {String baseUrl}) = _ProfileRepository;
//
//   // GET 함수
//   @GET('/member')
//   @Headers({
//     'accessToken': 'true',
//   })
//   Future<MainProfileModel> postData({
//     @Body() required MainProfileModel mainProfileModel,
//   });
// }
//
