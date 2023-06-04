import 'package:dio/dio.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:howlook/upload/repository/upload_repository.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod/riverpod.dart';

final selectedImageProvider =
    StateNotifierProvider<SelectedImageStateNotifier, List<SelectedImageInfo>>(
  (ref) {
    final repository = ref.watch((uploadRepositoryProvider));
    final notifier = SelectedImageStateNotifier(repository: repository);
    return notifier;
  },
);

class SelectedImageStateNotifier
    extends StateNotifier<List<SelectedImageInfo>> {
  final UploadRepository repository;

  SelectedImageStateNotifier({
    required this.repository,
  }) : super([]);

  // 상태 초기화 함수
  void clearImage() {
    state.clear();
  }

  // 이미지 선택하는 함수
  void selectImage(AssetEntity image, bool isReviewUpload) {
    final addedImageCheck = state.any((e) => _addedImageCheck(image, e.image));
    // 중복 이미지 확인 후 이미지 추가
    if (addedImageCheck) {
      state.removeWhere((element) => _addedImageCheck(image, element.image));
    } else if (!isReviewUpload) {
      // 피드 업로드일 경우
      // 중복이 아니라면 이때 한번 더 사진이 4장 이상인지 걸러야함
      if (state.length > 3) {
        return;
      }
      final item = SelectedImageInfo(
        image: image,
        isSelected: false,
        isEdited: false,
        path: "",
      );
      // state.add(item);
      state = [...state, item];
    } else {
      // 평가 업로드일 경우
      if (state.length >= 1) {
        return;
      } else {
        final item = SelectedImageInfo(
          image: image,
          isSelected: false,
          isEdited: false,
          path: "",
        );
        state = [...state, item];
      }
    }
  }

  // 선택된 이미지가 추가된 이미지인지 확인하기 위함
  bool _addedImageCheck(AssetEntity image, AssetEntity compareImage) {
    return image == compareImage;
  }

  // 이미지 크기 조절을 위해 선택하는 함수
  void selectImageForEdited(AssetEntity image) {
    // 선택된 이미지에 해당하는 클래스를 state(List)에서 찾고 isSelected 값 True로 바꾸기
    state = state
        .map(
          (e) => e.image == image
              ? SelectedImageInfo(
                  image: e.image,
                  isSelected: true,
                  isEdited: e.isEdited,
                  path: e.path,
                )
              : SelectedImageInfo(
                  image: e.image,
                  isSelected: false,
                  isEdited: e.isEdited,
                  path: e.path,
                ),
        )
        .toList();
  }

  bool hasSelectedValue() {
    return state.any((element) => element.isSelected);
  }

  // state의 편집되지 않은 사진이 존재하면 true 반환
  //                          없다면 false 반환
  bool hasEditedValue() {
    return state.any((element) => !element.isEdited);
  }

  void setEdited(SelectedImageInfo e, String path) {
    // 해당 클래스의 경로에 캡처 파일 경로 저장
    e.path = path;
    // 편집 여부 true 변경
    e.isEdited = true;
    // 해당 이미지 이름 저장
    e.imageName = path.split('/').last;
  }

  void setFaceDetection(
    SelectedImageInfo e,
    String imageName,
    String afterOutPath,
    String afterInPath,
  ) {
    state = state
        .map(
          (e) => e.imageName == imageName
              ? SelectedImageInfo(
                  image: e.image,
                  isSelected: e.isSelected,
                  isEdited: e.isEdited,
                  path: e.path,
                  imageName: e.imageName,
                  afterDetectionOutPath: afterOutPath,
                  afterDetectionInPath: afterInPath,
                )
              : SelectedImageInfo(
                  image: e.image,
                  isSelected: e.isSelected,
                  isEdited: e.isEdited,
                  path: e.path,
                  imageName: e.imageName,
                  afterDetectionOutPath: e.afterDetectionOutPath,
                  afterDetectionInPath: e.afterDetectionInPath,
                ),
        )
        .toList();
  }

  void setEditedClear() {
    state = state
        .map(
          (e) => SelectedImageInfo(
            image: e.image,
            isSelected: e.isSelected,
            isEdited: e.isEdited = false,
            path: e.path = '',
            imageName: e.imageName = '',
            afterDetectionOutPath: e.afterDetectionOutPath = '',
            afterDetectionInPath: e.afterDetectionInPath = '',
          ),
        )
        .toList();
  }

  Future<HttpResponse> feedUploadImage(
      UploadModel uploadModel, List<MultipartFile> files) async {
    final resp = await repository.feedUploadImage(
      content: uploadModel.content!,
      amekaji: uploadModel.hashtagAmekaji!,
      casual: uploadModel.hashtagCasual!,
      guitar: uploadModel.hashtagGuitar!,
      minimal: uploadModel.hashtagMinimal!,
      sporty: uploadModel.hashtagSporty!,
      street: uploadModel.hashtagStreet!,
      latitude: uploadModel.latitude!,
      longitude: uploadModel.longitude!,
      files: files,
    );
    return resp;
  }

  Future<HttpResponse> reviewUploadImage(
      UploadModel uploadModel, List<MultipartFile> files) async {
    final resp = await repository.reviewUploadImage(files: files);
    return resp;
  }
}

class SelectedImageInfo {
  AssetEntity image;
  bool isSelected = false;
  bool isEdited = false;
  String path = "";
  String? imageName = "";
  String? afterDetectionOutPath = "";
  String? afterDetectionInPath = "";

  SelectedImageInfo({
    required this.image,
    required this.isSelected,
    required this.isEdited,
    required this.path,
    this.imageName = "",
    this.afterDetectionOutPath = "",
    this.afterDetectionInPath = "",
  });
}
