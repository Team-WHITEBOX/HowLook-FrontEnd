import 'package:dio/dio.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:retrofit/retrofit.dart';

part 'main_feed_repository.g.dart';

@RestApi()
abstract class MainFeedRepository {
  factory MainFeedRepository(Dio dio, {String baseurl})
  = _MainFeedRepository;

  // @GET('/')
  // paginate()

  @GET('?NPostId{}')
  Future<MainFeedDetailModel> getMainFeedDetail({
    @Path() required int NPostId,
  });

  // getMainFeedComment()
}