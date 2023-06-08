import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/model/chat_msg_model.dart';
import 'package:howlook/chat/provider/chat_msg_provider.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatScreen extends ConsumerStatefulWidget {
  bool enter;
  final bool isFirst;
  final String userId;
  final String roomId;
  final String roomName;

  ChatScreen({
    required this.userId,
    required this.isFirst,
    required this.enter,
    required this.roomId,
    required this.roomName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  bool enter = false;
  StompClient? stompClient;
  late MsgModel msgModel;

  final socketUrl = 'ws://$API_SERVICE_URI/ws';

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/exchange/chat.exchange/room.${widget.roomId}',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          MsgModel msgModel = MsgModel.fromJson(json.decode(frame.body!));
          ref.read(chatMsgProvider(widget.roomId).notifier).appendMsg(msgModel);
        }
      },
    );
  }

  sendMessage() {
    // 첫 입장이면 두개 동시에 보내기
    if (enter == false) {
      setState(() {
        stompClient!.send(
          destination: '/pub/chat.enter.${widget.roomId}',
          body: json.encode({
            "type": "ENTER",
            "roomId": widget.roomId,
            "sender": widget.userId,
            "message": _textController.value.text,
          }),
        );
        stompClient!.send(
          destination: '/pub/chat.message.${widget.roomId}',
          body: json.encode({
            "type": "TALK",
            "roomId": widget.roomId,
            "sender": widget.userId,
            "message": _textController.value.text,
          }),
        );
      });
    } else {
      setState(() {
        stompClient!.send(
          destination: '/pub/chat.message.${widget.roomId}',
          body: json.encode({
            "type": "TALK",
            "roomId": widget.roomId,
            "sender": widget.userId,
            "message": _textController.value.text,
          }),
        );
      });
    }

    // 첫 입장 데이터가 false이면 true로 바꾸고 true면 그대로 두기
    widget.enter == false ? enter = true : enter = true;
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
  Widget build(BuildContext context) {
    final String roomId = widget.roomId;
    final String roomName = widget.roomName;

    final data = ref.watch(chatMsgProvider(roomId));

    return DefaultLayout(
      title: roomName,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (data[index].type == "ENTER") {
                      return Center(
                        child: Container(
                          width: 190,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${data[index].sender} 님이 입장하셨습니다.',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }
                    return ChatBubble(
                      alignment: data[index].sender == widget.userId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      backGroundColor: data[index].sender == widget.userId
                          ? Colors.blue
                          : const Color(0xffE7E7ED),
                      clipper: ChatBubbleClipper6(
                        type: data[index].sender == widget.userId
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      child: Text(
                        data[index].message,
                        style: TextStyle(
                          color: data[index].sender == widget.userId
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
            ),
            Container(
              height: 70,
              decoration: const BoxDecoration(color: Color(0xffEDF0F3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Send Message",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEDF0F3)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEDF0F3)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: IconButton(
                        onPressed: sendMessage,
                        icon: Icon(
                          Icons.send,
                          color:
                              _textController.value.text.isEmpty ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
