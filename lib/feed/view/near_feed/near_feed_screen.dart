import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/feed/component/feed_card.dart';
import 'package:howlook/feed/provider/near_feed_provider.dart';
import 'package:howlook/feed/view/feed_detail/feed_detail_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class NearFeedScreen extends ConsumerStatefulWidget {
  const NearFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NearFeedScreen> createState() => _NearFeedScreenState();
}

class _NearFeedScreenState extends ConsumerState<NearFeedScreen> {
  Future<void> _handleCameraAndMic(Permission permission) async {
    await permission.request();
  }

  Future<void> onJoin() async {
    await _handleCameraAndMic(Permission.location);
    await _handleCameraAndMic(Permission.locationWhenInUse);
  }

  final ScrollController controller = ScrollController();

  // 위치 정보 불러오기
  Future<Position> getCurrentLocation() async {
    // onJoin();
    LocationPermission permission = await Geolocator.requestPermission();
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
      return const Center(
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
      onRefresh: () async {
        ref.read(nearfeedProvider.notifier).paginate(
              forceRefetch: true,
            );
      },
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.data.content.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.content.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('마지막 데이터입니다. ㅠㅠ'),
              ),
            );
          }
          // 받아온 데이터 JSON 매핑하기
          // 모델 사용
          final pItem = cp.data.content[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FeedDetailScreen(
                    postId: pItem.postId,
                  ),
                ),
              );
            },
            child: FeedCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
