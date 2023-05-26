import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:howlook/common/model/comment_page_model.dart';
import 'package:howlook/common/model/comment_pagination_model.dart';
import 'package:howlook/common/model/params/comment_params/comment_params.dart';
import 'package:retrofit/http.dart';

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

  @GET('/list/{postId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommentPagination<CommentPageModel>> commentPaginate({
    @Path("postId") required int id,
    @Queries() CommentParams? commentParams = const CommentParams(),
  });
}
