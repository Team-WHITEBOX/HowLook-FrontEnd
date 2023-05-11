import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:howlook/user/model/signup_model.dart';
import 'package:retrofit/retrofit.dart';

part 'feed_upload_repository.g.dart';

final feedUploadRepositoryProvider = Provider<FeedUploadRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
    FeedUploadRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);


@RestApi()
abstract class FeedUploadRepository {
  factory FeedUploadRepository(Dio dio, {String baseUrl}) = _FeedUploadRepository;

  // post 함수
  @POST('/post/regist')
  @MultiPart()
  @Headers({
    'accessToken': 'true',
    'Content-Type': 'multipart/form-data'
  })
  Future<HttpResponse<dynamic>> uploadImage({
    @Part(name: "content") required String content,
    @Part(name: "hashtagDTO.amekaji") required bool amekaji,
    @Part(name: "hashtagDTO.casual") required bool casual,
    @Part(name: "hashtagDTO.guitar") required bool guitar,
    @Part(name: "hashtagDTO.minimal") required bool minimal,
    @Part(name: "hashtagDTO.sporty") required bool sporty,
    @Part(name: "hashtagDTO.street") required bool street,
    @Part(name: "latitude") required double latitude,
    @Part(name: "longitude") required double longitude,
    @Part(name: "uploadFileDTO.files") required List<MultipartFile> files,
  });
}

