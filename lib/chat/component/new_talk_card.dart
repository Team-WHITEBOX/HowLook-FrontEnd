import 'package:flutter/material.dart';
import 'package:howlook/chat/model/new_talk_model.dart';

class NewTalkCard extends StatelessWidget {
  final String roodId;
  final String roomName;
  final int userCount;
  final bool enter;

  const NewTalkCard({
    required this.roodId,
    required this.roomName,
    required this.userCount,
    required this.enter,
    Key? key,
  }) : super(key: key);

  factory NewTalkCard.fromModel({
    required NewTalkModel model,
  }) {
    return NewTalkCard(
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
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
                  SizedBox(width: MediaQuery.of(context).size.width / 3.5),
                  Text(
                    "$userCount명 참여",
                    style: const TextStyle(
                      fontFamily: 'NanumSquareNeo',
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                    ),
                  )
                ],
              ),
              const Divider(color: Colors.black54),
              Text(
                "소개글: ${getRoomName(roomName)} 패션에 대해서 자유롭게 얘기하는 방입니다.",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "NanumSquareNeo"
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
