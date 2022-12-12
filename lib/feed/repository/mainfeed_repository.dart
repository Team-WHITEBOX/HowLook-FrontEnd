import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/common/model/c_pagination_params.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/n_pagination_params.dart';
import 'package:howlook/common/model/pagination_params.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:retrofit/retrofit.dart';

part 'mainfeed_repository.g.dart';

final mainFeedRepositoryProvider = Provider<MainFeedRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        MainFeedRepository(dio, baseUrl: 'http://$API_SERVICE_URI');
    return repository;
  },
);

@RestApi()
abstract class MainFeedRepository {
  factory MainFeedRepository(Dio dio, {String baseUrl}) = _MainFeedRepository;

  @GET('/feed/recent')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<MainFeedModel>> paginate({
  @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/feed/readbypid?NPostId={NPostId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<MainFeedDetailModel> getMainFeedDetail({
    @Path('NPostId') required int NPostId,
  });

  @GET('/feed/near')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<MainFeedModel>> npaginate({
    @Queries() NearPaginationParams? nearpaginationParams = const NearPaginationParams(),
  });

  @GET('/feed/search')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<MainFeedModel>> cpaginate({
    @Queries() CategoryPaginationParams? categorypaginationParams = const CategoryPaginationParams(),
  });
}
