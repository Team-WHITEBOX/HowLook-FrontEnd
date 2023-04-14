import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/view/category_screen.dart';
import 'package:howlook/feed/view/feed_detail_screen.dart';

class CategoryFeedScreen extends ConsumerStatefulWidget {

  @override
  ConsumerState<CategoryFeedScreen> createState() => _CategoryFeedScreenState();
}

class _CategoryFeedScreenState extends ConsumerState<CategoryFeedScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    // if (controller.offset > controller.position.maxScrollExtent - 300) {
    //   ref.read(mainfeedProvider.notifier).paginate(
    //     fetchMore: true,
    //   );
    // }
  }
  // 페이지네이션 api 호출하여 메인피드 데이터 값 받아오기
  Future<List> paginateMainFeed(WidgetRef ref) async {
    final dio = Dio();
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    int page = 0;
    String gender;

    // final resp = await dio.get(
    //   // MainFeed 관련 api IP주소 추가하기
    //   'http://3.34.164.14:8080/feed/search?amekaji=${widget.arguments.isAmericanCasualChecked}&casual=${widget.arguments.isCasualChecked}&guitar=${widget.arguments.isEtcChecked}&minimal=${widget.arguments.isMinimalChecked}&sporty=${widget.arguments.isSportyChecked}&street=${widget.arguments.isStreetChecked}&heightHigh=${widget.arguments.maxHeight}&heightLow=${widget.arguments.minHeight}&weightHigh=${widget.arguments.maxWeight}&weightLow=${widget.arguments.minWeight}&gender=${gender}&page=${page}',
    //   options: Options(
    //     headers: {
    //       'authorization': 'Bearer $accessToken',
    //     },
    //   ),
    // );
    final List<String> resp = ["Hello"];
    // 응답 데이터 중 data 값만 반환하여 사용하기!!
    // return resp.data['data'];
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '검색 기반 게시글',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FutureBuilder<List>(
          future: paginateMainFeed(ref),
          builder: (context, AsyncSnapshot<List> snapshot) {
            // 에러처리
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              controller: controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                // 받아온 데이터 JSON 매핑하기
                // 모델 사용
                final item = snapshot.data![index];
                final pItem = FeedModel.fromJson(item);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FeedDetailScreen(
                        postId: pItem.postId,
                      ),
                    ));
                  },
                  child: FeedCard.fromModel(model: pItem),
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(height: 16.0);
              },
            );
          },
        ),
      ),
    );
  }
}
