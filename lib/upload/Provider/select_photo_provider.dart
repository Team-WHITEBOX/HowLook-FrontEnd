import 'package:flutter/material.dart';
import 'package:howlook/main.dart';
import 'package:howlook/upload/view/upload_image_edited_screen.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod/riverpod.dart';

final SelectedImageProvider =
    StateNotifierProvider<SelectedImageStateNotifier, List<SelectedImageInfo>>(
        (ref) => SelectedImageStateNotifier());

class SelectedImageStateNotifier
    extends StateNotifier<List<SelectedImageInfo>> {
  SelectedImageStateNotifier() : super([]);

  // 이미지 선택하는 함수
  void selectImage(AssetEntity image) {
    final addedImageCheck = state.any((e) => _addedImageCheck(image, e.image));
    // 중복 이미지 확인 후 이미지 추가
    if (addedImageCheck) {
      state.removeWhere((element) => _addedImageCheck(image, element.image));
    } else {
      final item = SelectedImageInfo(
        image: image,
        isSelected: false,
        isEdited: false,
        path: "",
      );
      // state.add(item);
      state = [...state, item];
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
        .map((e) => e.image == image
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
              ))
        .toList();
  }

  bool hasValue() {
    return state.any((element) => element.isSelected);
  }

  gotoImageEdited() async {
    final context = CandyGlobalVariable.naviagatorState.currentContext;

    Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (context) => UploadImageEditedScreen(),
      ),
    );
  }
}

class SelectedImageInfo {
  AssetEntity image;
  bool isSelected = false;
  bool isEdited = false;
  String path = "";

  SelectedImageInfo({
    required this.image,
    required this.isSelected,
    required this.isEdited,
    required this.path,
  });
}
