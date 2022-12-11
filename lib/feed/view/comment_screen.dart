import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/component/main_feed_comment_card.dart';
import 'package:howlook/feed/model/main_feed_comment_model.dart';

class FeedCommentScreen extends StatefulWidget {
  final int npostId;
  const FeedCommentScreen({
    required this.npostId,
    Key? key,
  }) : super(key: key);

  @override
  State<FeedCommentScreen> createState() => _FeedCommentScreenState();
}

class _FeedCommentScreenState extends State<FeedCommentScreen> {
  bool? isLiked;
  String replyContent = '';

  Future<List> paginateComment() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int npostId = widget.npostId;
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/replies/list/$npostId',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 800,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          child: Center(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "게시글 댓글",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Positioned(
                          right: 15,
                          top: 7,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.black,
                            ), // Your desired icon
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: CustomTextFormField(
                        hintText: "댓글을 입력해주세요",
                        icon: IconButton(
                          icon: Icon(Icons.send_outlined),
                          color: PRIMARY_COLOR,
                          onPressed: () async {
                            if (replyContent.length > 1) {
                              final dio = Dio();
                              final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
                              final resp = await dio.post(
                                'http://$API_SERVICE_URI/replies/',
                                options: Options(
                                  headers: {
                                    'authorization': 'Bearer $accessToken',
                                  },
                                ),
                                data: {
                                  'contents': replyContent,
                                  'npostId': widget.npostId,
                                },
                              );
                            } else {
                             return;
                            }
                          },
                        ),
                        onChanged: (String value) {
                          replyContent = value;
                        },
                      ),
                    ),
                    FutureBuilder<List>(
                      future: paginateComment(),
                      builder: (context, AsyncSnapshot<List> snapshot) {
                        // 에러처리
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          );
                        }
                        // 댓글 없을 때
                        if (snapshot.data.toString().length == 2) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: 400,
                              height: 350,
                              child: Text(
                                '댓글이 존재하지 않습니다.',
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            ListView.separated(
                              //scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                // 받아온 데이터 JSON 매핑하기
                                // 모델 사용
                                final item = snapshot.data![index];
                                final pItem =
                                    MainFeedCommentModel.fromJson(json: item);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  child:
                                      FeedCommentCard.fromModel(model: pItem),
                                );
                              },
                              separatorBuilder: (_, index) {
                                return SizedBox(height: 16.0);
                              },
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
