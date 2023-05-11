import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:howlook/common/model/cursor_pagination_model.dart';
import 'package:howlook/common/model/feed_params/near_pagination_params.dart';
import 'package:howlook/feed/repository/feed_repository.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
}

Future<void> onJoin() async {
  await _handleCameraAndMic(Permission.location);
  await _handleCameraAndMic(Permission.locationWhenInUse);
}

Future<Position> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}

final nearfeedProvider =
    StateNotifierProvider<NearFeedStateNotifier, CursorPaginationBase>(
  (ref) {
    final nrepository = ref.watch((feedRepositoryProvider));
    final notifier = NearFeedStateNotifier(nrepository: nrepository);
    return notifier;
  },
);

class NearFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  final FeedRepository nrepository;

  NearFeedStateNotifier({
    required this.nrepository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }
  var gps;
  void paginate({
    int fetchPage = 0,
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try{
      gps = await getCurrentLocation();
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        if (pState.data.totalPages == pState.data.number) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      NearPaginationParams nearpaginationParams = NearPaginationParams(
        page: fetchPage,
        latitude: gps.latitude,
        longitude: gps.longitude,
      );

      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          data: pState.data,
        );

        nearpaginationParams = nearpaginationParams.copyWith(
          page: (pState.data.number + 1),
          longitude: gps.longitude,
          latitude: gps.latitude,
        );
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await nrepository.npaginate(
        nearpaginationParams: nearpaginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(
          data: resp.data.copyWith(
            content: [
              ...pState.data.content,
              ...resp.data.content,
            ],
          ),
        );
      } else {
        state = resp;
      }
    } catch(e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
