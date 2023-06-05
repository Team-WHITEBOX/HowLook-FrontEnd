import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/common/model/comment_page_model.dart';
import 'package:howlook/common/model/comment_pagination_model.dart';
import 'package:howlook/common/model/params/comment_params/comment_params.dart';
import 'package:retrofit/retrofit.dart';

part 'comment_repository.g.dart';

final commentRepositoryProvider = Provider<CommentRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        CommentRepository(dio, baseUrl: 'http://$API_SERVICE_URI/replies');
    return repository;
  },
);

@RestApi()
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  @GET('/replyPage/{postId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommentPagination<CommentPageModel>> commentPaginate(
    @Path("postId") int id, {
    @Queries() CommentParams? commentParams = const CommentParams(),
  });

  @POST('/replyPage/like')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> replyPostLike({
    @Body() required int ReplyId,
  });

  @DELETE('/replyPage/like')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> delPostLike({
    @Body() required int ReplyId,
  });
}
