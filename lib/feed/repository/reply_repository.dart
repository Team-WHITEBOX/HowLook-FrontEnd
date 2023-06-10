import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/reply_page_model.dart';
import '../../common/model/reply_pagination_model.dart';
import '../model/reply_params/post_reply_params.dart';
import '../model/reply_params/reply_params.dart';

part 'reply_repository.g.dart';

final replyRepositoryProvider = Provider<ReplyRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        ReplyRepository(dio, baseUrl: 'http://$API_SERVICE_URI/replies');
    return repository;
  },
);

@RestApi()
abstract class ReplyRepository {
  factory ReplyRepository(Dio dio, {String baseUrl}) = _ReplyRepository;

  @GET('/replyPage/{postId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<ReplyPagination<ReplyPageModel>> replyPaginate(
    @Path("postId") int id, {
    @Queries() ReplyParams? replyParams = const ReplyParams(),
  });

  @POST('/')
  @Headers({'accessToken': 'true', 'content-type': 'application/json'})
  Future<HttpResponse<dynamic>> postReply({
    @Body() required PostReplyParams postReplyParams,
  });

  @DELETE('/{ReplyId}')
  @Headers({'accessToken': 'true', 'content-type': 'application/json'})
  Future<HttpResponse<dynamic>> deleteReply(
    @Path('ReplyId') int replyId, {
    @Query('ReplyId') required int id,
  });

  @POST('/like')
  @Headers({'accessToken': 'true', 'content-type': 'application/json'})
  Future<HttpResponse<dynamic>> replyPostLike(@Query('ReplyId') int replyId);

  @DELETE('/like')
  @Headers({'accessToken': 'true', 'content-type': 'application/json'})
  Future<HttpResponse<dynamic>> delPostLike(@Query('ReplyId') int replyId);
}
