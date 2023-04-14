import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/component/main_feed_comment_card.dart';
import 'package:howlook/feed/model/feed_comment_model.dart';
import 'package:howlook/feed/view/comment_screen.dart';

class FeedCommentScreen extends ConsumerStatefulWidget {
  final int npostId;
  const FeedCommentScreen({
    required this.npostId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FeedCommentScreen> createState() => _FeedCommentScreenState();
}

class _FeedCommentScreenState extends ConsumerState<FeedCommentScreen> {
  bool? isLiked;
  String replyContent = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  const SizedBox(height: 6,),
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
                            final storage = ref.read(secureStorageProvider);
                            final accessToken =
                                await storage.read(key: ACCESS_TOKEN_KEY);
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
                            Navigator.pop(context);
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
                  CommentScreen(
                    npostId: widget.npostId,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
