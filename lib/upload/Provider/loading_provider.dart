import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:flutter/material.dart';

final newPostInfoProvider =
    StateNotifierProvider<NewPostInfoStateNotifier, PostInfo>(
        (ref) => NewPostInfoStateNotifier());

class NewPostInfoStateNotifier extends StateNotifier<PostInfo> {
  NewPostInfoStateNotifier()
      : super(
          PostInfo(
            loadingIndicator: false,
            uploadModel: UploadModel(),
          ),
        );

  toggleLoadingIndicator(bool isLoading) {
    state = state.copyWith(
      loadingIndicator: isLoading ? true : false,
    );
  }

}

class PostInfo {
  bool? loadingIndicator = false;
  late UploadModel uploadModel;

  PostInfo({
    required this.loadingIndicator,
    required this.uploadModel,
  });

  PostInfo copyWith({
    bool? loadingIndicator,
    UploadModel? uploadModel,
  }) {
    return PostInfo(
      loadingIndicator: loadingIndicator ?? this.loadingIndicator,
      uploadModel: uploadModel ?? this.uploadModel,
    );
  }
}

final styleInfoProvider =
    StateNotifierProvider<StyleInfoStateNotifier, List<Style>>(
        (ref) => StyleInfoStateNotifier());

class StyleInfoStateNotifier extends StateNotifier<List<Style>> {
  StyleInfoStateNotifier() : super(styles);

  selectedStyle(String styleName) {
    // 선택된 친구 외에 값 전부 바꾸기
    state = state.map((e) {
      // 현재 선택되지 않은 값을 선택하게 할 때
      if (styleName == e.styleName) {
        if (e.isSelected!) {
          return e.copyWith(
            color: Colors.black45,
            isSelected: false,
          );
        } else {
          return e.copyWith(
            color: Colors.black,
            isSelected: true,
          );
        }
      } else {
        return e;
      }
    }).toList();
  }

  clear() {
    for (int i = 0; i < styles.length; i++) {
      state[i].isSelected = false;
      state[i].color = Colors.black45;
    }
  }
}

class Style {
  bool? isSelected;
  Color? color;
  final String styleName;

  Style({
    this.color = Colors.black45,
    this.isSelected = false,
    required this.styleName,
  });

  Style copyWith({
    Color? color,
    bool? isSelected,
    String? styleName,
  }) {
    return Style(
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
      styleName: this.styleName,
    );
  }
}

final List<Style> styles = <Style>[
  Style(styleName: '# 아메카지'),
  Style(styleName: '# 미니멀'),
  Style(styleName: '# 캐주얼'),
  Style(styleName: '# 스트릿'),
  Style(styleName: '# 스포티'),
  Style(styleName: '# 기타'),
];
