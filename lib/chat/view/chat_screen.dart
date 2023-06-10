import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/provider/chat_user_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../common/const/data.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_user_card.dart';
import '../model/chat_msg/chat_msg_model.dart';
import '../provider/chat_msg_provider.dart';
import '../provider/chat_msgs_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String userId;
  final String roomId;
  final String roomName;

  ChatScreen({
    required this.userId,
    required this.roomId,
    required this.roomName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  StompClient? stompClient;
  late MsgModel msgModel;

  final socketUrl = 'ws://$API_SERVICE_URI/ws';

  clearTextField() {
    _formKey.currentState?.reset();
  }

  onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/exchange/chat.exchange/room.${widget.roomId}',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          MsgModel msgModel = MsgModel.fromJson(json.decode(frame.body!));
          ref
              .read(chatMsgsProvider(widget.roomId).notifier)
              .appendMsg(msgModel);
        }
      },
    );
  }

  sendMessage() async {
    final msgData = ref.watch(chatMsgProvider);

    await sendMsgFunction(
      roomId: widget.roomId,
      userId: widget.userId,
      message: msgData.message,
    );

    ref.read(chatMsgProvider.notifier).clear();
  }

  sendMsgFunction({
    required String roomId,
    required String userId,
    required String message,
  }) {
    setState(() {
      stompClient!.send(
        destination: '/pub/chat.message.$roomId',
        body: json.encode({
          "type": "TALK",
          "roomId": roomId,
          "sender": userId,
          "message": message,
        }),
      );
    });
  }

  @override
  initState() {
    super.initState();
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

  @override
  void dispose() {
    stompClient!.deactivate();
    super.dispose();
  }

  String convertTo12HourFormat(List<int> time) {
    int hour = time[3];
    int minute = time[4];
    String period = '오전';
    if (hour >= 12) {
      period = '오후';
    }
    if (hour > 12) {
      hour = hour - 12;
    }

    return '$period ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String getRoomName(String roomName) {
    return roomList[roomName]!;
  }

  @override
  Widget build(BuildContext context) {
    final String roomId = widget.roomId;
    final String roomName = widget.roomName;

    final data = ref.watch(chatMsgsProvider(roomId));
    final msgData = ref.watch(chatMsgProvider);
    final userList = ref.watch(chatUserProvider(roomId));

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      },
    );

    return DefaultLayout(
      title: "${getRoomName(roomName)} 채팅 방",
      resizeToAvoidBottomInset: true,
      leading: IconButton(
        onPressed: () {
          ref.read(chatMsgsProvider(widget.roomId).notifier).clearMsg();
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  "대화 상대",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatUserCard(userName: userList[index]);
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 16);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Colors.black12,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        top: true,
        bottom: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    if (data[index].type == "ENTER") {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xffEDF0F3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${data[index].sender} 님이 입장하셨습니다.',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                      child: data[index].sender == widget.userId
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    convertTo12HourFormat(
                                      data[index].time!,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'NanumSquareNeo'),
                                  ),
                                  const SizedBox(width: 8),
                                  ChatBubble(
                                    alignment: Alignment.centerRight,
                                    backGroundColor: Colors.blue,
                                    clipper: ChatBubbleClipper8(
                                      type: BubbleType.sendBubble,
                                    ),
                                    child: Text(
                                      data[index].message,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 18.0,
                                  backgroundImage: ExtendedImage.asset(
                                          "asset/img/Profile/BaseProfile.JPG")
                                      .image,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    left: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].sender,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          ChatBubble(
                                            alignment: Alignment.centerLeft,
                                            backGroundColor:
                                                const Color(0xffE7E7ED),
                                            clipper: ChatBubbleClipper8(
                                              type: BubbleType.receiverBubble,
                                            ),
                                            child: Text(
                                              data[index].message,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            convertTo12HourFormat(
                                              data[index].time!,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'NanumSquareNeo'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Color(0xffEDF0F3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: TextFormField(
                              key: _formKey,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                ref
                                    .read(chatMsgProvider.notifier)
                                    .enterMessage(value);
                              },
                              decoration: const InputDecoration(
                                hintText: "Send Message",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffEDF0F3)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffEDF0F3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: msgData.message.isEmpty
                              ? const Color(0xffEDF0F3)
                              : Colors.black,
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: () {
                              if (msgData.message.isNotEmpty) {
                                sendMessage();
                                clearTextField();
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: msgData.message.isEmpty
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5),
                  ],
                ),
              )
            ],
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
