import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/page_model.dart';
import '../model/feed_data.dart';
import '../model/feed_params/category_pagination_params.dart';
import '../model/feed_params/detail_feed_params.dart';
import '../model/feed_params/near_pagination_params.dart';
import '../model/feed_params/pagination_params.dart';
import '../model/feed_params/weather_pagination_params.dart';


part 'feed_repository.g.dart';

final feedRepositoryProvider = Provider<FeedRepository>(
  (ref) {
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
  Future<CursorPagination<PageModel>> mPaginate({
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
  Future<CursorPagination<PageModel>> nPaginate({
    @Queries() NearPaginationParams? nearPaginationParams =
        const NearPaginationParams(),
  });

  // Weather Feed API
  @GET('/weather')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<PageModel>> wPaginate({
    @Queries() WeatherPaginationParams? weatherPaginationParams =
    const WeatherPaginationParams(),
  });

  // Category Feed API
  @GET('/search')
  @Headers({
    'accessToken': 'true',
  })
  // API에 쿼리 파라미터 추가하는 방법
  Future<CursorPagination<PageModel>> cPaginate({
    @Queries() CategoryPaginationParams? categoryPaginationParams =
        const CategoryPaginationParams(),
  });

  // Detail Feed API
  @GET('/readbypid')
  @Headers({
    'accessToken': 'true',
  })
  Future<FeedData> getFeedDetail({
    @Queries() DetailFeedParams? detailFeedParams =
    const DetailFeedParams(),
  });

  @DELETE('/{postId}')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json'
  })
  Future<HttpResponse<dynamic>> delPost(@Path('postId') int postId);

  @POST('/like')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json'
  })
  Future<HttpResponse<dynamic>> postLike(@Query('postId') int postId);

  @DELETE('/like')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json'
  })
  Future<HttpResponse<dynamic>> delLike(@Query('postId') int postId);

  @POST('/scrap')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json'
  })
  Future<HttpResponse<dynamic>> postScrap(@Query('postId') int postId);

  @DELETE('/scrap')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json'
  })
  Future<HttpResponse<dynamic>> delScrap(@Query('postId') int postId);
}
