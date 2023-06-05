import 'package:flutter/material.dart';
import 'package:howlook/chat/model/chat_room_model.dart';
import 'package:howlook/chat/view/chat_screen.dart';

class ChatRoomCard extends StatelessWidget {
  final String roodId;
  final String roomName;
  final int userCount;
  final bool enter;

  const ChatRoomCard({
    required this.roodId,
    required this.roomName,
    required this.userCount,
    required this.enter,
    Key? key,
  }) : super(key: key);

  factory ChatRoomCard.fromModel({
    required ChatRoomModel model,
  }) {
    return ChatRoomCard(
      roodId: model.roodId,
      roomName: model.roomName,
      userCount: model.userCount,
      enter: model.enter,
    );
  }

  String getRoomName(String roomName) {
    return roomList[roomName]!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: enter
          ? Container()
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },
              child: Container(
                height: 100,
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
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.grey,
                            width: 45,
                            height: 45,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 20),
                          SizedBox(
                            width: 90,
                            height: 35,
                            child: Stack(
                              children: [
                                Text(
                                  "# ${getRoomName(roomName)} 방",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'NanumSquareNeo'),
                                ),
                                const Positioned(
                                  bottom: 8,
                                  child: Text(""),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 5),
                          Text(
                            "$userCount명 참여",
                            style: TextStyle(
                              fontFamily: 'NanumSquareNeo',
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.width / 35,
                            ),
                          )
                        ],
                      ),
                      const Divider(color: Colors.black54),
                      Text(
                        "소개글: ${getRoomName(roomName)} 패션에 대해서 자유롭게 얘기하는 방입니다.",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NanumSquareNeo"),
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
