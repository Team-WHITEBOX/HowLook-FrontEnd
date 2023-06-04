import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

final getImageProvider =
    StateNotifierProvider<GetImageStateNotifier, List<AssetEntity>>(
        (ref) => GetImageStateNotifier());

class GetImageStateNotifier extends StateNotifier<List<AssetEntity>> {
  GetImageStateNotifier() : super([]) {
    checkPermission();
  }

  List<AssetPathEntity>? paths; // 모든 파일 정보
  List<Album> albums = []; // 앨범 목록
  int _currentPage = 0; // 현재 페이지
  Album? currentAlbum; // 현재 앨범

  // 갤러리 접근 권한
  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth || ps == PermissionState.limited) {
      // 권한 수락
      await getAlbum();
    } else {
      // 권한 거절
      await PhotoManager.openSetting();
    }
  }

  // 앨범 정보 가져오기
  Future<void> getAlbum() async {
    paths = await PhotoManager.getAssetPathList(
      // 앨범 불러오기
      type: RequestType.image, // 이미지, 비디오, 오디오 불러오기
      filterOption: FilterOptionGroup(
        // 불러올 파일의 조건 지정
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(minHeight: 500, minWidth: 500),
        ),
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      ),
    );

    albums = paths!.map((e) {
      return Album(
        id: e.id,
        name: e.isAll ? '모든 사진' : e.name,
      );
    }).toList();

    await getPhotos(albums[0], albumChange: true);
  }

  // 앨범에서 사진 가져올 때
  Future<void> getPhotos(
    Album album, {
    bool albumChange = false,
  }) async {
    currentAlbum = album;
    albumChange ? _currentPage = 0 : _currentPage++;

    final getAlbum = paths!.singleWhere((element) => element.id == album.id);
    final loadImages = await paths!
        .singleWhere((AssetPathEntity e) => e.id == album.id)
        .getAssetListPaged(
          page: _currentPage,
          size: 20,
        );

    if (albumChange) {
      // 앨범 바뀔 때
      state = loadImages;
    } else {
      // 앨범 안 바뀌고 값 불러올 때
      state = state + loadImages;
    }
  }
}

class Album {
  String id;
  String name;

  Album({
    required this.id,
    required this.name,
  });
}
