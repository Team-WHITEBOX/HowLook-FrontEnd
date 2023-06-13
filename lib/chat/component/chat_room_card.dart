import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_room/chat_room_model.dart';
import 'package:howlook/chat/provider/chat_user_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../common/const/data.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../model/chat_msg/chat_msg_model.dart';
import '../provider/chat_msgs_provider.dart';
import '../view/chat_screen.dart';

class ChatRoomCard extends ConsumerStatefulWidget {
  final String roomId;
  final String roomName;
  final int userCount;
  final bool enter;

  const ChatRoomCard({
    required this.roomId,
    required this.roomName,
    required this.userCount,
    required this.enter,
    Key? key,
  }) : super(key: key);

  factory ChatRoomCard.fromModel({
    required ChatRoomModel model,
  }) {
    return ChatRoomCard(
      roomId: model.roomId,
      roomName: model.roomName,
      userCount: model.userCount,
      enter: model.enter,
    );
  }

  @override
  ConsumerState<ChatRoomCard> createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends ConsumerState<ChatRoomCard> {
  final socketUrl = 'ws://$API_SERVICE_URI/ws';
  StompClient? stompClient;

  String getRoomName(String roomName) {
    return roomList[roomName]!;
  }

  enterMsgFunction({
    required String roomId,
    required String userId,
    required String message,
  }) {
    setState(() {
      stompClient!.send(
        destination: '/pub/chat.enter.$roomId',
        body: json.encode({
          "type": "ENTER",
          "roomId": roomId,
          "sender": userId,
          "message": message,
        }),
      );
    });
  }

  onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/exchange/chat.exchange/room.${widget.roomId}',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          MsgModel msgModel = MsgModel.fromJson(json.decode(frame.body!));
        }
      },
    );
  }

  initStomp() {
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig(
          url: socketUrl,
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => print(error.toString()),
        ),
      );
      stompClient!.activate();
    }
  }

  delStomp() {
    stompClient!.deactivate();
  }

  String getImageByStyle() {
    if (widget.roomName == "street") {
      return imageLink[0];
    } else if (widget.roomName == "casual") {
      return imageLink[1];
    } else if (widget.roomName == "amekaji") {
      return imageLink[2];
    } else if (widget.roomName == "sporty") {
      return imageLink[3];
    } else {
      return imageLink[4];
    }
  }

  @override
  void initState() {
    super.initState();
    initStomp();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> getUserId() async {
      final storage = ref.watch(secureStorageProvider);
      String? userId = await storage.read(key: USERMID_KEY);
      return userId;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: GestureDetector(
        onTap: () async {
          String? userId = await getUserId();

          if (!mounted) return;
          if (!widget.enter) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Center(
                    child: Text(
                      "${getRoomName(widget.roomName)} 채팅방",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "${getRoomName(widget.roomName)} 패션에 대해서 자유롭게 얘기하는 방입니다.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                const Text(
                                  "참여 인원",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${widget.userCount}/1000명",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: const <Widget>[
                                SizedBox(width: 10),
                                Text(
                                  "개설 날짜",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "2023.06.07 개설",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        // await initStomp();
                        enterMsgFunction(
                          roomId: widget.roomId,
                          userId: userId!,
                          message: "",
                        );
                        ref
                            .read(chatMsgsProvider(widget.roomId).notifier)
                            .getChatMsgList();
                        ref
                            .read(chatUserProvider(widget.roomId).notifier)
                            .getChatUserList(widget.roomId);
                        await delStomp();
                        if (!mounted) return;
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userId: userId,
                              roomId: widget.roomId,
                              roomName: widget.roomName,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "채팅방 입장하기",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "취소",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            await delStomp();
            ref.read(chatMsgsProvider(widget.roomId).notifier).getChatMsgList();
            ref
                .read(chatUserProvider(widget.roomId).notifier)
                .getChatUserList(widget.roomId);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userId: userId!,
                  roomId: widget.roomId,
                  roomName: widget.roomName,
                ),
              ),
            );
          }
        },
        child: widget.enter
            ? Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 7),
                                    )
                                  ],
                                ),
                                child: ExtendedImage.asset(
                                  getImageByStyle(),
                                  width: 65,
                                  height: 65,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              SizedBox(
                                width: 130,
                                height: 50,
                                child: Text(
                                  "# ${getRoomName(widget.roomName)} 방",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'NanumSquareNeo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.userCount}명 참여",
                                  style: TextStyle(
                                    fontFamily: 'NanumSquareNeo',
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffececec),
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 7),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 7),
                                    )
                                  ],
                                ),
                                child: ExtendedImage.asset(
                                  getImageByStyle(),
                                  width: 65,
                                  height: 65,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              SizedBox(
                                width: 130,
                                height: 50,
                                child: Text(
                                  "# ${getRoomName(widget.roomName)} 방",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'NanumSquareNeo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.userCount}명 참여",
                                  style: TextStyle(
                                    fontFamily: 'NanumSquareNeo',
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black54),
                      Text(
                        "소개글: ${getRoomName(widget.roomName)} 패션에 대해서 자유롭게 얘기하는 방입니다.",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                          fontWeight: FontWeight.w500,
                          fontFamily: "NanumSquareNeo",
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Map<String, String> roomList = {
  "amekaji": "아메카지",
  "casual": "캐주얼",
  "minimal": "미니멀",
  "street": "스트릿",
  "sporty": "스포티",
};

List<String> imageLink = [
  "asset/img/chat/chat_1.png",
  "asset/img/chat/chat_2.png",
  "asset/img/chat/chat_3.png",
  "asset/img/chat/chat_4.png",
  "asset/img/chat/chat_5.png",
];
