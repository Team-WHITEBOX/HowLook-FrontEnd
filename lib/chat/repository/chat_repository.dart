import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_msg_data.dart';
import 'package:howlook/chat/model/chat_msg_model.dart';
import 'package:howlook/chat/model/chat_rooms_data_model.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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
  Future<ChatRoomsDataModel> outChatRoom();

  @GET('/chat')
  @Headers({
    'accessToken': 'true',
  })
  Future<ChatMsgData> getChatList(@Query('roomId') String roomId);

  @GET('/userlist')
  @Headers({
    'accessToken': 'true',
  })
  Future<ChatRoomsDataModel> getUserList(@Query('roomId') String roomId);
}
