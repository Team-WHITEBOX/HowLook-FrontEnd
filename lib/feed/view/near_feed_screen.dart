import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/feed/component/main_feed_card.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/provider/near_feed_provider.dart';
import 'package:howlook/feed/view/main_feed_detail_screen.dart';

class NearFeedScreen extends ConsumerStatefulWidget {
  const NearFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NearFeedScreen> createState() => _NearFeedScreenState();
}

class _NearFeedScreenState extends ConsumerState<NearFeedScreen> {
  final ScrollController controller = ScrollController();
  // 위치 정보 불러오기
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(nearfeedProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(nearfeedProvider);

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

    return DefaultLayout(
      title: '지역 기반 게시글',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: RefreshIndicator(
          onRefresh: ()async {
            ref.read(nearfeedProvider.notifier).paginate(
              forceRefetch: true,
            );
          },
          child: ListView.separated(
            controller: controller,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: cp.data.length + 1,
            itemBuilder: (_, index) {
              if (index == cp.data.length) {
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
              final pItem = cp.data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MainFeedDetailScreen(
                      npostId: pItem.npostId,
                    ),
                  ));
                },
                child: MainFeedCard.fromModel(model: pItem),
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(height: 16.0);
            },
          ),
        ),
      ),
    );
  }
}