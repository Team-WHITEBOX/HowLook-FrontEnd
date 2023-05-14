import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/view/feed_detail_screen.dart';
import 'package:howlook/feed/provider/main_feed_provider.dart';
import 'package:howlook/feed/repository/feed_repository.dart';
import 'package:howlook/feed/provider/category_feed_provider.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';

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
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(mainfeedProvider.notifier).paginate(
        fetchMore: true,
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    // 따로 autoDispose 설정하지 않으면 한번 생성된 이후로 데이터가 날아가지 않고 캐싱된다.
    final data = ref.watch(categoryfeedProvider);

    // 완전 처음 로딩일 떄
    if (data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPagination;

     return RefreshIndicator(
         onRefresh: () async{
           ref.read(categoryfeedProvider.notifier).paginate(
             forceRefetch: true,
           );
         },
       child: DefaultLayout(
         title: '검색 기반 게시글',
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
           child: ListView.separated(
             controller: controller,
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             itemCount: cp.data.content.length + 1,
             itemBuilder: (_, index) {
               if (index == cp.data.content.length) {
                 return Padding(
                   padding:
                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                   child: Center(
                     child: data is CursorPaginationFetchingMore
                         ? CircularProgressIndicator()
                         : Text('마지막 데이터입니다. ㅠㅠ'),
                   ),
                 );
               }
               // 받아온 데이터 JSON 매핑하기
               // 모델 사용
               // final item = snapshot.data![index];
               final item = cp.data.content[index];
               final pItem = FeedModel.fromJson(item.toJson());
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
           )
         ),
       )
     );
  }
}
