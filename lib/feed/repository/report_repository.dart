import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'report_repository.g.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        ReportRepository(dio, baseUrl: 'http://$API_SERVICE_URI/report');
    return repository;
  },
);

@RestApi()
abstract class ReportRepository {
  factory ReportRepository(Dio dio, {String baseUrl}) = _ReportRepository;

  @POST('/reportpost')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> reportPost(@Query('postId') int postId);
}
