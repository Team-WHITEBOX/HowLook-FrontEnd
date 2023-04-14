import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/common/model/feed_params/category_pagination_params.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/feed_params/detail_feed_params.dart';
import 'package:howlook/common/model/feed_params/near_pagination_params.dart';
import 'package:howlook/common/model/feed_params/pagination_params.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/model/page_model.dart';
import 'package:retrofit/retrofit.dart';

part 'feed_repository.g.dart';

final FeedRepositoryProvider = Provider<FeedRepository>(
  (ref) {
    // dio를 dioProvider에서 가져오기
    // Provider에서는 watch쓰는게 좋음 -> watch하는 Provider가 변경됐을때 바로 인지해서 새로 가져올 수 있기 때문
    final dio = ref.watch(dioProvider);
    final repository = FeedRepository(dio, baseUrl: 'http://$API_SERVICE_URI/post');
    return repository;
  },
);

@RestApi()
abstract class FeedRepository {
  factory FeedRepository(Dio dio, {String baseUrl}) = _FeedRepository;

  // Recent Feed API
  @GET('/recent')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법 - PaginationParams 클래스로 정의
  Future<CursorPagination<PageModel>> paginate({
    // @Quaries()로 annotation할 시 해당 클래스를 쿼리 파라미터로 사용 가능
    // 첫번째 요청에는 안 넣어도 되지만 이후부터 값을 입력해야하기 때문에 우선 ?(null 가능)로 선언
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // Near Feed API
  @GET('/near')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<PageModel>> npaginate({
    @Queries() NearPaginationParams? nearpaginationParams =
        const NearPaginationParams(),
  });

  // Category Feed API
  @GET('/search')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<PageModel>> cpaginate({
    @Queries() CategoryPaginationParams? categorypaginationParams =
        const CategoryPaginationParams(),
  });

  // Detail Feed API
  @GET('/readbypid')
  @Headers({
    'accessToken': 'true',
  })
  Future<FeedModel> getFeedDetail({
    @Queries() DetailFeedParams? detailfeedParams =
    const DetailFeedParams(),
  });
}
