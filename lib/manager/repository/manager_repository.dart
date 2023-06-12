import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';


import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/manager_pagination_model.dart';
import '../model/params/manager_pagination_params.dart';

part 'manager_repository.g.dart';

final managerRepositoryProvider = Provider<ManagerRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        ManagerRepository(dio, baseUrl: 'http://$MANAGER_SERVICE_URI/report');
    return repository;
  },
);

@RestApi()
abstract class ManagerRepository {
  factory ManagerRepository(Dio dio, {String baseUrl}) = _ManagerRepository;

  @GET('')
  @Headers({})
  Future<ManagerPagination> paginate({
    @Queries() required ManagerPaginationParams managerPaginationParams,
  });

  @DELETE('/reject')
  @Headers({})
  Future<HttpResponse<dynamic>> delReject({
    @Query('postId') required int postId,
  });
}
