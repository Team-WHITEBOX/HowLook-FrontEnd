import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/component/main_feed_comment_card.dart';
import 'package:howlook/feed/model/main_feed_comment_model.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final int npostId;
  const CommentScreen({Key? key, required this.npostId}) : super(key: key);

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
  }

  Future<List> paginateComment() async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
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
    return FutureBuilder<List>(
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
                MainFeedCommentModel.fromJson(item);
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
    );
  }
}
