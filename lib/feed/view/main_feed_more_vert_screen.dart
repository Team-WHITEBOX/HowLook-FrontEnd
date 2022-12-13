import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';

class MainFeedMoreVertScreen extends ConsumerWidget {
  final String? userId;
  final String memberId;
  final int npostId;

  const MainFeedMoreVertScreen({
    required this.userId,
    required this.memberId,
    required this.npostId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = Dio();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    final storage = ref.read(secureStorageProvider);
                    final accessToken =
                        await storage.read(key: ACCESS_TOKEN_KEY);
                    try {
                      final resp = await dio.post(
                        'http://$API_SERVICE_URI/feed/scrap?npost_id=$npostId',
                        options: Options(
                          headers: {
                            'authorization': 'Bearer $accessToken',
                          },
                        ),
                      );

                      if (resp.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context1) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pop(context1);
                            });
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              content: SizedBox(
                                height: 50,
                                child: Center(
                                    child: SizedBox(
                                  child: new Text("스크랩에 성공하였습니다."),
                                )),
                              ),
                            );
                          },
                        );
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context1) {
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context1);
                          });
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            content: SizedBox(
                              height: 50,
                              child: Center(
                                  child: SizedBox(
                                child: new Text("이미 스크랩한 게시글입니다."),
                              )),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '게시글 스크랩',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (userId == memberId)
                    ? TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context1) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                title: new Text(
                                  '게시글 삭제',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                content: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: SizedBox(
                                      child: new Text("정말 게시글을 삭제하시겠습니까?"),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  new TextButton(
                                    child: new Text(
                                      "삭제",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      final storage = ref.read(secureStorageProvider);
                                      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
                                      try {
                                        print('http://$API_SERVICE_URI/feed/delete?npost_id=$npostId');
                                        final resp = await dio.delete(
                                          'http://$API_SERVICE_URI/feed/delete?npost_id=$npostId',
                                          options: Options(
                                            headers: {
                                              'authorization':
                                                  'Bearer $accessToken',
                                            },
                                          ),
                                        );
                                      } catch (e) {
                                        print("에러");
                                        return;
                                      }
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            title: new Text(
                                              '게시글 삭제',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: SizedBox(
                                                  child:
                                                      new Text("게시글을 삭제하였습니다."),
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              new TextButton(
                                                child: new Text("확인"),
                                                onPressed: () {
                                                  print('ghkr');
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  new TextButton(
                                    child: new Text(
                                      "취소",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '게시글 삭제',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    : Text(''),
              ],
            )),
      ),
    );
  }
}
