import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:howlook/user/model/sign_up/sign_up_model.dart';
import 'package:retrofit/retrofit.dart';

part 'upload_repository.g.dart';

final uploadRepositoryProvider = Provider<UploadRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
    UploadRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);


@RestApi()
abstract class UploadRepository {
  factory UploadRepository(Dio dio, {String baseUrl}) = _UploadRepository;

  // post 함수
  @POST('/post/regist')
  @MultiPart()
  @Headers({
    'accessToken': 'true',
    'Content-Type': 'multipart/form-data'
  })
  Future<HttpResponse<dynamic>> feedUploadImage({
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

  // eval regist 함수
  @POST('/eval/registerPost')
  @MultiPart()
  @Headers({
    'accessToken': 'true',
    'Content-Type': 'multipart/form-data'
  })
  Future<HttpResponse<dynamic>> reviewUploadImage({
    @Part(name: "files.files") required List<MultipartFile> files,
  });

  @POST('/CreatorEval/register')
  @MultiPart()
  @Headers({
    'accessToken': 'true',
    'Content-Type': 'multipart/form-data'
  })
  Future<HttpResponse<dynamic>> creatorReviewUploadImage({
    @Part(name: "files.files") required List<MultipartFile> files,
    @Part(name: 'content') required String content,
  });
}

