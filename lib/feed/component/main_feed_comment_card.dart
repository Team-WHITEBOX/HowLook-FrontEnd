import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/model/main_feed_comment_model.dart';

class MainFeedDetailComment extends StatefulWidget {
  final int npostId;
  const MainFeedDetailComment({
    required this.npostId,
    Key? key,
  }) : super(key: key);

  @override
  State<MainFeedDetailComment> createState() => _MainFeedDetailCommentState();
}

class _MainFeedDetailCommentState extends State<MainFeedDetailComment> {
  Future<List> paginateComment() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int npostId = widget.npostId;
    final resp = await dio.get(
      // MainFeed 관련 api IP주소 추가하기
      'http://$API_SERVICE_URI/replies/list/1', //$npostId',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
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
                    child: Text(
                      "댓글",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                )
              ],
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
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final pItem = MainFeedCommentModel.fromJson(json: item);

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: Image.asset(
                                      //'http://$API_SERVICE_URI/photo/${pItem.profilePhoto}',
                                      'asset/img/Profile/HL1.JPG',
                                      fit: BoxFit.cover,
                                    ).image,
                                    // Image.network()로 추가하기
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${pItem.nickname}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 3,),
                                      Text(pItem.contents),
                                    ],
                                  ),
                                ],
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                ),
                                label: Text(''),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 16.0);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
