import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/model/cursor_pagination_model.dart';
import '../../../model/feed_params/weather_pagination_params.dart';
import '../../../repository/feed_repository.dart';

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

final weatherFeedProvider =
StateNotifierProvider<WeatherFeedStateNotifier, CursorPaginationBase>(
      (ref) {
    final wRepository = ref.watch((feedRepositoryProvider));
    final notifier = WeatherFeedStateNotifier(wRepository: wRepository);
    return notifier;
  },
);

class WeatherFeedStateNotifier extends StateNotifier<CursorPaginationBase> {
  final FeedRepository wRepository;

  WeatherFeedStateNotifier({
    required this.wRepository,
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

      WeatherPaginationParams weatherPaginationParams = WeatherPaginationParams(
        page: fetchPage,
        latitude: gps.latitude,
        longitude: gps.longitude,
      );

      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          data: pState.data,
        );

        weatherPaginationParams = weatherPaginationParams.copyWith(
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

      final resp = await wRepository.wPaginate(
        weatherPaginationParams: weatherPaginationParams,
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
