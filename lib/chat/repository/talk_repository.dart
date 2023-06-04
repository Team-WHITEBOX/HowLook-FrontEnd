import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/talk_data_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'talk_repository.g.dart';

final talkRepositoryProvider = Provider<TalkRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        TalkRepository(dio, baseUrl: 'http://$API_SERVICE_URI/chatroom');
    return repository;
  },
);

@RestApi()
abstract class TalkRepository {
  factory TalkRepository(Dio dio, {String baseUrl}) = _TalkRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<TalkDataModel> getChatList();
}
