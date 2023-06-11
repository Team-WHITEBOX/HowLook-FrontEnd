import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/chat_msg/chat_msg_data.dart';
import '../model/chat_room/chat_room_data.dart';
import '../model/chat_user/chat_user_data.dart';

part 'chat_repository.g.dart';

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        ChatRepository(dio, baseUrl: 'http://$API_SERVICE_URI/chatroom');
    return repository;
  },
);

@RestApi()
abstract class ChatRepository {
  factory ChatRepository(Dio dio, {String baseUrl}) = _ChatRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<ChatRoomsDataModel> getRoomList();

  @DELETE('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> outChatRoom(@Query('roomId') String roomId);

  @GET('/chat')
  @Headers({
    'accessToken': 'true',
  })
  Future<ChatMsgData> getChatList(@Query('roomId') String roomId);

  @GET('/userlist')
  @Headers({
    'accessToken': 'true',
  })
  Future<ChatUserData> getUserList(@Query('roomId') String roomId);
}
